# ADR-0004: Objective gates and advisory score

- **Status:** accepted
- **Date:** 2026-06-26

## Context
ADF needs a single, trustworthy answer to "is this loop done?" A model-generated quality score is
useful as a trend but is subjective and gameable; objective gate commands (build, typecheck, lint,
test, perf, security) are reproducible and binary.

## Decision
**Objective gates decide done.** The adapter's per-tier gate commands are the source of truth; a
loop closes only when they are green, with their **real output pasted** into the loop's Validate.

The **AI Score is advisory** — a per-loop trend signal across eight axes, recorded in `score.md`.
It never gates, never blocks, never substitutes for a gate.

## Alternatives considered
- **Score as a gate** — subjective, gameable, and not reproducible across sessions.
- **No score at all** — loses a cheap early-warning signal for drift in architecture, testing,
  complexity, and the like.

## Consequences
- "Done" is reproducible and auditable: the loop log carries the real gate output.
- The score can be tracked over time without ever blocking work.
- `score.md` states this explicitly in its header, so the boundary can't be quietly forgotten.
