#!/bin/sh
# Custom output styles get no per-turn reminder of their rules; built-in styles do.
[ "$(jq -r '.outputStyle // empty' "$HOME/.claude/settings.json")" = Terse ] || exit 0
jq -n --arg c 'Terse style: outcome first; then **Problems** (open), **Also** (minor), **Needs you** (decisions, including calls made on the user'"'"'s behalf) last; minor items stated without explanation; number items the user might respond to; no narration before or between tool calls.' \
  '{hookSpecificOutput: {hookEventName: "UserPromptSubmit", additionalContext: $c}}'
