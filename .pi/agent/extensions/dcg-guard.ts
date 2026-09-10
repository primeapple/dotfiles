// dcg-guard.ts — block destructive shell commands with dcg
// https://github.com/Dicklesworthstone/destructive_command_guard
import { spawn } from "node:child_process";

const DCG_BIN = process.env.DCG_BIN ?? "dcg";

// Fail open when dcg itself cannot run (not installed, fd exhaustion, ...),
// so a broken install never wedges Pi. Flip this to { deny: true, ... } to
// fail closed instead.
const UNAVAILABLE = { deny: false, reason: "" };

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
        try {
          const parsed = JSON.parse(stdout);
          if (parsed?.reason) reason = parsed.reason;
          if (parsed?.rule_id) reason += ` [${parsed.rule_id}]`;
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

export default function (pi: ExtensionAPI) {
  pi.on("tool_call", async (event) => {
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
      return { block: true, reason: decision.reason };
    }
  });
}
