# ADR-0010: Progress-file + clean-state gate

- **Status:** accepted
- **Date:** 2026-07-25
- **Targets:** v1.1 (roadmap M3)

## Context
ADR-0008 wired `PreCompact`/`SessionEnd`/`UserPromptSubmit` hooks to keep memory current across
context loss, but left roadmap M3 open: make the **progress file** explicit, and add a workflow
**exit gate requiring a clean, mergeable state**, per
`effective-harnesses-for-long-running-agents` (durable external state + one-feature-clean-finish).

Per Delete Before Create, the first question is whether a new file format is needed at all. It is
not: `adf-memory/loops/NNNN-slug.md` (the active loop) plus `project.md` already carry Goal, Plan,
Validate, and works/in-flight/broken — exactly what a progress file needs — and the M2 hooks
already treat them as such (`pre-compact.sh`, `session-end.sh`, `post-loop.sh` all resolve and
print the active loop path). What was missing was (1) saying so explicitly, and (2) a real
clean-state check instead of a printed reminder.

## Decision
1. **No new file.** Formalize in `core/skills/loop-engineering/SKILL.md` that the active loop file
   + `project.md` **are** the progress file the hooks re-anchor from.
2. **Real clean-state check.** `post-loop.sh` (the `Stop` hook) now runs `git status --porcelain`
   and prints `PASS`/`WARN`/`SKIP`, matching `adf-doctor.sh`'s vocabulary, instead of only listing
   a checklist item. It stays non-blocking (echo only, no `exit 2`) — consistent with every other
   ADF hook, all of which are advisory prints, not blockers.
3. **Exit gate updated.** `core/workflows/feature.md`'s exit gate now names a clean, mergeable
   working tree as a condition alongside gates-green and memory-updated. `core/skills/loop-
   engineering/SKILL.md`'s Close step (all tiers) states the same requirement.

## Alternatives considered
- **New `adf-memory/progress.md` file** — rejected: duplicates the active loop file and `project.md`,
  and would drift out of sync with them (two sources of truth for the same state).
- **Blocking `Stop` hook (`exit 2`) on a dirty tree** — rejected: every ADF hook today is advisory-
  only; a blocking hook is a bigger behavior change than this loop's scope and would fight
  legitimate multi-commit-in-progress states the hook can't distinguish from a forgotten commit.

## Consequences
- `docs/roadmap.md` M3 moves to done; no must-have items remain open for v1.1.
- The `Stop` hook now shells out to `git status`; adds a fast, read-only call, no new dependency.
- Consumers already running `adf-init.sh`/`adf-doctor.sh` pick this up on next hook sync — no
  migration needed since the hook path and event wiring are unchanged.
