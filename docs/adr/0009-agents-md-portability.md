# ADR-0009: AGENTS.md portability

- **Status:** accepted
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

## Decision
**Option B (chosen).** The constitution is tool-neutral and reachable by both names:
- ADF's own constitution lives at the submodule root `CLAUDE.md`, mirrored by a root `AGENTS.md`
  pointer — so `adf/CLAUDE.md` and `adf/AGENTS.md` both resolve from a consumer.
- `adf-init.sh` emits **two identical thin entry files** in the consumer — `CLAUDE.md` and
  `AGENTS.md` — pointing at the same read order. Two real files (not a symlink) so the pointer
  survives exFAT and tools that don't follow symlinks.

AGENTS.md is freeform Markdown (no required schema), repo-root with nearest-file-wins, and
coexists with CLAUDE.md (verified against agents.md). This gives ADF portability to the 25+ tools
that read AGENTS.md without abandoning Claude Code's CLAUDE.md.

Also fixed in this loop: the constitution was at `core/CLAUDE.md` while every pointer referenced
`adf/CLAUDE.md`, which did not resolve from a consumer. Moving it to the submodule root corrects
this.

### Alternatives rejected
- **A. AGENTS.md only as a consumer pointer** — leaves ADF's own repo CLAUDE.md-only and the
  broken `adf/CLAUDE.md` path unfixed.
- **C. Stay CLAUDE.md-only** — accepts a portability limit with no offsetting benefit.

## Alternatives considered
See A/B/C above. No option is accepted yet — this ADR records the open decision so it isn't lost.

## Consequences
- Until resolved, ADF remains Claude Code-specific in practice.
- The follow-up must also place spec-driven dev (spec-kit, OpenSpec) relative to ADF's loop method:
  complement, absorb, or ignore.
- Whichever direction wins, the agnostic-core invariant must hold — no stack or tool names leak into
  `core/`.
