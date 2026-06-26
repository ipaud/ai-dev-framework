# ADR-0008: Lifecycle hooks and compaction

- **Status:** accepted
- **Date:** 2026-06-26
- **Targets:** v1.1 (roadmap M2; M3 progress-gate still pending)

## Context
ADF v0.1.0 wires only `SessionStart`, `PreToolUse(Edit|Write)`, and `Stop`. Its known memory issue
(`docs/known-issues.md`: append-only growth → future compaction) maps directly onto hook events ADF
does not use: `PreCompact` (fires before context compaction, can block), `PostCompact`,
`SessionEnd` (matchers clear/resume/logout/prompt_input_exit), `UserPromptSubmit` (can block via
exit 2 and inject context), and `SubagentStart/Stop`. — hooks doc, plugins-reference.

Anthropic's harness guidance is explicit that **compaction alone is insufficient**: durable
external state (a progress file + git history) is needed to reconstruct work across fresh context
windows, and work should be scoped to one feature ending in a clean, mergeable state.
— effective-harnesses-for-long-running-agents.

## Decision (proposed)
1. Add a **`PreCompact`** hook that snapshots active `adf-memory` state (project.md + active loop)
   before earlier turns are summarized away, and a **`SessionEnd`** hook that flushes durable state.
2. Add a **`UserPromptSubmit`** hook that injects the read-order and active-loop path each prompt
   (today only `SessionStart` does this — it goes stale within a session).
3. Make the **progress-file + clean-state gate** explicit in the workflows: a loop closes only on a
   clean, mergeable state, reinforcing one-loop-one-commit.

## Alternatives considered
- **Rely on built-in compaction** — Anthropic states this falls short for sustained work.
- **Add only PreCompact** — leaves the within-session staleness (UserPromptSubmit) and end-of-session
  flush (SessionEnd) gaps open.

## Consequences
- Memory survives compaction and session boundaries instead of decaying silently.
- More hook scripts to maintain and keep BSD-portable + quoted (per existing build constraints).
- `docs/known-issues.md`'s compaction entry moves from "deferred" to "addressed in v1.1".
