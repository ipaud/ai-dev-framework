# ADR-0006: Skill promotion

- **Status:** accepted
- **Date:** 2026-06-26

## Context
Projects will grow their own skills in `adf-adapter/skills/`. Some are genuinely reusable; most
are project-specific. Core must stay small and agnostic, so not every useful skill belongs in it.

## Decision
A project-specific skill is **promoted to `core/skills/` only after it has proven useful in ≥2
projects**. Until then it lives in the consumer's `adf-adapter/skills/`. Promotion requires the
skill to be rewritten agnostic — no stack names — to fit the core boundary.

## Alternatives considered
- **Promote on first use** — pollutes core with one-off, often stack-specific skills.
- **Never promote** — duplicates genuinely reusable skills across projects.

## Consequences
- Core grows slowly and only with skills that have earned reuse.
- The ≥2-project bar is a concrete, checkable gate, not a judgment call.
- Promotion forces an agnostic rewrite, preserving the core boundary.
