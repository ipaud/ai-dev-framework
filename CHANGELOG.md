# Changelog

All notable changes to ADF are documented here. Format follows
[Keep a Changelog](https://keepachangelog.com/en/1.0.0/); ADF uses
[Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- Clean-state gate: `post-loop.sh` (`Stop` hook) runs a real `git status` check (`PASS`/`WARN`/
  `SKIP`) instead of a printed checklist item; `feature.md`'s exit gate and `loop-engineering`'s
  Close step both require a clean, mergeable working tree (ADR-0010, roadmap M3 — last v1.1
  must-have).

### Changed
- `loop-engineering` SKILL.md formalizes the active loop file + `project.md` as the progress file
  the `PreCompact`/`SessionEnd` hooks re-anchor from (no new file added).

## [0.2.0] — platform alignment

Aligns ADF with the 2026 Claude Code platform. Evidence base:
`docs/research/v1.1-agent-platform-2026.md` (22 primary sources, 25 verified claims).

### Added
- Plugin packaging: `.claude-plugin/plugin.json` + `marketplace.json` + `core/hooks/hooks.json`
  (`${CLAUDE_PLUGIN_ROOT}`), installable via `claude plugin install adf@adf` (ADR-0007).
- Lifecycle + compaction hooks: `PreCompact`, `SessionEnd`, `UserPromptSubmit` — wired by
  `adf-init.sh`, checked by `adf-doctor.sh` (ADR-0008).
- AGENTS.md portability: consumer gets both `CLAUDE.md` and `AGENTS.md`; ADF repo gains a root
  `AGENTS.md` (ADR-0009).
- `docs/roadmap.md` (v1.1 backlog) and ADRs 0007–0009.

### Changed
- Constitution moved from `core/CLAUDE.md` to the submodule root `CLAUDE.md`, so the
  `adf/CLAUDE.md` pointer used everywhere now resolves from a consumer.

### Fixed
- Broken read-order pointer: `adf/CLAUDE.md` previously did not exist (constitution was nested in
  `core/`).

## [0.1.0] — initial

Pre-1.0: the framework is built but unproven in a real project. Expect breaking changes to
skills, agents, and scripts until a consuming project validates the method.

### Added
- Agnostic constitution (`CLAUDE.md`) and read order.
- 17 skills under `core/skills/`.
- 11 Claude Code subagents under `core/agents/`.
- 5 workflows and 11 fill-in templates.
- Memory templates including the advisory AI Score and the loop log template.
- Session-start / pre-edit / post-loop hooks.
- Consumer wiring scripts `adf-init.sh` and `adf-doctor.sh`.
- Adapter template and a worked GestureLab example adapter.
- Architecture decision records 0001–0006.
