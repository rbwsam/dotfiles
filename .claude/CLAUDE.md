  ## Code Style

  - Make minimal changes to accomplish the task.
  - Prefer simple, readable code over clever abstractions.
  - Always consider security and best practices.
  - Always use the idiomatic style for the language and framework being used.
  - Always use modern syntax.

  ## Suggestions

  After completing changes, list suggested improvements separately (do not apply). Always verfiy your suggestions before offering them.

  Format:

  **Suggestions:**
  1. [suggestion]

  Focus on: security issues, performance, maintainability.

  ## Preferences

  - DO NOT WASTE TIME EXPLORING CODE, ASK FIRST.
  - Distinguish between questions and requests. Answer questions fully before proposing or making any code changes.
  - Plan changes before suggesting code changes.
  - Node: Use fnm, npm
  - Python: Use uv, target latest stable Python
  - Conventional commits format with markdown list, no prefixes
  - Do not add AI co-authors to commit messages.

  - Shell: Bash-compatible
  - Do not save memories for instructions already in CLAUDE.md. It is loaded every conversation and is already persistent.

  ## Best Practices (Non-Negotiable)

  - Use latest stable versions of all dependencies (Node.js, databases, etc.)
  - Production databases: always use versioned migrations (e.g., `drizzle-kit migrate`), never schema push
  - Minimize configuration: no boilerplate, no unnecessary options, no premature optimization
  - Be decisive: apply best practices by default, only ask about actual trade-offs
  - Prefer pragmatic, industry-standard solutions over theoretically pure ones. Don't add complexity to chase marginal security/correctness gains when the simple approach is widely accepted.

  ## Before Implementation
  When a task requires you to decide HOW to accomplish it, present your plan
  for approval before writing code:

  **Approach:**
  - SCHEMA/CREATE/MODIFY/DELETE for what's changing
  - INTRODUCE for anything new to the codebase (dependency, pattern, convention)
  - Group files by area if more than 5

  **Required Actions (things outside Claude's reach):**
  - BLOCKING — must happen for successful deploy
  - CLEANUP — safe to defer
  - Only include actions I must perform myself (env vars, external config,
    manual steps, informing teammates). Omit commands Claude will run.
  - Omit this section entirely if there are none.

  Skip this entirely when I've told you exactly what to change and where.

  ## After Implementation
  Repeat Required Actions as a checklist, updated to reflect what was actually
  implemented. Include any new actions that emerged during implementation.
  Each item must be self-contained (specific command, variable, or config name)
  so it makes sense without re-reading the conversation.
  Omit if there are none.
