---
name: check
description: Review pending code changes, fix issues, run tests, and iterate until the code is clean.
---

# Review, Fix, and Test

Review pending code changes, fix issues, run tests, and iterate until the code is clean.

**Options** (passed as `$ARGUMENTS`): `--no-tests` to skip test steps, `--no-lint` to skip lint/format/typecheck.

Parse `$ARGUMENTS` for these flags before starting. Multiple flags can be combined.

## Step 1: Gather Changes

Run `git diff`, `git diff --cached`, and `git status` to see all pending changes.

If there are no changes (clean working tree, nothing staged, no untracked source files), report that and stop.

Read any new untracked files shown by `git status` so you can review their contents.

## Step 2: Lint, Format, and Type-Check

Check project config files (package.json, pyproject.toml, Makefile, Cargo.toml, etc.) for lint, format, and type-check tooling.

If found, run each with auto-fix where supported. Fix any remaining errors before proceeding. If no such tooling is configured, skip this step.

## Step 3: Code Review

Review all pending changes (including new files) for:

- **Bugs**: Logic errors, off-by-one, null/undefined access, race conditions, resource leaks
- **Security**: Injection, XSS, hardcoded secrets, insecure defaults
- **Correctness**: Edge cases, boundary conditions, type mismatches, missing error handling
- **Code quality**: Dead code, unused imports, duplication, needlessly complex logic

Do NOT flag or fix:
- Cosmetic or subjective style preferences
- Existing code not modified by these changes

Fix any issues found. Make minimal, targeted changes — do not refactor beyond what is needed to resolve the issue.

## Step 4: Run Tests

Detect the test framework from project config. Run the test suite. If the runner supports filtering by file or pattern, scope to tests related to the changed code first, then run the full suite after those pass.

If no test configuration is found, note it and skip to the final report.

## Step 5: Fix-and-Retest Loop (max 5 attempts)

If tests fail:

1. Analyze each failure — if a failing test does not exercise any of the changed code, treat it as pre-existing
2. Fix only failures caused by the pending changes
3. Re-run failing tests
4. Repeat until passing or 5 attempts exhausted

Do not fix pre-existing test failures.

## Step 6: Report

**Review complete.**

- **Issues fixed**: list each fix, or "None"
- **Tests**: pass/fail status, or "No test suite found"
- **Pre-existing failures**: any failures unrelated to pending changes, or "None"
- **Suggestions**: improvements noticed but not applied (security, performance, maintainability only)
