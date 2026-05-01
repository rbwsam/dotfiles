# Asking questions

When asking me to choose between discrete options, use the `AskUserQuestion` tool rather than asking in prose. Put your recommended option first with "(Recommended)".

Batch all decisions for a task into a single `AskUserQuestion` call. Do not trail follow-up questions in prose after the tool call. If you notice a missing decision after asking, make a second `AskUserQuestion` call rather than asking inline.
