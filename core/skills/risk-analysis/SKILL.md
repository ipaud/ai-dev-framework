---
name: risk-analysis
description: Surface technical, product, and security risks; rate likelihood × impact; propose mitigations. Use during planning, before a risky change, or at loop reflect. Logs to known-issues.md.
allowed-tools: Read Grep Glob Edit Write
---

# risk-analysis

## Purpose
Name the things that could go wrong while there's still cheap time to act on them.

## Trigger
Planning, before a risky or irreversible change, or at a loop's Reflect step.

## Procedure
1. **Technical risks** — fragile assumptions, hard-to-reverse decisions, unproven approaches.
2. **Product risks** — building the wrong thing, unclear acceptance, scope drift.
3. **Security risks** — exposure introduced by the change (cross-check security-review).
4. **Rate** — each risk: **likelihood** (low/med/high) × **impact** (low/med/high).
5. **Mitigate** — for each high-likelihood or high-impact risk, a concrete mitigation or the
   trigger that would force action.
6. **Log** — write risks and mitigations to `known-issues.md`; don't silently fix them.

## Output
A risk list with likelihood × impact and mitigations, appended to `known-issues.md`. High×high
risks become loop items or explicit accepted-risk entries.

## Anti-patterns
- Listing risks without rating or mitigating them.
- Quietly fixing a risk instead of recording the decision.
- Treating every low risk as a blocker.
