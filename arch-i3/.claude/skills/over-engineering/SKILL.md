---
name: over-engineering
description: Find over-engineering in an app — abstractions, layers, protocols, and
  designs that can collapse — and report a ranked list of simplifications. Read-only,
  makes no edits. Use when asked to look for over-engineering, over-abstraction,
  unnecessary indirection or layers, YAGNI violations, or whether a design is heavier
  than the problem.
argument-hint: "[path or subsystem]"
---

# Over-engineering

Read-only. The output is a numbered list, nothing else. Scope to the argument; ask which
subtree if none was given.

Not the same job as `refactor` or `simplify`: those tidy code that stays. This one deletes
concepts. If the finding does not remove a layer, a protocol, an abstraction, or a
dependency, it belongs to that skill, not this one.

## 1. Orient

Read `CLAUDE.md`, the `README`, and the entrypoints. Learn what the app is for and what
constraints it declares — complexity a stated constraint forces is not a finding. Note the
scale it actually runs at; most over-engineering is design for a scale that never arrived.

## 2. Survey

One read-only agent per dimension, all spawned in a single message. Each reads the whole
scope for its dimension alone. Give each the scope, the constraints from §1, the rules
below, and the finding format from §3.

1. Interfaces, seams, and abstract types with one implementation.
2. Generics, options, config keys, and parameters that only ever take one value.
3. Layers that only forward — wrappers, adapters, and services that add no decision.
4. Registries, factories, plugin systems, and dispatch tables over a fixed known set.
5. Hand-built protocols, state machines, queues, and caches where a direct call, the
   stdlib, or the framework already suffices.
6. Speculative generality — extension points, versioning, hooks, and error paths for
   callers and cases that do not exist.

Verify every claim against the files before accepting it. An agent reporting "one
implementation" has not seen every implementation you can.

## 3. Emit

A numbered inline list, ranked by concepts removed. Two lines each:

```
<n>. <what to collapse, and to what>
   <the cost it carries today — one line>
```

Say what disappears: which files, types, or ideas a reader no longer has to hold. Then
one closing line naming what you looked at and found clean.

## Rules

1. Every finding names its collapse target and what gets deleted. "Could be simpler" is
   not a finding.
2. The floor is significant. A removed layer, protocol, or dependency qualifies; a renamed
   variable or shorter function does not.
3. A seam the tests require, or that `CLAUDE.md` mandates, is not over-engineering.
4. One implementation today is the signal; a second one planned is not a defense unless
   the repo shows it being built.
5. Behavior stays. A collapse that drops a capability is a question for the user, marked
   as such.
6. No edits, no new files in the repo.
