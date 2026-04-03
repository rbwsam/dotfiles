import type { ExtensionAPI } from "@mariozechner/pi-coding-agent";

export default function (pi: ExtensionAPI) {
  pi.on("session_start", (_event, ctx) => {
    ctx.ui.notify(
      "📋 Editing guidelines loaded: Prefer Write/Bash over Edit for robustness",
      "info"
    );
  });

  pi.on("tool_call", (event, ctx) => {
    if (event.toolName !== "edit") return;

    try {
      const edits = event.input?.edits as Array<{ oldText?: string }> | undefined;
      if (!Array.isArray(edits) || edits.length === 0) return;

      const warnings: string[] = [];

      // Check for multiple edits
      if (edits.length > 1) {
        warnings.push("Multiple edits—use Write for full rewrite");
      }

      // Check for complex patterns
      const hasComplexPattern = edits.some(edit => {
        const text = edit.oldText || "";
        return (
          text.includes("${") ||
          text.includes("{%") ||
          text.includes("{{") ||
          text.length > 1500
        );
      });

      if (hasComplexPattern) {
        warnings.push("Complex patterns detected—use bash/Write");
      }

      // Send single consolidated warning
      if (warnings.length > 0) {
        ctx.ui.notify("⚠️  " + warnings.join(" | "), "warn");
      }
    } catch (_error) {
      // Silent fail—don't interfere with agent
    }
  });
}
