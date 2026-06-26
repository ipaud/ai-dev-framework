# Workflow: refactor

Behavior-preserving structural change. No feature change in the same loop.

## Agents in order
1. **adf-architect** — name the structural target (coupling, duplication, hotspot) and the move.
2. **adf-implementer / adf-simplifier** — make the structural change; ponytail toward less.
3. **adf-tester** — the test gate is **green before and green after**; behavior identical.
4. **adf-documenter** — update `architecture.md` if boundaries moved.

## Exit gate
The adapter's test gate green before and after with no behavior change, real output in the loop's
Validate. If a behavior change turns out to be needed, stop and split it into its own loop.
