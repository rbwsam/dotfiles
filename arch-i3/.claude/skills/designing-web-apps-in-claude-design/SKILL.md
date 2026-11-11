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
2. Before drawing, run Ground it from designing-and-building-web-ui and record its list in the ledger, with file references. Draw only what the code produces. Something the design needs that the code lacks is a proposal to the user; once agreed it goes in the spec's code changes, then it can be drawn.
3. Change the generator script, not the board file. Regenerate.
4. Render and read the PNG: `uv run --no-project --with playwright python ${CLAUDE_SKILL_DIR}/scripts/shot.py ROOT Board.dc.html | tee ROOT/shot.txt`. Fix CLIPPED and SCROLLS SIDEWAYS. To fit frame heights, save the live `project/canvas.json` into ROOT (`action: "read"`, `path`), then `uv run --no-project python ${CLAUDE_SKILL_DIR}/scripts/fit.py ROOT ROOT/shot.txt Board.dc.html …` (pushes frames below down). Generators never write `canvas.json`.
5. Publish only the changed files (below).
6. Record a decision the user agreed to the same turn, as a rule and its reason, never a measurement. A screen's own design goes in the spec; a rule other screens face goes where designing-and-building-web-ui says. An approval goes in the spec and the ledger.
7. Append what changed to the ledger.

## Tokens and components

- Before the first board, make a Design System artifact (tokens.json: colours by job, type styles, spacing, radius, shadow) and install it on the canvas (`project/ds/<ns>/tokens.json` plus the index's `designSystems` record). A script writes `project/ds/<ns>/tokens.css` in the system's compiled shape (`--<token>` variables, a `.<style>` class per type style): the system page writes its own only when opened.
- Boards and components reach tokens through `var(--token)` and the type classes.
- A pattern drawn twice is a component: one `project/<Name>.dc.html` written by a component generator, with props for every state and size and a helper returning its `<dc-import>` tag. Its helmet links `ds/<ns>/tokens.css`; the runtime carries that into every board that imports it.
- Build the components first, then move boards onto them in one pass. A component fits the approved screens; a screen never bends to a component's limit. A component defect is fixed in its generator, never with a workaround on a board.
- The Components page: a titled row per group, laid out by script. Each row holds a large sheet and a small sheet built only from imports (the small sheet shows what changes at small size; the large sheet owns the states), then the group's component frames. A sheet over 8000 px splits into two frames.
- Parallel helpers each own named generator files; one helper at a time edits a component generator. Each brief carries the runtime gotchas below.

## Drawing

- Build each screen from the components on the Components page. Before drawing, list each job the screen does and the component that does it. A job with no component gets a new one, shaped for the job so other screens can use it. The review request names it as new. Never reuse a component that means something else.
- Build with the mechanism the app will ship: a real `<table>`, wrap or nowrap per cell, min and max widths. A flex row of guessed pixel widths standing in for a table hides squeeze bugs; replacing one is part of the next change to that board, and the reply says so.
- While the user iterates, change one board. Once its structure is approved, every state drawn at large gets its small twin with the same fields and copy (hover and drag states excepted), then other variants and component frames follow. Draw and check each board at the widths the spec names.
- Check every interactive component on a card and on the page background.
- Edge boards: longest values, the maximum count, everything failing, each size at the narrowest width the project supports (step 4's command with `--width N` before the board names).
- A defect at one size: ask what rule is missing before patching the board. Propose it one rule at a time (designing-and-building-web-ui, Proposals).

## Asking for approval

**REQUIRED SUB-SKILL:** designing-and-building-web-ui, its Review, before asking and before proposing a feature, filter, column or control. Draw the issue before asking about it. Ask with a numbered list of board titles, removals first, short. Component frames publish after rendering, without approval.

## Publishing

- `action: "publish"`, `url`, `root` = ROOT, `file_path` = absolute path of one changed file, `files` = `{"project/X.dc.html": "project/X.dc.html"}` for any others.
- After a restart or a refused publish, read the canvas (`action: "read"`) before publishing.
- Send `project/canvas.json` when a frame is added, moved or resized, or notes or pages change: read the live index first, change only the entries for the boards and notes you touched, run `uv run --no-project python ${CLAUDE_SKILL_DIR}/scripts/check_layout.py ROOT/project/canvas.json`.

## Runtime gotchas

| Symptom | Cause | Fix |
|---|---|---|
| Table column widths ignored | The runtime drops `<colgroup>` | `table-layout: fixed` with widths on the header cells |
| `--width` below the small frame scrolls sideways | The board's root is fixed at the frame width | Make the root `width: 100%`; the frame keeps its width |
| An imported component inside a sentence drops onto its own line | Imports always render as blocks | Give it its own slot in the row |
| An import shows the wrong component or nothing | A value named `name` picks the component | Call the value something else, like `label` |
| `shot.py` can't find the runtime | `ROOT/runtime/dc-runtime.js` missing | Read `artifact-type/dc-runtime.js` from the canvas and save it there |
| `prop="false"` acts as true; `"29" + 1` is `"291"` | Import attributes arrive as strings | Booleans true only for `true` or `'true'`; numbers through `Number()` |
| Rows grow 2–3 px where a pill or tag is imported | An inline component root sits on the host's line box | Component root `display: flex; width: max-content` |
| A component in a flex row won't shrink | Its `.sc-host` wrapper keeps the default min-width | The component's helmet sets `.sc-host[data-sc-name=Name]{min-width:0}` |
| Console errors from a component's SVG | Holes in SVG attributes (`d`, `width`, `points`) parse before they fill | `<sc-if>` branches, or sizes in `style` |
| A component's `100vh` stops short or overflows | In a frame, the viewport is the frame | Give it a `height` prop; boards keep `100vh` |
| A component needs to hold other markup | — | `{{children}}` renders what sits inside its `<dc-import>` |
| A list prop | Holes take no array literals | JSON in the attribute, or a `{{lookup}}` from the board's renderVals |
