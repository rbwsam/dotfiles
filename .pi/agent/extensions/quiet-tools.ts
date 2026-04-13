import { Text } from "@mariozechner/pi-tui";
import type { ExtensionAPI } from "@mariozechner/pi-coding-agent";
import { createReadTool, createBashTool, createEditTool, createWriteTool } from "@mariozechner/pi-coding-agent";

export default function (pi: ExtensionAPI) {
  const cwd = process.cwd();

  const factories: Record<string, ReturnType<typeof createReadTool>> = {
    read: createReadTool(cwd),
    bash: createBashTool(cwd),
    edit: createEditTool(cwd),
    write: createWriteTool(cwd),
  };

  for (const [name, original] of Object.entries(factories)) {
    pi.registerTool({
      name: original.name,
      label: original.label,
      description: original.description,
      parameters: original.parameters,

      async execute(toolCallId, params, signal, onUpdate) {
        return original.execute(toolCallId, params, signal, onUpdate);
      },

      renderCall(args, theme, context) {
        let text = theme.fg("toolTitle", theme.bold(`${name} `));
        if (name === "bash") {
          const cmd = args.command?.length > 80 ? `${args.command.slice(0, 77)}...` : args.command;
          text = theme.fg("toolTitle", theme.bold("$ ")) + theme.fg("accent", cmd ?? "...");
          if (args.timeout) text += theme.fg("dim", ` (timeout: ${args.timeout}s)`);
        } else if (name === "read") {
          text += theme.fg("accent", args.path ?? "...");
          const parts: string[] = [];
          if (args.offset) parts.push(`offset=${args.offset}`);
          if (args.limit) parts.push(`limit=${args.limit}`);
          if (parts.length) text += theme.fg("dim", ` (${parts.join(", ")})`);
        } else if (name === "write") {
          text += theme.fg("accent", args.path ?? "...");
          const lineCount = args.content ? args.content.split("\n").length : 0;
          if (lineCount > 0) text += theme.fg("dim", ` (${lineCount} lines)`);
        } else if (name === "edit") {
          text += theme.fg("accent", args.path ?? "...");
          const editCount = Array.isArray(args.edits) ? args.edits.length : 0;
          if (editCount > 0) text += theme.fg("dim", ` (${editCount} edit${editCount > 1 ? "s" : ""})`);
        }
        return new Text(text, 0, 0);
      },

      renderResult(result, { expanded, isPartial }, theme, context) {
        if (isPartial) {
          return new Text(theme.fg("warning", "…"), 0, 0);
        }
        if (!expanded) {
          const status = context.isError
            ? theme.fg("error", "✗ error")
            : theme.fg("success", "✓ done");
          return new Text(status, 0, 0);
        }
        // When expanded, render the result content as text
        const content = result.content
          ?.map((c: any) => (c.type === "text" ? c.text : ""))
          .join("") ?? "";
        return new Text(content || theme.fg("dim", "(empty)"), 0, 0);
      },
    });
  }
}
