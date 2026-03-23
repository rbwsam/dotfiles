---
name: design-project
description: Run an interactive project design session that produces implementation-ready design documents.
---

# Project Design Session

Guide the user through structured discovery and produce design documents that a fresh Claude Code session can implement from.

## Process

Topics 1–3 → `overview.md`, Topics 4–6 → `stack.md`, Topic 7 → `plan.md`, then `CLAUDE.md` last.

For each topic:
1. Ask 2–4 focused questions using AskUserQuestion
2. Drill deeper when answers are vague or reveal unstated assumptions

At each document checkpoint, summarize what you've captured, confirm with the user, then write the file.

## Topics

### 1. Vision & Problem Space

- What problem does this solve? Who has it?
- Who are the target users?
- What does success look like?
- Is there an existing solution or is this greenfield?
- What is the deadline?

### 2. Constraints

- Mandated technologies or platforms?
- External systems to integrate with?
- Compliance, security, or legal requirements?
- Team size?
- Expected scale? (users, data, throughput)
- Budget?

### 3. Use Cases

- What are the core user workflows?
- For each: trigger → action → expected outcome
- Any requirements that apply across all use cases?
- What is explicitly out of scope?
- Known limitations?

Push for acceptance criteria:
```
WHEN [action]
THEN [result]
```

### 4. Technology Choices

- What is the team productive in?
- Key technical capabilities needed?
- Database requirements?
- UI needed? What kind?
- External services or APIs?
- Auth requirements?

For each choice: what and why.

### 5. Data Model

- Core domain entities and relationships?
- What persists vs. what's ephemeral?
- Seed data or import requirements?
- If a platform manages persistence, say so.

### 6. Infrastructure & Deployment

- Where does this run?
- What infrastructure is needed?
- Docker or bare metal?
- Environment variables and secrets?
- How do components connect?

### 7. Risks & Timeline

- Biggest technical worries?
- External dependencies?
- Fallbacks if key tech doesn't work?
- Critical path?
- What milestones mark progress?

## Output

Ask the user for the output directory (default: `docs/`). Write these files:

### overview.md

- Problem (1–2 paragraphs)
- Success criteria
- Target users
- Constraints (bulleted list)
- Use cases (WHEN/THEN)
- Cross-cutting requirements
- Known limitations
- Out of scope

### stack.md

- Technology choices table (component, choice, rationale)
- Data model (entities + relationships, or "managed by {platform}")
- Infrastructure (what runs where, resource allocation)
- Architecture (how components connect)
- Environment variables
- Deployment method

### plan.md

- Timeline with phased milestones
- Critical path
- Risks table (risk, impact, mitigation)

### CLAUDE.md

Synthesize everything into an implementation prompt:

```markdown
# CLAUDE.md

This file provides guidance to Claude Code when working with code in this repository.

## Overview
[What this is, who it's for]

## Tech Stack
[Technology choices]

## Architecture
[How pieces connect]

## Build & Run
[Setup and run commands]

## Implementation Order
[What to build first, dependencies]

## Acceptance Criteria
[From overview.md]

## Out of Scope
[Do not build these]

## Risks
[What to watch for]
```

## Rules

- **Be opinionated.** Recommend choices with rationale rather than presenting menus.
- **Challenge vague answers.** "Fast" → "Under 200ms? Under 2s?"
- **Guard scope.** Push back on anything not needed for the stated goal.
- **Surface hidden complexity.** Flag things that sound simple but aren't.
- **Never fabricate requirements.** If it wasn't discussed, mark it TBD.
- **One home per fact.** Risks in plan.md, not stack.md. Scope in overview.md, not plan.md.
