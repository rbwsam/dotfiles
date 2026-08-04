# Git
- Never add AI/agent attribution to commits, PRs, or code comments.

# Code
Write what a fluent user of the language and framework would write.

- Idiom over translation. Do not carry another language's patterns across — no
  getters/setters in Python, no classes where a function does, no hand-rolled
  loops where a comprehension or iterator exists.
- The framework's own mechanism wins over a generic one you build. Use its
  routing, DI, config, migration, and test facilities as designed.
- Design in the shapes the ecosystem expects, not just the syntax. Match how a
  reader of this stack expects the pieces to be split, named, and wired.
- Match the surrounding code when it conflicts with the wider idiom. Consistency
  inside one codebase beats being right in the abstract.

# Docs and comments
Default to none. Both are debt, and a wrong one is worse than none.

- Code is the source of truth for what the system does. A doc says why a decision
  was made and what constraint forced it. Never write the same fact in both.
- A comment earns its place only by naming a non-obvious *why* with a concrete
  failure mode. Never narrate the next line. Never restate a value defined
  elsewhere — ports, paths, flags, names, versions.
- One owner per fact. Everywhere else names the owner. Two copies is two rules and
  one of them will be wrong.
- No hedging. No "will", "planned", "not yet", "for now", "in case we need it",
  "could be extended". If it is not true today it is not written.
- A claim about the world carries the version and date it was observed at, or it
  does not go in.
- Editing means deleting. When a change makes prose stale, cut the prose — never
  append a qualifier to it.
- Length is a defect. A rule that needs a paragraph is one you have not understood
  yet. No preambles, no summaries, no quality adjectives, no restating the section
  you just wrote.
- Do not write a doc or a README that was not asked for.

# Communication style

- Be terse.
- Cut preamble, recaps, and "here's what I did" summaries.
- Don't restate the question, hedge, or pad. No closing offers ("let me know
  if…") unless a decision is genuinely needed.
- Keep rationale to one line. Prefer short bullets over paragraphs.
- Don't append file:line references — name the file if needed, no line numbers.

# Questions

- Ask one question per message and wait for my reply. If you genuinely need
  several answers, use the AskUserQuestion tool or a numbered list — never
  unnumbered questions in prose.
- When presenting a list of items I might respond to, number each so I can
  reference it unambiguously. Cite source file:line only when I ask for it.

