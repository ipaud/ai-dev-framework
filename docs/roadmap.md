# ADF roadmap

> ADF's own roadmap (distinct from `core/memory/roadmap.md`, which is the agnostic template
> consumers fill in). Evidence base: `docs/research/v1.1-agent-platform-2026.md`. Each item names
> the source that justifies it. v0.1.0 formats are valid — everything below is additive.

## v1.1 — align with the 2026 Claude Code platform

### Must-have

- **M1 · Plugin + marketplace packaging.** Ship ADF as a Claude Code plugin
  (`.claude-plugin/plugin.json` + `marketplace.json`) for native `install`/`update`/semver,
  bundling the 17 skills + 11 agents + hooks. Keep the submodule path until an exFAT portability
  test confirms the plugin covers copy-fallback cases (ADR-0007). — *plugins-reference,
  plugin-marketplaces.*
- **M2 · Lifecycle + compaction hooks.** Add `PreCompact` (snapshot `adf-memory` before turns are
  summarized away), `SessionEnd` (durable state flush), and `UserPromptSubmit` (inject read-order +
  active loop each prompt). Closes the known memory-compaction gap (ADR-0008). — *hooks doc.*
- **M3 · Progress-file + clean-state gate.** Make durable cross-window state explicit: a progress
  log + git history, and a workflow exit gate requiring a clean, mergeable state per feature.
  Builds on one-loop-one-commit. — *effective-harnesses-for-long-running-agents.*

### Should-have

- **S1 · Richer skill frontmatter.** Add `allowed-tools` and `paths`; run review skills with
  `context: fork` for native isolation (verify on target version — bug #17283 now closed).
  — *skills doc, agentskills.io.*
- **S2 · Richer agent frontmatter.** Selective model tiers (opus for architect/planner, haiku for
  documenter), `disallowedTools`/`mcp__` patterns, `isolation: worktree` for write-capable agents.
  Gate on a per-agent cost/quality benchmark first. — *sub-agents doc.*
- **S3 · Real evals.** Adopt `skill-creator` benchmarking (pass-rate / tokens / time); feed the
  results into the advisory AI Score — score stays advisory, data gets real. — *skills doc.*
- **S4 · Delegation contracts.** Give each subagent an explicit objective / output-format / tools /
  boundaries; add a ~1–2k token summary budget and an effort-to-complexity rule to the workflows.
  — *multi-agent-research-system.*

### Nice-to-have

- **N1 · ADF output style** enforcing loop-tier discipline at the system-prompt level (select via
  `/config`, not the removed `/output-style` command). — *output-styles doc.*
- **N2 · MCP tool-scoping** patterns for the researcher/security agents. — *sub-agents doc.*

### Cross-cutting decision (open)

- **AGENTS.md portability.** ADF is CLAUDE.md-only while AGENTS.md is becoming a portable
  cross-tool standard (Linux Foundation, 60k+ repos, 25+ tools). Decide ADF's relationship before
  shipping v1.1 (ADR-0009). Needs a dedicated follow-up — the research pass did not resolve it.

## Promotion to v1.0

Per extract-don't-predict, ADF stays pre-1.0 until validated across ≥2 real projects. `adf-demo`
is the first. A second, different consumer (plus the v1.1 platform alignment) is the path to 1.0.
