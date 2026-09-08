---
name: usage-pace
description: Report Claude subscription usage as pace — percent of the session and weekly
  allotment consumed against percent of the window elapsed, and what that projects to at
  reset. Use when asked about Claude usage, limits, quota, allotment, burn rate, or whether
  usage is on pace / proportionate.
allowed-tools: Bash(python3 ~/.claude/skills/usage-pace/pace.py)
---

# Usage pace

Run `python3 ~/.claude/skills/usage-pace/pace.py` and relay its output. It prints a bar
per window — used against elapsed — so reproduce those lines verbatim inside a fenced code
block; the alignment is the point.

If the script exits with a message instead of bars, relay it — there is no fallback, so
never substitute numbers from elsewhere.

Lead with the verdict — under, at, or over pace — then the numbers. A projection over 100%
means the allotment runs out before reset; say how much the rate has to drop.
