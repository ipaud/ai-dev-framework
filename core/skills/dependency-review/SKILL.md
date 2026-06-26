---
name: dependency-review
description: Judge each dependency on weight, maintenance health, alternatives, bundle/footprint impact, risk, and removability. Use when adding a dependency or auditing existing ones. Output is a keep / replace / remove verdict per dependency.
---

# dependency-review

## Purpose
Every dependency is a liability until it earns its place. Decide which stay.

## Trigger
Adding a dependency, or auditing the existing set.

## Procedure
For each dependency:
1. **Weight** — size and transitive footprint it pulls in.
2. **Maintenance health** — release cadence, open-issue trend, bus factor.
3. **Alternatives** — stdlib, a native feature, or an already-installed dependency that covers it.
4. **Footprint impact** — effect on the project's size/startup budget (thresholds from the adapter).
5. **Risk** — CVE history, breaking-change frequency, license fit.
6. **Removability** — how hard to drop later; how deeply it's woven in.
7. **Justification** — one sentence: why this, over doing it ourselves or using something installed.

## Output
A table: dependency → **keep / replace / remove**, each with the deciding reason. Removals and
replacements become loop items.

## Anti-patterns
- Adding a dependency for what a few lines of stdlib do (see ponytail).
- Keeping a dependency because removing it is work — measure the liability, then decide.
- Judging weight without the adapter's footprint budget.
