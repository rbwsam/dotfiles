/**
 * Read-Only Mode Extension
 *
 * Detects questions and applies read-only mode via system prompt.
 * Prepends a visual marker to the message.
 */

import type { ExtensionAPI } from "@mariozechner/pi-coding-agent";

const QUESTION_PATTERN =
	/^(what|how|why|where|when|who|can|is|have|has|would|could|should|will)\b|\?$|\b(explain|describe|review|analyze|understand|find|show|tell|list|summarize)\b/i;

export default function (pi: ExtensionAPI) {
	let lastInputWasQuestion = false;

	pi.on("input", async (event, ctx) => {
		const isQuestion = QUESTION_PATTERN.test(event.text.trim());
		lastInputWasQuestion = isQuestion;

		if (isQuestion) {
			return {
				action: "transform",
				text: "🛡️ [RO] " + event.text,
			};
		}

		return { action: "continue" };
	});

	pi.on("before_agent_start", async (event, ctx) => {
		if (lastInputWasQuestion) {
			lastInputWasQuestion = false;

			return {
				systemPrompt: event.systemPrompt + "\n\n[Read-only mode: answer without changing files or running commands.]",
			};
		}
	});
}
