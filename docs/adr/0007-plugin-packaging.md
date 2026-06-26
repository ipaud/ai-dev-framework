# ADR-0007: Plugin + marketplace packaging

- **Status:** accepted (manifest shipped; submodule retained as fallback)
- **Date:** 2026-06-26
- **Targets:** v1.1 (roadmap M1)

## Context
ADF v0.1.0 distributes itself as a git submodule wired by `adf-init.sh` (symlinks skills/agents
into `.claude/`, copy-fallback on exFAT, hand-merged `settings.json` hooks). Claude Code now has a
first-class plugin system: a `.claude-plugin/plugin.json` manifest bundles skills, agents, hooks,
and MCP/LSP servers (only `name` required; component path fields + semver `version` +
`dependencies`), and a `.claude-plugin/marketplace.json` at repo root makes it installable with
`claude plugin install <plugin>@<marketplace>`, with `update` and scope support. The official docs
include a "convert existing `.claude/` configurations to plugins" walkthrough.
— plugins-reference, plugin-marketplaces (code.claude.com).

## Decision (proposed)
Package ADF as a plugin with a marketplace manifest, giving native install/update/versioning in
place of the bespoke submodule+symlink flow. **Keep the submodule + `adf-init.sh` path** until an
exFAT/non-symlink portability test confirms the plugin covers ADF's copy-fallback cases. Rely only
on the stable manifest surface (skills/agents/hooks/mcpServers); avoid the experimental
`monitors`/`themes` keys.

## Alternatives considered
- **Stay submodule-only** — no native versioning/update; manual wiring; the symlink/exFAT fragility
  remains ADF's problem to maintain.
- **Plugin-only, drop the submodule** — cleanest, but unproven for exFAT/offline/local-path
  consumers; would regress the portability ADF deliberately built.

## Consequences
- Consumers get `install`/`update`/semver instead of submodule bumps + re-running init.
- ADF maintains two distribution paths during v1.1 until the plugin path is portability-proven.
- Open question: does the plugin path cover exFAT copy-fallback, or must the submodule remain the
  fallback indefinitely? Resolve with a test before marking accepted.
