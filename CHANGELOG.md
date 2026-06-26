# Changelog

All notable changes to ADF are documented here. Format follows
[Keep a Changelog](https://keepachangelog.com/en/1.0.0/); ADF uses
[Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [0.1.0] — initial

Pre-1.0: the framework is built but unproven in a real project. Expect breaking changes to
skills, agents, and scripts until a consuming project validates the method.

### Added
- Agnostic core constitution (`core/CLAUDE.md`) and read order.
- 17 skills under `core/skills/`.
- 11 Claude Code subagents under `core/agents/`.
- 5 workflows and 11 fill-in templates.
- Memory templates including the advisory AI Score and the loop log template.
- Session-start / pre-edit / post-loop hooks.
- Consumer wiring scripts `adf-init.sh` and `adf-doctor.sh`.
- Adapter template and a worked GestureLab example adapter.
- Architecture decision records 0001–0006.
