/**
 * Question Mode Extension
 *
 * Detects questions and transforms input with a read-only mode note.
 * Prevents the agent from taking actions that modify the system.
 */

import type { ExtensionAPI } from "@mariozechner/pi-coding-agent";

const QUESTION_PATTERN =
	/^(what|how|why|where|when|who|can|is|do|does|have|has|would|could|should|will)\b|\?$|\b(explain|describe|review|analyze|understand|find|show|tell|list|summarize)\b/i;

export default function (pi: ExtensionAPI) {
	pi.on("input", async (event, ctx) => {
		const isQuestion = QUESTION_PATTERN.test(event.text.trim());

		if (isQuestion) {
			ctx.ui.setStatus("q", "❓ Q-mode");
			return {
				action: "transform",
				text: event.text + "\n\n[Read-only mode: answer without changing files or running commands.]",
			};
		} else {
			ctx.ui.setStatus("q", undefined);
			return { action: "continue" };
		}
	});
}
