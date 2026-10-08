import type { ExtensionAPI } from "@earendil-works/pi-coding-agent";

export default function (pi: ExtensionAPI) {
  pi.registerCommand("undo", {
    description: "Restore the last user message to the editor",
    handler: async (_args, ctx) => {
      const branch = ctx.sessionManager.getBranch();
      let userEntry: (typeof branch)[number] | undefined;
      for (let i = branch.length - 1; i >= 0; i--) {
        const entry = branch[i];
        if (entry.type === "message" && entry.message.role === "user") {
          userEntry = entry;
          break;
        }
      }

      if (!userEntry || userEntry.type !== "message") {
        ctx.ui.notify("No user message to undo.", "warning");
        return;
      }

      const content = userEntry.message.content;
      const text = typeof content === "string"
        ? content
        : content.map((part) => part.type === "text" ? part.text : "").join("");

      if (!ctx.isIdle()) {
        ctx.abort();
        await ctx.waitForIdle();
      }

      const result = await ctx.navigateTree(userEntry.id, { summarize: false });
      if (result.cancelled) return;

      ctx.ui.setEditorText(text);
      ctx.ui.notify("Last user message restored to the editor.", "info");
    },
  });
}
