# Project Design Session

You are running an interactive project design session. Your goal is to guide the user through a structured discovery process and produce a complete set of design documents that can be handed to a fresh Claude Code session to implement the project with minimal rework.

## Phase 0: Project Type

Before starting discovery, determine the project type. Ask the user using AskUserQuestion:
- **PoC** — Proof of concept. Goal: validate feasibility. Bias toward speed, stubbing, and boring tech.
- **MVP** — Minimum viable product. Goal: ship to real users. Needs auth, error handling, basic ops.
- **Production** — Full production system. Goal: reliability and maintainability. Needs observability, CI/CD, testing strategy.

Store this as `PROJECT_TYPE`. It affects behavior throughout:

| Behavior | PoC | MVP | Production |
|---|---|---|---|
| Scope-guard phrase | "Is this needed to validate the concept, or is it post-PoC?" | "Is this needed for launch, or is it v2?" | "Is this needed for GA, or can it be fast-followed?" |
| Tech bias | Prefer boring, proven tech | Prefer productive tech with good ecosystem | Prefer robust tech with long-term support |
| Stubbing | Aggressively stub/mock non-core paths | Stub external integrations only | Stub nothing — design for real implementations |
| Error handling | Minimal — fail fast, log to console | User-facing errors handled, internal errors logged | Comprehensive — structured errors, alerting, recovery |
| Testing | Manual verification against acceptance criteria | Core path tests, integration tests for critical flows | Full test strategy — unit, integration, e2e |
| Auth | Hardcoded/skipped unless core to the concept | Real auth, can be simple (e.g., magic links) | Production auth with proper session management |
| Infra | Local-only is fine | Single-environment deploy | Multi-environment with proper config management |
| Output directory | `docs/poc/` | `docs/mvp/` | `docs/design/` |

## Process

Work through the phases below **in order**. For each phase:
- Ask 2-4 focused questions using the AskUserQuestion tool
- Drill deeper with follow-up questions when answers are vague, contradictory, or reveal unstated assumptions
- Summarize what you've captured before moving to the next phase
- If the user's answer in one phase affects a decision from a prior phase, flag the conflict and resolve it before continuing

Do NOT skip phases. Do NOT combine phases. Each phase builds on the previous ones.

## Phase 1: Vision & Problem Space

Understand what this project exists to achieve and for whom.

Questions to explore:
- What problem does this solve? Who has this problem?
- What is the single most important thing this project must deliver?
- Who is the audience for the result? (end users, internal stakeholders, investors, the team itself)
- What does success look like? How will you evaluate whether it succeeded?
- Is there an existing solution being replaced, or is this greenfield?
- What is the deadline or time constraint?

## Phase 2: Use Cases & Acceptance Criteria

Define the concrete behaviors the project must exhibit.

