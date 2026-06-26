# ADR-0002: Skill and agent mechanism

- **Status:** accepted
- **Date:** 2026-06-26

## Context
Claude Code discovers skills under `.claude/skills/<name>/SKILL.md` and agents under
`.claude/agents/<name>.md`. ADF wants a single source of truth for these in the agnostic core
(`core/skills/`, `core/agents/`), while still having them load in a consuming project.

## Decision
Keep the source of truth in `core/` and **expose it to Claude Code by symlinking** each skill
folder and agent file into the consumer's `.claude/` during `adf-init.sh`. One source, two views:
edit in `core/`, discovered under `.claude/`.

On filesystems without symlink support (e.g. exFAT), init **falls back to copying** and logs it.
`adf-doctor.sh` verifies "wired (symlink or copy)" rather than assuming symlinks.

## Alternatives considered
- **Author skills/agents directly in `.claude/`** — would scatter the source across consumers and
  break the agnostic-core boundary.
- **Copy on init always** — copies go stale after a core update; symlinks stay live.
- **A build step that generates `.claude/`** — more machinery than a symlink for no added benefit.

## Consequences
- Editing a skill or agent in `core/` is immediately reflected in a symlinked consumer.
- Copy-mode consumers must re-run `adf-init.sh` after a core submodule update (logged in
  `docs/known-issues.md`).
- Wiring is verifiable: `adf-doctor.sh` checks every link resolves.
