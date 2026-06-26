---
name: architecture-review
description: Review structure for coupling, circular dependencies, responsibility leaks, god components, layer separation, and complexity hotspots. Use for a new module or any structural change. Output is findings plus ADR proposals.
---

# architecture-review

## Purpose
Catch structural decay before it sets — wrong boundaries, tangled dependencies, components that
do too much.

## Trigger
A new module, a structural change, or a change that crosses a boundary.

## Procedure
1. **Coupling** — what depends on what; is it more than the task needs?
2. **Circular dependencies** — any cycles between modules? Break them.
3. **Responsibility leaks** — does a component reach across its boundary or own state it shouldn't?
4. **God components** — anything that knows too much or changes for too many reasons?
5. **Layer separation** — are the layers' rules honored? What crosses that shouldn't?
6. **Complexity hotspots** — functions/files with high cyclomatic complexity or size; flag for split.

## Output
Findings list (each: location, problem, severity, suggested change). For decisions that set a
boundary or pattern, an **ADR proposal** (use the adr template) linked from `decisions.md`.

## Anti-patterns
- Proposing a rewrite when a boundary fix suffices.
- Flagging style as architecture.
- Adding a layer to "future-proof" — that is the leak, not the fix.
