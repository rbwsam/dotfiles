# Resume Project Design Session

You are resuming an interrupted project design session. Design documents may be partially complete.

## Step 1: Read Existing State

Check for design documents in all possible output directories: `docs/poc/`, `docs/mvp/`, `docs/design/`. Read all files found to understand what has been captured so far. Check for:
- Which documents exist and which are missing
- Whether existing documents are complete or have TBD/placeholder sections
- Whether any documents are marked as **DRAFT** (indicates a large project still in the Discovery pass)
- The presence of `00-landscape.md` (present for both standard and large projects)
- Any contradictions or gaps between documents
- The PROJECT_TYPE (infer from directory name or document content)
- The PROJECT_SCALE (infer: if documents have DRAFT banners or `00-landscape.md` has unresolved unknowns flagged for the Uncertainty Resolution Gate, it's a large project in two-pass flow)

## Step 2: Determine Where We Left Off

### Standard Flow Phases

0. **Project Type** → determines output directory and behavioral adjustments
0.5. **Project Scale** → determines flow
1. **Vision & Problem Space** → `01-overview.md`
2. **Landscape Survey** → `00-landscape.md`
3. **Use Cases & Acceptance Criteria** → `02-use-cases.md`
4. **Technology Choices** → `03-technology.md`
5. **Data Model** → `04-data-model.md`
6. **Interfaces & Integration** → `05-interfaces.md`
7. **Infrastructure & Deployment** → `06-infrastructure.md`
8. **Risk Register** → `07-risks.md`
9. **Timeline & Milestones** → `08-timeline.md`
10. **Synthesis** → `CLAUDE.md`

### Large Project Flow Phases

**Pass 1 — Discovery:**

| Phase | Writes to |
|---|---|
| Vision & Problem Space | `01-overview.md` (DRAFT) |
| Landscape Survey | `00-landscape.md` |
| Draft Use Cases | `02-use-cases.md` (DRAFT) |
| Technical Feasibility | `03-technology.md` (DRAFT) |

**Uncertainty Resolution Gate** → updates to existing files

**Pass 2 — Design:**

| Phase | Writes to |
|---|---|
| Use Cases & Acceptance Criteria (refined) | update `02-use-cases.md` (remove DRAFT) |
| Technology Choices | update `03-technology.md` (remove DRAFT) |
| Data Model | `04-data-model.md` |
| Interfaces & Integration | `05-interfaces.md` |
| Infrastructure & Deployment | `06-infrastructure.md` |
| Risk Register | `07-risks.md` |
| Timeline & Milestones | `08-timeline.md` |
| Synthesis | update `01-overview.md` (remove DRAFT), generate `CLAUDE.md` |

To determine current phase in the large project flow:
- If documents exist but are marked DRAFT → still in Discovery or at the Uncertainty Resolution Gate
- If `00-landscape.md` has unresolved unknowns → at the Uncertainty Resolution Gate
- If some documents have DRAFT removed → in Design pass

Present a summary to the user:
- **Project type**: PoC / MVP / Production
- **Project scale**: Standard / Large
- **Current pass** (large projects only): Discovery / Uncertainty Resolution / Design
- **Completed phases**: list what's been captured with key decisions
- **Current phase**: the first phase that is incomplete or missing
- **Remaining phases**: what's left to cover
- **Open items**: any TBDs, DRAFT documents, unresolved unknowns, contradictions, or gaps

## Step 3: Confirm and Continue

Ask the user:
- Is the summary accurate?
- Do any completed decisions need to be revisited?
- Are there any new constraints or changes since the last session?

Then continue the design process from the current phase, following the behavioral rules from the `/design-project` command:

- Ask 2-4 focused questions per phase using AskUserQuestion
- Drill deeper on vague answers
- Scope-guard using the PROJECT_TYPE-appropriate phrase
- Challenge hand-wavy requirements
- Surface hidden complexity
- Recommend opinionated defaults
- Match rigor to project type
- Separate constraints from decisions
- Never fabricate requirements — mark unknowns as TBD
- Write each phase's document to disk immediately after completion
- Run the **Inter-Phase Review** after each phase (see below)

## Inter-Phase Review

After writing a completed phase to disk and before starting the next one:

1. **Problem scan** — Re-read the phase summary looking for:
   - Contradictions or ambiguity within the phase itself
   - Hidden complexity that was accepted without discussion
   - Assumptions that haven't been validated
   - Gaps: important questions that weren't asked or answered
   - Content that belongs in a later phase
   Present any findings to the user and resolve them before continuing.

2. **Optimization check** — Ask whether the decisions in this phase are the simplest path that satisfies the PROJECT_TYPE. Flag anything over- or under-engineered relative to the project type.

3. **Cascade analysis** — Compare the phase's decisions against every prior phase summary (including those from previous sessions captured in existing documents). For each prior phase, check:
   - Do any new decisions invalidate, weaken, or conflict with earlier ones?
   - Do any new decisions unlock a simpler approach to something decided earlier?
   - Has scope shifted in a way that changes the acceptance criteria or success definition?
   If conflicts or improvements are found, present them to the user, resolve them, and **update the affected document** so it stays current.

Only advance to the next phase when the review surfaces no unresolved issues.

## Phase Details

### Vision & Problem Space
What problem, for whom, what does success look like, deadline, greenfield vs replacement.

### Landscape Survey
Constraints (mandated tech, compliance, existing systems), unknowns, scale expectations, prior art. Mark each item as Constraint (fixed) or Unknown (needs resolution). Standard projects: keep it focused on what's fixed. Large projects: go deep on unknowns and prior art.

### Use Cases & Acceptance Criteria
3-5 core workflows, GIVEN/WHEN/THEN acceptance criteria, explicit out-of-scope list, demo scenarios. Each UC must describe a user performing an action to achieve a goal — behavioral constraints go in Cross-Cutting Requirements. UCs contain only *what* (trigger, action, outcome), never *how* (implementation). Document must include: use cases, cross-cutting requirements, known limitations, and out of scope.

### Technology Choices
Mandated tech, team expertise, capabilities needed, database, UI, external services, auth. Document choice/constraint-or-decision/rationale/risk for each.

### Data Model
Core entities, relationships, persistence vs ephemeral, seed data, key attributes.

### Interfaces & Integration
External integrations (contracts, auth, rate limits), internal component boundaries, user-facing interface shape. Adapt depth to project form — not every project has an API.

### Infrastructure & Deployment
Dev environment, deployment targets, infra needed, containers, CI/CD, env vars and secrets.

### Risk Register
Technical worries, external dependencies, fallback plans. Classify by impact/likelihood/mitigation.

### Timeline & Milestones
Hard deadline, team size, phases with deliverables, critical path, what to stub/mock/defer.

### Synthesis & Document Generation
Run the **Final Consistency Review** before generating CLAUDE.md:
1. **Cross-phase consistency** — Read every document end-to-end. Check for contradictions.
2. **Scope drift** — Compare final use cases and timeline against original vision and PROJECT_TYPE.
3. **Completeness** — Verify every use case has acceptance criteria, every tech choice has rationale, every risk has a mitigation.
4. **Implementability** — Read as if you were a fresh Claude Code session about to build this. Flag anything ambiguous or underspecified.

Present all findings to the user and resolve them. For large projects: remove any remaining DRAFT banners. Then generate/update `CLAUDE.md`.

## Document Output

Update existing documents in place. Generate missing documents. Remove DRAFT banners when documents are finalized during the Design pass.

The output directory is determined by PROJECT_TYPE:
- PoC → `docs/poc/`
- MVP → `docs/mvp/`
- Production → `docs/design/`

```
docs/{type}/
├── 00-landscape.md
├── 01-overview.md
├── 02-use-cases.md
├── 03-technology.md
├── 04-data-model.md
├── 05-interfaces.md
├── 06-infrastructure.md
├── 07-risks.md
├── 08-timeline.md
└── CLAUDE.md
```

The `CLAUDE.md` should only be generated/updated during the Synthesis phase, after all other phases are complete and confirmed.