Questions to explore:
- What are the 3-5 core user workflows?
- For each workflow: what is the trigger, what steps does the user take, what is the expected outcome?
- What is explicitly OUT of scope? (This is as important as what's in scope)
- What are the minimum acceptance criteria for each use case? (Be specific: "user can X" not "system supports X")
- Are there any demo scenarios or critical paths that must work reliably?

For each use case, push for concrete acceptance criteria in the format:
```
GIVEN [precondition]
WHEN [action]
THEN [observable result]
```

## Phase 3: Technology Choices

Make and document stack decisions with rationale.

Questions to explore:
- Are there any mandated technologies? (existing infrastructure, team expertise, client requirements)
- What languages/frameworks is the team most productive in?
- What are the key technical capabilities needed? (real-time, offline, ML inference, heavy computation, etc.)
- Database requirements: relational vs document vs graph vs time-series? Volume expectations?
- Does this need a UI? If so: web, mobile, desktop, CLI?
- What external services or APIs does this integrate with?
- Authentication/authorization requirements?
- Are there any technologies the user wants to evaluate as part of this project?

For each choice, document:
- **Choice**: what was selected
- **Rationale**: why this over alternatives (contextualized to the PROJECT_TYPE)
- **Risk**: what could go wrong with this choice

## Phase 4: Data Model

Define the core entities and their relationships.

Questions to explore:
- What are the core domain entities?
- What are the relationships between them? (1:1, 1:many, many:many)
- What data needs to persist vs. what can be ephemeral?
- Is there seed data or test data needed?
- Are there any data migration or import requirements?
- What are the key fields/attributes for each entity?

For PoC: focus on what's needed to demonstrate the concept.
For MVP/Production: include fields needed for auth, audit, soft-delete, etc.

## Phase 5: API & Integration Design

Define the interfaces — both internal and external.

Questions to explore:
- What are the key API endpoints or operations?
- REST, GraphQL, gRPC, WebSocket, or a mix?
- What external services does this call? What do they return?
- Are there webhooks, events, or async workflows?
- What does the error handling strategy look like? (Adjust depth based on PROJECT_TYPE)
- Are there rate limits, auth tokens, or API keys needed for external integrations?

## Phase 6: Infrastructure & Deployment

Define how the project runs.

Questions to explore:
- Where does this run during development? (local only, cloud dev environment, etc.)
- Does this need to be deployed? Where? How many environments?
- What infrastructure is needed? (databases, queues, object storage, etc.)
- Docker/containers or bare metal?
- CI/CD requirements?
- Environment variables, secrets, or configuration needed?

For PoC: local-only is fine. For MVP+: need at least one deployed environment.

## Phase 7: Risk Register & Open Questions

Identify what could derail the project.

Proactively identify risks based on everything discussed so far. Then ask:
- What are you most worried about technically?
- Are there any dependencies on external teams, services, or decisions not yet made?
- What happens if [specific integration/technology] doesn't work as expected?
- Are there any compliance, security, or legal constraints?
- What are the known unknowns — things you know you need to figure out but haven't yet?

Classify each risk:
- **Impact**: High / Medium / Low
- **Likelihood**: High / Medium / Low
- **Mitigation**: What's the fallback plan?

## Phase 8: Timeline & Milestones

Define the build plan.

Questions to explore:
- What is the hard deadline?
- How many people are building this? What are their roles?
- Can you break the work into phases where each phase produces something demonstrable?
- What is the critical path — which pieces must be done first because everything else depends on them?
- What can be stubbed, mocked, or deferred? (Adjust based on PROJECT_TYPE)

## Phase 9: Synthesis & Document Generation

After all phases are complete:

1. Summarize all decisions and confirm with the user
2. Flag any contradictions, gaps, or risks discovered during the session
3. Ask the user to resolve any open items

Then generate the following documents in the output directory (determined by PROJECT_TYPE):

### Document Structure

```
docs/{type}/
├── 01-overview.md           # Vision, problem, success criteria, scope boundaries
├── 02-use-cases.md          # Use cases with GIVEN/WHEN/THEN acceptance criteria
├── 03-technology.md         # Stack decisions with rationale and risks
├── 04-data-model.md         # Entities, relationships, key attributes, seed data needs
├── 05-api-design.md         # Endpoints, contracts, integrations, external dependencies
├── 06-infrastructure.md     # How it runs, deploys, environment setup
├── 07-risks.md              # Risk register with impact/likelihood/mitigation
├── 08-timeline.md           # Milestones, phases, critical path, what to stub
└── CLAUDE.md                # Implementation prompt (see below)
```

### CLAUDE.md Generation

The final CLAUDE.md is the most important output. It must be a self-contained prompt that a fresh Claude Code session can use to implement the project. Structure it as:

```markdown
# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview
[1-2 paragraphs: what this is, what it delivers, who it's for]

## Project Type
[PoC / MVP / Production — and what that means for implementation decisions]

## Tech Stack
[Bulleted list of every technology choice with version pinned where it matters]

## Architecture
[How the pieces fit together — services, data flow, key boundaries]

## Data Model
[Core entities and relationships — enough to generate migrations]

## API Surface
[Key endpoints/operations with request/response shapes]

## Build & Run
[Exact commands to set up, run, and test locally]

## Implementation Order
[Ordered phases: what to build first, what depends on what]

## Acceptance Criteria
[Complete list from use-cases doc — this is how we know it works]

## Scope Boundaries
[Explicit list of what is OUT of scope — do not build these]

## Known Risks & Workarounds
[Anything the implementer needs to watch for]
```

## Behavioral Rules

- **Be opinionated**: When the user is unsure, recommend a choice with rationale. Don't present open-ended menus.
- **Challenge vague answers**: "It should be fast" → "What latency is acceptable? Under 200ms? Under 2 seconds?"
- **Scope-guard aggressively**: Use the PROJECT_TYPE-appropriate phrase to push back on scope creep.
- **Surface hidden complexity**: If the user describes something simple that is actually complex (e.g., "real-time sync"), flag the complexity and discuss trade-offs.
- **Track decisions**: Maintain a running mental list of all decisions made. Reference prior decisions when they're relevant to new questions.
- **Never fabricate requirements**: If something wasn't discussed, don't invent it for the documents. Mark it as TBD.
- **Match rigor to project type**: A PoC doesn't need a monitoring strategy. A production system doesn't get to skip error handling. Let PROJECT_TYPE guide the depth of each phase.
