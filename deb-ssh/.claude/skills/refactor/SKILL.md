---
name: refactor
description: Analyze a codebase for cleanup, dead code, and non-idiomatic patterns and
  produce a ranked refactor plan covering test patterns and coverage. Makes no edits. Use
  when asked to refactor, clean up, tidy, simplify, modernize, find tech debt, audit the
  tests, or improve coverage.
argument-hint: "[path or subsystem]"
---

# Refactor

Read-only. The output is a ranked plan, not a diff. Scope to the argument, or ask which
subtree if none was given — a whole-repo sweep produces a list nobody acts on.

## 1. Orient

Read the repo's `CLAUDE.md`, `README`, and any local gate script the task runner invokes.
Read the Makefile, `package.json` scripts, or task runner to learn the real commands —
never assume them.

Run the repo's own gates and its test suite. Whatever they already flag is not a finding.
A red baseline is the first finding and everything else is conditional on it.

## 2. Measure coverage

Run it ephemerally. Never add a dependency or a config block to the repo to measure.

| Stack | Command |
|---|---|
| Python + uv | `uv run --with pytest-cov pytest --cov=<pkg> --cov-report=term-missing` |
| Python + pip | `python -m pytest --cov=<pkg> --cov-report=term-missing` |
| Go | `go test -coverprofile=$T/c.out ./... && go tool cover -func=$T/c.out` |
| Node / TS | `npx --yes -p vitest -p @vitest/coverage-v8 vitest run --coverage --passWithNoTests` |

Write artifacts to `$(mktemp -d)`. If a suite needs setup the repo's own test target
already handles, use that target. If a suite is deliberately held out of the default
target, leave it out and record it as not measured.

No number available? A source file with no test file is a 0% signal that needs no tool.

## 3. Survey

One agent per category, all seven spawned in a single message so they run concurrently. Each
one reads the whole scope for its category alone — a single reader looking for all seven
finds the loudest few per file and leaves the rest for a run that will never happen.

1. Dead and unreachable code — symbols with no caller, flags never passed, branches no
   input reaches, exports nothing imports.
2. Duplication, under rule 3.
3. Functions whose callers only want part of them.
4. Types doing unrelated jobs; parameters only some callers supply.
5. Hand-rolled code the stdlib or framework already provides.
6. Idiom, per the table below.
7. Tests, per the section below.

Each agent's prompt carries: the scope, the gate and linter output from §1, the coverage
numbers from §2, the rules below, the five-line finding format from §4, and every finding
already accepted this run. It reads and reports only — no edits, and no rerunning the gates,
the suite, or coverage. Those run once, here, in §1 and §2. It returns findings in the
five-line format or the word `none`.

Then run the round again, with the accumulated findings attached so agents skip them. Stop
when a full round adds nothing new. Verify each finding against the file before accepting
it; an agent that reports a symbol as uncalled has not seen every caller you have.

Report the round count and a per-category count, zeros included. A category whose agent
returned nothing is a zero; one whose agent failed or was skipped is reported as not run.

Rank by coverage. Uncovered code is not refactored — it is tested first.

## 4. Emit

Two artifacts. The inline summary is what gets read; the plan file is what gets worked from.

**Inline** — a numbered worklist in the order it should be done, one sentence per item, in
the reader's vocabulary and not this skill's. Never emit a label the reader has to look up:
no `tier:`, no `WRITE FIRST`, no term this file invented. Group under headings that say why
the group sits where it does — "nothing tests these yet", "one file each", "touches every
caller". The summary stands alone if the plan file is never opened.

**Plan file** — write it to the scratch dir. Do not add a file to the repo unless asked.
Each finding is five lines:

```
<file> — <what>
cost:   <the maintenance cost or failure this causes, concretely>
change: <the edit>
test:   <the test that passes before and after, or: none — write T<n> first>
reach:  one file | a few callers | every consumer
```

`reach` is the order: one file first, every consumer last. Publish what you cut as
one-liners with the reason.

## Rules

1. Every finding names a concrete cost. "Not idiomatic" is not a cost.
2. Never report what the linter, formatter, or type checker reports. Run them first. If a
   rule family is disabled, that is one finding with a count, not N findings.
3. Duplication is a finding only at 3+ copies that `git log` shows changing together, and
   only if one import path can reach them all — duplication the build or shipping model
   forces is accepted debt, not a finding.
4. Size alone is not a defect. A unit is too long only when a caller needs part of it or a
   test cannot reach a branch.
5. Behavior does not change. If the item cannot name the test that proves that, cut it.
6. The repo's own gates and `CLAUDE.md` outrank any general idiom.
7. No new layers, registries, base classes, or `utils`/`common` modules. An extraction
   targets a named thing with one reason to change.

## Tests

Audit against the repo's own doctrine first — if `CLAUDE.md` defines what a unit test is,
what may be faked, or how dependencies are injected, that is the rubric. Generic smells
only where the repo is silent: no assertion, asserting on the mock instead of the
observable, restating the implementation, shared mutable fixtures, sleep-based waits,
fakes that can only succeed, zero tests for a module.

Report the patterns worth propagating too, not only the smells.

A finding whose `test:` line names no existing test needs one written first. Those are
separate, numbered `T<n>`, and land before the finding that depends on them. Name the seam
pinned, the inputs, the observable asserted, and the one mutation to today's code that must
make it fail. If no mutation would, the test is theater.

Propose new tests only for what the plan touches plus the highest-risk uncovered path.
Name the case, not the module — "add tests for `foo.py`" is not an item.

## Idiom hints

| Language | Axes |
|---|---|
| Python | comprehensions and iterators over hand-rolled loops; dataclasses over attribute bags; context managers for paired setup/teardown; typed boundaries instead of `dict[str, Any]` |
| Go | `%w` wrapping with `errors.Is/As` at boundaries; `ctx` first and actually cancelling; interfaces declared at the consumer, ≤3 methods; table-driven subtests with `t.Cleanup` |
| TypeScript | discriminated unions over optional-field soup; `unknown` over `any` at boundaries; narrow at the edge, not at every use |
| Frontend | data loaded at the framework's own boundary, not in a component effect; derived state over effects that write state |
| Shell | `set -euo pipefail`; quoted expansions; no parsing `ls` |