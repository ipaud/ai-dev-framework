---
name: refactoring
description: Behavior-preserving structural change with tests green before and after, driven by ponytail. Use to improve structure without changing behavior. No feature change in the same loop.
---

# refactoring

## Purpose
Improve structure without changing behavior, provably.

## Trigger
Structure is in the way (duplication, coupling, a hotspot) and the change is purely structural.

## Procedure
1. **Green before** — run the adapter's test gate; it must pass before you touch anything. If
   there's no test covering the behavior, add one first.
2. **One structural move at a time** — extract, inline, rename, reshape — each small and reversible.
3. **Ponytail** — the goal is less: delete duplication, collapse indirection, drop dead flexibility.
4. **Green after** — the same gate passes, unchanged. Behavior is identical.
5. **No features** — if you find a behavior change is needed, stop and split it into its own loop.

## Output
A structural diff with the test gate green before and after, and zero behavior change.

## Anti-patterns
- Sneaking a behavior change into a refactor.
- Refactoring without a test net.
- "Refactoring" that adds abstraction instead of removing it.
