# ADF roadmap

> ADF's own roadmap (distinct from `core/memory/roadmap.md`, which is the agnostic template
> consumers fill in). Evidence base: `docs/research/v1.1-agent-platform-2026.md`. Each item names
> the source that justifies it. v0.1.0 formats are valid — everything below is additive.

## v1.1 — align with the 2026 Claude Code platform

### Must-have

- **M1 ✅ done · Plugin + marketplace packaging.** Shipped `.claude-plugin/plugin.json` +
  `marketplace.json` + `core/hooks/hooks.json` (`${CLAUDE_PLUGIN_ROOT}`); submodule retained as the
  state-seeding path (ADR-0007). — *plugins-reference, plugin-marketplaces.*
- **M2 ✅ done · Lifecycle + compaction hooks.** Added `PreCompact`, `SessionEnd`, and
  `UserPromptSubmit` hooks, wired by init + checked by doctor (ADR-0008). — *hooks doc.*
- **M3 ✅ done · Progress-file + clean-state gate.** Formalized the active loop file + `project.md`
  as the progress file (no new file); `post-loop.sh` now runs a real `git status` clean-state check
  instead of a printed reminder; `feature.md`'s exit gate and `loop-engineering`'s Close step both
  name the clean-tree requirement (ADR-0010). — *effective-harnesses-for-long-running-agents.*

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

- **AGENTS.md portability ✅ done.** Constitution moved to the submodule root (`adf/CLAUDE.md` now
  resolves) and mirrored as `adf/AGENTS.md`; init emits both `CLAUDE.md` and `AGENTS.md` in the
  consumer (ADR-0009). ADF is now portable to AGENTS.md-reading tools.

## Promotion to v1.0

Per extract-don't-predict, ADF stays pre-1.0 until validated across ≥2 real projects. `adf-demo`
is the first. A second, different consumer (plus the v1.1 platform alignment) is the path to 1.0.
