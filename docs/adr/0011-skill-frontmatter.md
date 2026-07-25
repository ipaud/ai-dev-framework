# ADR-0011: Richer skill frontmatter — allowed-tools shipped, paths and context: fork deferred

- **Status:** accepted
- **Date:** 2026-07-25
- **Targets:** v1.1 (roadmap S1)
- **Verified on:** Claude Code 2.1.205 (`claude --version`)

## Context
`docs/research/v1.1-agent-platform-2026.md` (finding 2) cites `agentskills.io` for the full set of
`SKILL.md` frontmatter fields ADF's 17 skills could adopt: `allowed-tools`, `disallowed-tools`,
`model`, `effort`, `context: fork`, `agent`, `hooks`, `paths`, `when_to_use`, `argument-hint`,
`arguments`, `disable-model-invocation`, `user-invocable`. Roadmap S1 scoped this down to
`allowed-tools` + `paths`, plus `context: fork` on review skills gated on "verify on target
version" (bug #17283, closed).

Re-verifying primary sources for this loop surfaced two corrections to that finding:

1. **Field provenance.** The open `agentskills.io` spec itself defines only six frontmatter fields:
   `name`, `description`, `license`, `compatibility`, `metadata`, `allowed-tools`. Everything else
   in the roadmap's list — `paths`, `context: fork`, `disallowed-tools`, `model`, `effort`, `agent`,
   `hooks`, `when_to_use`, `argument-hint`, `arguments`, `disable-model-invocation`,
   `user-invocable` — is a **Claude Code extension** documented at `code.claude.com/docs/en/skills`,
   not part of the portable standard. Doesn't block adoption (ADF already targets Claude Code
   first), but the citation in the research doc was imprecise.
2. **`allowed-tools` semantics.** It is not a static capability declaration. Per the Claude Code
   doc: "Tools Claude can use without asking permission **during the turn that invokes this
   skill**. The grant clears when you send your next message." It's a per-invocation permission
   pre-approval, scoped to exactly what the skill's own procedure does — not a general allowlist.

## Decision

### 1. `allowed-tools` — shipped on all 17 skills
Each skill's `allowed-tools` line was derived from its own documented `Procedure`/`Output`, not
guessed:
- **Read-only findings skills** (accessibility, architecture-review, dependency-review,
  design-system, performance-review, security-review, ux-review): `Read Grep Glob`.
- **Skills that edit or write files** (debugging, documentation, loop-engineering, ponytail,
  project-planner, refactoring, repo-analysis, risk-analysis, testing): add `Edit Write`.
- **`release`**: its procedure explicitly derives the changelog "from conventional commits since
  the last tag" and creates "an annotated tag" — `Bash(git log:*) Bash(git tag:*)` on top of
  `Read Edit Write`. `loop-engineering`: its Close step now checks the working tree (ADR-0010) —
  `Bash(git status:*)`.
- Gate commands (test/build/lint) are **not** pre-approved anywhere: they're adapter-defined
  (`adf-adapter/ADAPTER.md`), unknown to core. Git itself isn't a stack — it's already load-bearing
  throughout ADF (hooks, one-loop-one-commit, annotated tags) — so `Bash(git ...)` patterns don't
  violate the agnostic-core invariant the way a stack's test-runner command would.

### 2. `paths` — dropped, not applied
`paths` restricts **automatic** activation to when Claude is already working with files matching
the glob. Two problems for ADF specifically:
- Every plausible use (accessibility/design-system/ux-review scoped to UI file extensions;
  dependency-review scoped to manifest files) requires **naming a stack** (`.tsx`, `.vue`,
  `package.json`, …), which is exactly what `core/` must never do (constitution invariant 1).
- Even the process-only skills considered (`documentation`, `project-planner`, `release`) fit
  poorly: their trigger is a **moment** (loop close, planning conversation, release decision), not
  file-type context, and the trigger moment routinely precedes any file being touched. Scoping
  `paths` to `adf-memory/roadmap.md`, for example, would suppress `project-planner` exactly when
  it's needed — before the roadmap file is opened.

  `paths` fits skills whose whole job is "when you touch files like X, do Y" (a stack-specific
  linting/convention skill). None of ADF core's 17 skills are that shape by design — they're
  process skills, triggered by `description` matching a task, not by file context. No further
  action item here; this isn't a gap, it's a fit mismatch that won't change as ADF evolves core
  skills, only if a genuinely file-scoped skill is added later.

### 3. `context: fork` on review skills — deferred to S3
The research doc's own **open question** (not just the roadmap bullet) says: "which review skills
should run `context: fork` — needs a per-agent cost/quality benchmark first." That benchmark
infrastructure is roadmap **S3** (`skill-creator` evals), not yet built. Forking loses conversation
history — for a review skill, that means losing the active loop file, the diff just made, and any
established context, unless replaced with explicit dynamic-context injection (e.g. `` !`git diff` ``,
the pattern Claude Code's own docs use for a forked PR-summary skill). Flipping this on for 7
review skills without measuring pass-rate/token/time first is exactly the kind of change ADF's own
research caveats say not to cargo-cult. Re-open once S3 ships eval data.

## Consequences
- Permission friction drops for the 17 skills' own documented actions; nothing broader is granted.
- `paths` and `context: fork` remain open S1/S3 sub-items — `docs/roadmap.md` reflects this split
  rather than marking S1 fully done.
- Corrects the field-provenance citation in `docs/research/v1.1-agent-platform-2026.md` finding 2
  for any future reader relying on it (noted here rather than editing the frozen research doc).
