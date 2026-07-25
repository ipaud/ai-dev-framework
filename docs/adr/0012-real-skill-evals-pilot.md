# ADR-0012: Real skill evals — pilot on `ponytail`, mechanism proven

- **Status:** accepted
- **Date:** 2026-07-25
- **Targets:** v1.1 (roadmap S3)

## Context
Roadmap S3 calls for adopting `skill-creator` benchmarking (pass-rate / tokens / time) so the
advisory AI Score (`core/memory/score.md`, ADR-0004) is backed by real data instead of vibes. Two
paths exist:

1. **`claude plugin eval`** — a native CLI eval runner (`evals/**/case.yaml` + graders). Checked
   first: gated behind early access in this environment (`` `plugin eval` is currently in early
   access ``), not usable yet.
2. **`skill-creator@claude-plugins-official`** — the official plugin described in the skills doc.
   Installed successfully (`claude plugin install skill-creator@claude-plugins-official`, scope:
   user). Its automated loop (`scripts/run_loop.py`, `agents/grader.md`) is designed to run through
   Claude Code's own skill-invocation mechanism, which requires `/reload-plugins` to pick up a
   plugin installed mid-session — not available from inside a running conversation.

Running either path for real, paid evals across all 17 skills without checking first would spend a
non-trivial, unbounded amount of tokens on the user's behalf. Per the constitution's "objective
gates decide done" and "extract, don't predict," the right move was a small, real pilot to prove
the mechanism before proposing a full rollout — confirmed with the user, scoped to one skill.

## Decision
**Piloted `ponytail`** (clear, falsifiable, and self-documenting — it ships its own worked example)
with one eval case, one run per arm, hand-orchestrated via the `Agent` tool rather than
`run_loop.py`, since the plugin's own runner wasn't reachable this session:

- `core/skills/ponytail/evals/evals.json` — schema-compliant with skill-creator's `evals.json`
  (`references/schemas.md`), so a future in-session run through the real plugin is a drop-in
  replacement for this manual pilot.
- **With-skill arm**: a `general-purpose` subagent given the task ("Add a cache for these API
  responses" — the skill's own example) with `ponytail`'s full `SKILL.md` body injected as
  instructions — the same mechanism `context: fork` uses (skill content becomes the prompt).
- **Without-skill arm (baseline)**: the identical task and starting file, no skill guidance.
- **Grading**: done by hand against the eval's four `expectations` (no separate grader subagent
  spawned, to keep the pilot's cost minimal) — recorded in `core/skills/ponytail/evals/results/
  2026-07-25-pilot/grading-{with,without}-skill.json`, aggregated in `benchmark.json`.

### Result (real, not fabricated — see the JSON files for full transcripts/evidence)
| | pass rate | tokens | duration |
|---|---|---|---|
| With skill | 4/4 (100%) | 60,806 | 21.2s |
| Without skill (baseline) | 2/4 (50%) | 60,280 | 20.6s |

Cost was flat (~1% token difference, ~3% time difference) — the skill didn't make the subagent
slower or more expensive. The baseline built a hand-rolled TTL cache (module dict +
`time.monotonic()` + manual expiry — a custom abstraction); with the skill, the same request
produced one `functools.lru_cache` decorator, passing every expectation. Same budget, smaller
output — `ponytail` doing exactly its stated job, now with a real number behind it instead of an
assumption.

## Caveats
- **n=1 per arm.** `skill-creator` defaults to 3 runs/case specifically to control for LLM sampling
  variance. This pilot proves the pipeline and gives one real data point — it is not a
  statistically robust benchmark. Don't generalize the exact 50pp delta; do generalize that the
  mechanism works and produces real, checkable evidence.
- Grading was manual (by the orchestrating session), not a separate grader subagent — a further
  simplification versus the full `skill-creator` loop, acceptable for a one-case pilot, not for a
  production benchmark run (independent grading matters more at scale).
- `skill-creator` is now installed at **user** scope (global, not project-local) — reversible with
  `claude plugin uninstall skill-creator`. Flagged here since it's a change outside this repo.

## Consequences
- `core/skills/ponytail/evals/` is the first real eval fixture in ADF core; its `evals.json` shape
  is the template for adding cases to other skills.
- `core/memory/score.md` now points to `evals/results/*/benchmark.json` as grounding for the
  Complexity/Tech-debt axes when a skill has one — additive, doesn't change the advisory-only rule
  (ADR-0004).
- Full rollout (evals for the other 16 skills, `run_loop.py` once `/reload-plugins` is available or
  `claude plugin eval` once early access lifts) is follow-up work, not done in this loop — scope
  was deliberately kept to "prove it once," per the user's explicit choice of the piloted-not-full
  option.
- Once `claude plugin eval`'s early-access gate lifts, re-evaluate: it's CLI-native (no
  `/reload-plugins` dependency, scriptable in CI via `--json`), likely a better fit for ADF's
  hook-driven workflow than the plugin's in-session loop.
