---
name: designing-web-apps-in-claude-design
description: Use when drawing, revising, rendering or publishing artboards on a Claude Design canvas that redesigns a web app, when answering comments left on such a canvas, or before asking the user to approve its boards.
---

# Designing web apps in Claude Design

The canvas holds the look; the project's spec holds the decisions and their reasons; the code is the data's truth. Boards are HTML built by scripts and seen locally before the user sees them.

Project facts (canvas URL, local root, generators, palette, decisions) live in the project's progress ledger; the project's memory or the user names where. Read its latest handoff first. This skill holds none of them. ROOT below is the local folder holding `project/` (the canvas files at their canvas paths) and `runtime/`.

Needs `uv`. Once per machine, install the browser from the same environment that renders: `uv run --no-project --with playwright playwright install chromium`. Artifact tools are named as in Claude Code (`Artifact`, `ArtifactComments`); elsewhere use the equivalent read, publish and comment tools.

## Every turn

1. Read the canvas's comment threads. A comment is the user talking and comes before the chat's requests: make the change it asks for (steps 2–7), then reply in its thread with what changed, or with the answer if nothing needed to change. Never resolve: resolving hides the reply. An auto-reply notice is a comment too: an automatic reply that states something not checked against the code or spec gets a new reply correcting it.
2. Before drawing, list from the code (in the ledger) every outcome, state, reason, limit and field the board shows, with file references. Draw only what the code produces. Something the design needs that the code lacks is a proposal to the user; once agreed it goes in the spec's code changes, then it can be drawn.
3. Change the generator script, not the board file. Regenerate.
4. Render and read the PNG: `uv run --no-project --with playwright python ${CLAUDE_SKILL_DIR}/scripts/shot.py ROOT Board.dc.html`. Fix CLIPPED and SCROLLS SIDEWAYS; fit the frame height to the content (the generator's `$preview` height and the board's `h` in `canvas.json`).
5. Publish only the changed files (below).
6. Write a decision the user agreed to (a request they made, or a yes to a proposal) into the spec the same turn, as a rule and its reason ("rows page 15 at a time, so Back returns to the same rows"), never a measurement. An approval goes in the spec and the ledger.
7. Append what changed to the ledger.

## Drawing

- Build each screen from the components on the canvas's Components page. Before drawing, list each job the screen does and the component that does it. A job with no component gets a new one, designed on the screen that needs it but shaped for the job, so other screens can use it. The review request names it as new; once approved its frame moves to the Components page. Never reuse a component that means something else.
- Place components with `dc-import` rather than copying their markup. A component file is also its own frame, so its root sets its own font-family and colour.
- Build with the mechanism the app will ship: a real `<table>`, wrap or nowrap per cell, min and max widths. A flex row of guessed pixel widths standing in for a table hides squeeze bugs; replacing one is part of the next change to that board, and the reply says so.
- While the user iterates, change one board. Once its structure is approved, every state drawn on desktop gets its phone twin with the same fields and copy (hover and drag states excepted), then other variants and component frames follow.
- A list's first version carries its states: none ever, none now, none after a filter, loading, one page, more than a page, each request failing.
- Edge boards: longest values, the maximum count, everything failing, each size at the narrowest width the project supports (step 4's command with `--width N` before the board names).
- Every control that fetches gets, before it is drawn: its request, the most rows it can return, their order, how it knows it reached the end, its failure, what the URL keeps.
- Hover may highlight and preview; it never holds information or an action that click or tap can't reach.
- A defect at one size: ask what rule is missing before patching the board. Propose the established pattern with sources, one rule at a time, the simple answer first.

## Asking for approval

**REQUIRED SUB-SKILL:** reviewing-screens, before asking and before proposing a feature, filter, column or control. Draw the issue before asking about it. Ask with a numbered list of board titles, removals first, short. Component frames publish after rendering, without approval.

## Publishing

- `action: "publish"`, `url`, `root` = ROOT, `file_path` = absolute path of one changed file, `files` = `{"project/X.dc.html": "project/X.dc.html"}` for any others.
- After a restart or a refused publish, read the canvas (`action: "read"`) before publishing.
- Send `project/canvas.json` when a frame is added, moved or resized, or notes or pages change: read the live index first, change only the entries for the boards and notes you touched, run `uv run --no-project python ${CLAUDE_SKILL_DIR}/scripts/check_layout.py ROOT/project/canvas.json`.

## Runtime gotchas

| Symptom | Cause | Fix |
|---|---|---|
| Table column widths ignored | The runtime drops `<colgroup>` | `table-layout: fixed` with widths on the header cells |
| `--width` below the phone frame scrolls sideways | The board's root is fixed at the frame width | Make the root `width: 100%`; the frame keeps its width |
| An imported component inside a sentence drops onto its own line | Imports always render as blocks | Give it its own slot in the row, or copy its markup there |
| An import shows the wrong component or nothing | A value named `name` picks the component | Call the value something else, like `label` |
| `shot.py` can't find the runtime | `ROOT/runtime/dc-runtime.js` missing | Read `artifact-type/dc-runtime.js` from the canvas and save it there |
