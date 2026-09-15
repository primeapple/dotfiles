// dcg-guard.ts — block destructive shell commands with dcg
// https://github.com/Dicklesworthstone/destructive_command_guard
import { spawn } from "node:child_process";
import { appendFileSync, mkdirSync, readFileSync, statSync } from "node:fs";
import { homedir } from "node:os";
import { dirname, join } from "node:path";
import type { ExtensionAPI } from "@earendil-works/pi-coding-agent";
import { Type } from "typebox";

const DCG_BIN = process.env.DCG_BIN ?? "dcg";

// Fail open when dcg itself cannot run (not installed, fd exhaustion, ...),
// so a broken install never wedges Pi. Flip this to { deny: true, ... } to
// fail closed instead.
const UNAVAILABLE = { deny: false, reason: "" };

// Blocked commands are appended here as JSON lines so the count is queryable
// via the dcg_blocks tool (and /dcg-stats command).
const LOG_FILE = join(
  process.env.XDG_STATE_HOME ?? join(homedir(), ".local", "state"),
  "pi",
  "dcg-blocks.jsonl",
);

interface BlockRecord {
  ts: string;
  sessionId: string | null;
  cwd: string;
  toolCallId: string;
  command: string;
  ruleId: string | null;
  reason: string;
}

function dcgDecision(command: string): Promise<{ deny: boolean; reason: string }> {
  return new Promise((resolve) => {
    // Resolve exactly once: "error" and "close" can both fire, and a
    // synchronous spawn failure must not race a later event.
    let settled = false;
    const settle = (decision: { deny: boolean; reason: string }) => {
      if (settled) return;
      settled = true;
      resolve(decision);
    };

    // Pi runs on Bun, and Bun's spawn() differs from Node in two ways that
    // matter here: a failed posix_spawn (ENOENT, ENFILE, EAGAIN, ...) is
    // thrown synchronously from spawn() rather than delivered as an "error"
    // event, and when the stdio pipes cannot be set up the returned child can
    // have no `stdout` at all. Handle both, or the extension crashes and the
    // host aborts the tool call instead of failing open.
    let child;
    try {
      child = spawn(DCG_BIN, ["--robot", "test", command], {
        stdio: ["ignore", "pipe", "ignore"],
      });
    } catch {
      settle(UNAVAILABLE);
      return;
    }

    let stdout = "";
    child.stdout?.on("data", (chunk) => {
      stdout += chunk.toString();
    });

    child.on("error", () => settle(UNAVAILABLE));

    child.on("close", (code) => {
      if (code === 1) {
        // Denied. The reason lives in the robot-mode JSON; if the stdout
        // pipe was missing the exit code is still authoritative.
        let reason = "Blocked by dcg (destructive command).";
        let ruleId: string | null = null;
        try {
          const parsed = JSON.parse(stdout);
          if (parsed?.reason) reason = parsed.reason;
          if (parsed?.rule_id) {
            ruleId = parsed.rule_id;
            reason += ` [${parsed.rule_id}]`;
          }
        } catch {
          /* keep the default reason */
        }
        settle({ deny: true, reason });
      } else {
        // 0 = allowed; >=3 = dcg error -> fail open.
        settle(UNAVAILABLE);
      }
    });
  });
}

function recordBlock(rec: Omit<BlockRecord, "ts">) {
  try {
    mkdirSync(dirname(LOG_FILE), { recursive: true });
    appendFileSync(LOG_FILE, JSON.stringify({ ts: new Date().toISOString(), ...rec }) + "\n");
  } catch {
    // Logging must never break the guard.
  }
}

function readBlocks(): BlockRecord[] {
  try {
    return readFileSync(LOG_FILE, "utf8")
      .split("\n")
      .filter((l) => l.trim())
      .map((l) => {
        try {
          return JSON.parse(l) as BlockRecord;
        } catch {
          return null;
        }
      })
      .filter((r): r is BlockRecord => r !== null);
  } catch {
    return [];
  }
}

function formatStats(blocks: BlockRecord[], sessionId: string | null): string {
  const byRule = new Map<string, number>();
  for (const b of blocks) byRule.set(b.ruleId ?? "unknown", (byRule.get(b.ruleId ?? "unknown") ?? 0) + 1);
  const thisSession = sessionId ? blocks.filter((b) => b.sessionId === sessionId).length : blocks.length;
  const ruleSummary = [...byRule.entries()].map(([r, n]) => `  ${r}: ${n}`).join("\n");
  const recent = blocks
    .slice(-5)
    .reverse()
    .map((b) => `  ${b.ts} [${b.ruleId ?? "-"}] ${b.command.slice(0, 120)}${b.command.length > 120 ? "…" : ""} (${b.cwd})`)
    .join("\n");
  try {
    const created = statSync(LOG_FILE).birthtime.toISOString();
    return `Total blocks since ${created}: ${blocks.length}
This session: ${thisSession}
By rule:\n${ruleSummary || "  (none)"}
Recent:\n${recent || "  (none)"}`;
  } catch {
    return `Total blocks: ${blocks.length}\nThis session: ${thisSession}\nBy rule:\n${ruleSummary || "  (none)"}\nRecent:\n${recent || "  (none)"}`;
  }
}

export default function (pi: ExtensionAPI) {
  pi.on("tool_call", async (event, ctx) => {
    if (event.toolName !== "bash") return;
    const command = String(event.input?.command ?? "");
    if (!command.trim()) return;

    let decision;
    try {
      decision = await dcgDecision(command);
    } catch {
      // Anything unexpected inside the guard is a guard failure, not a
      // reason to abort the tool call.
      decision = UNAVAILABLE;
    }
    if (decision.deny) {
      let sessionId: string | null = null;
      try {
        sessionId = ctx.sessionManager.getSessionId();
      } catch {
        /* no active session */
      }
      recordBlock({
        sessionId,
        cwd: ctx.cwd,
        toolCallId: event.toolCallId,
        command,
        ruleId: (decision.reason.match(/\[([^\]]+)\]$/) ?? [])[1] ?? null,
        reason: decision.reason,
      });
      return { block: true, reason: decision.reason };
    }
  });

  pi.registerTool({
    name: "query_dcg_blocks",
    label: "Query dcg blocks",
    description:
      "Count shell commands blocked by the dcg destructive-command guard. Returns totals plus a breakdown by rule and the most recent blocks.",
    parameters: Type.Object({}),
    async execute(toolCallId, _params, _signal, _onUpdate, ctx) {
      let sessionId: string | null = null;
      try {
        sessionId = ctx.sessionManager.getSessionId();
      } catch {
        /* no active session */
      }
      return {
        content: [{ type: "text", text: formatStats(readBlocks(), sessionId) }],
        details: {},
      };
    },
  });

  pi.registerCommand("dcg-stats", {
    description: "Show how many commands dcg has blocked",
    handler: async (_args, ctx) => {
      let sessionId: string | null = null;
      try {
        sessionId = ctx.sessionManager.getSessionId();
      } catch {
        /* no active session */
      }
      ctx.ui.notify(formatStats(readBlocks(), sessionId), "info");
    },
  });
}