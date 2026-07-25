---
name: testing
description: Decide what needs tests, where they live, the coverage target, and what is not worth testing. Use when designing, writing, or running tests for a change. Output is a test plan plus the tests.
allowed-tools: Read Grep Glob Edit Write
---

# testing

## Purpose
Put tests where they catch real regressions and skip them where they only cost maintenance.

## Trigger
Any change that adds or alters behavior; bug fixes (regression test); before closing a
feature-tier loop.

## Procedure
1. **Decide what needs tests** — behavior that can break and matters: branches, loops, parsers,
   money/security paths, public contracts. Skip trivial one-liners and pure glue.
2. **Pick the level** — unit for logic, integration for boundaries/contracts, end-to-end for
   critical user flows. Prefer the lowest level that gives real signal.
3. **Place them** — next to the code or in the project's test layout (from the adapter).
4. **Structure** — Arrange / Act / Assert; descriptive names stating the behavior under test.
5. **Coverage target** — meet the adapter's target where it matters; don't chase a number on glue.
6. **Run the gate** — the adapter's test command; paste output into the loop's Validate.

## Output
A short test plan (what is tested, at what level, what is deliberately not) and the tests
themselves, green under the adapter's test gate.

## Anti-patterns
- Asserting implementation detail instead of behavior — brittle, low signal.
- Chasing a coverage percentage on code that can't meaningfully break.
- Fixing a test to match a bug instead of fixing the code.
