---
name: check
description: Pre-commit code review. Fixes issues across the project, runs lint/tests, and iterates until clean.
---

# Pre-Commit Code Review

Autonomous code review that fixes problems and iterates until the project is clean. The diff is the starting point, not the boundary — follow ripple effects wherever they lead.

## Step 1: Understand the Changes

Run `git diff`, `git diff --cached`, and `git status` to see all pending changes.

If there are no changes (clean working tree, nothing staged, no untracked source files), report that and stop.

Read any new untracked files shown by `git status`.

## Step 2: Understand the Context

Read outward from the changes along the dependency graph: callers, consumers, shared types, related tests, sibling files. Read enough to understand the full impact of the changes — not the entire codebase, but everything the changes touch or could affect.

For small projects (< ~20 source files), just read everything.

## Step 3: Lint, Format, and Type-Check

Check project config files (package.json, pyproject.toml, Makefile, Cargo.toml, etc.) for lint, format, and type-check tooling.

If found, run each with auto-fix where supported. Fix any remaining errors before proceeding. If no such tooling is configured, skip this step.

## Step 4: Review and Fix

Review the project in light of the changes. Fix anything you're confident is correct — not just in the diff, but anywhere the changes have ripple effects.

**Fix** when there's one clearly right answer:

- Bugs, logic errors, race conditions, resource leaks
- Security issues: injection, XSS, hardcoded secrets, insecure defaults
- Missing error handling, edge cases, validation gaps
- Dead code, unused imports, stale comments
- Redundant or unnecessarily complex code
- Inconsistencies introduced or exposed by the changes
- Callers, consumers, or related code that needs updating

**Report as suggestions** when there's genuine ambiguity:

- Multiple valid approaches where the right choice depends on intent
- Architectural changes with real trade-offs
- Additions that depend on product direction

If you're confident, fix it. If you're unsure, report it. Err toward fixing.

## Step 5: Run Tests

Run the project's test suite. If no test tooling is apparent, skip to the report.

## Step 6: Fix-and-Retest Loop (max 5 attempts)

If tests fail:

1. Analyze each failure — if it doesn't exercise any changed code (yours or the original changes), treat it as pre-existing
2. Fix failures caused by the changes
3. Re-run failing tests
4. Repeat until passing or 5 attempts exhausted

Do not fix pre-existing test failures.

## Step 7: Report

**Review complete.**

- **Fixed**: list each fix (yours and from earlier steps), or "None"
- **Tests**: pass/fail summary, or "No test suite found"
- **Pre-existing failures**: any failures unrelated to the changes, or "None"
- **Suggestions**: only items with genuine ambiguity, or "None"
