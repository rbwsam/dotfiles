# Resume Project Design Session

You are resuming an interrupted project design session. Design documents may be partially complete.

## Step 1: Read Existing State

Check for design documents in all possible output directories: `docs/poc/`, `docs/mvp/`, `docs/design/`. Read all files found to understand what has been captured so far. Check for:
- Which documents exist and which are missing
- Whether existing documents are complete or have TBD/placeholder sections
- Any contradictions or gaps between documents
- The PROJECT_TYPE (infer from directory name or document content)

## Step 2: Determine Where We Left Off

The design phases are:
0. **Project Type** → determines output directory and behavioral adjustments
1. **Vision & Problem Space** → `01-overview.md`
2. **Use Cases & Acceptance Criteria** → `02-use-cases.md`
3. **Technology Choices** → `03-technology.md`
4. **Data Model** → `04-data-model.md`
5. **API & Integration Design** → `05-api-design.md`
6. **Infrastructure & Deployment** → `06-infrastructure.md`
7. **Risk Register** → `07-risks.md`
8. **Timeline & Milestones** → `08-timeline.md`
9. **Synthesis** → `CLAUDE.md`

Present a summary to the user:
- **Project type**: PoC / MVP / Production
- **Completed phases**: list what's been captured with key decisions
- **Current phase**: the first phase that is incomplete or missing
- **Remaining phases**: what's left to cover
- **Open items**: any TBDs, contradictions, or gaps found in existing docs

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
- Never fabricate requirements — mark unknowns as TBD

## Phase Details

### Phase 1: Vision & Problem Space
What problem, for whom, what does success look like, deadline, greenfield vs replacement.

### Phase 2: Use Cases & Acceptance Criteria
3-5 core workflows, GIVEN/WHEN/THEN acceptance criteria, explicit out-of-scope list, demo scenarios.

### Phase 3: Technology Choices
Mandated tech, team expertise, capabilities needed, database, UI, external services, auth. Document choice/rationale/risk.

### Phase 4: Data Model
Core entities, relationships, persistence vs ephemeral, seed data, key attributes.

### Phase 5: API & Integration Design
Key endpoints, protocol (REST/GraphQL/gRPC/WS), external calls, webhooks, error handling, API keys needed.

### Phase 6: Infrastructure & Deployment
Dev environment, deployment targets, infra needed, containers, CI/CD, env vars and secrets.

### Phase 7: Risk Register
Technical worries, external dependencies, fallback plans. Classify by impact/likelihood/mitigation.

### Phase 8: Timeline & Milestones
Hard deadline, team size, phases with deliverables, critical path, what to stub/mock/defer.

### Phase 9: Synthesis & Document Generation
Summarize all decisions, flag contradictions, resolve open items, generate/update all docs including the `CLAUDE.md` implementation prompt.

## Document Output

Update existing documents in place. Generate missing documents. The output directory is determined by PROJECT_TYPE:
- PoC → `docs/poc/`
- MVP → `docs/mvp/`
- Production → `docs/design/`

```
docs/{type}/
├── 01-overview.md
├── 02-use-cases.md
├── 03-technology.md
├── 04-data-model.md
├── 05-api-design.md
├── 06-infrastructure.md
├── 07-risks.md
├── 08-timeline.md
└── CLAUDE.md
```

The `CLAUDE.md` should only be generated/updated during Phase 9, after all other phases are complete and confirmed.
