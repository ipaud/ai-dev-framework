# ADR-0009: AGENTS.md portability

- **Status:** proposed (decision open)
- **Date:** 2026-06-26
- **Targets:** v1.1 (roadmap cross-cutting)

## Context
ADF's constitution and consumer wiring are CLAUDE.md-centric. Meanwhile **AGENTS.md** has emerged
as a portable cross-tool standard — plain Markdown, a "README for agents," now stewarded by the
Agentic AI Foundation under the Linux Foundation, with 60k+ repositories and 25+ supporting tools
(Codex, Jules, Cursor, Aider, VS Code, Copilot, Devin). — agents.md.

A framework whose whole value is a portable working method risks being locked to one tool if it
speaks only CLAUDE.md. The deep-research pass (`docs/research/v1.1-agent-platform-2026.md`) flagged
this but did **not** resolve it: no verified claim survived on AGENTS.md vs spec-driven dev
(spec-kit, OpenSpec) or the Agent SDK's relationship to ADF's CORE constitution. This is the one
research question left open.

## Decision (proposed — NOT yet decided)
Candidate directions, to be resolved by a dedicated follow-up before v1.1 ships:
- **A. Emit `AGENTS.md`** in the consumer that points at the same read order as the thin `CLAUDE.md`
  (single source, two entry files), so non-Claude tools get ADF's method too.
- **B. Make the constitution tool-neutral** and have both `CLAUDE.md` and `AGENTS.md` be thin
  pointers to it.
- **C. Stay CLAUDE.md-only** and accept the portability limit (rejected unless the follow-up shows
  AGENTS.md adoption is not load-bearing for ADF's users).

## Alternatives considered
See A/B/C above. No option is accepted yet — this ADR records the open decision so it isn't lost.

## Consequences
- Until resolved, ADF remains Claude Code-specific in practice.
- The follow-up must also place spec-driven dev (spec-kit, OpenSpec) relative to ADF's loop method:
  complement, absorb, or ignore.
- Whichever direction wins, the agnostic-core invariant must hold — no stack or tool names leak into
  `core/`.
