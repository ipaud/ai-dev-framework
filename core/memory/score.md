# AI Score

> **Advisory trend signal only — NEVER a gate.** Objective gates (the adapter's per-tier gate
> commands) decide whether a loop is done. This score never blocks a loop, never substitutes for
> a gate, and never overrides green gates. It exists to surface drift over time, nothing more.

Score each axis 1–5 at loop close (optional). Higher is better. Record the loop and a one-line
note when an axis moves.

| Loop | Architecture | Performance | Security | Testing | UX | Docs | Tech-debt | Complexity |
|---|---|---|---|---|---|---|---|---|
<!-- | NNNN-slug | 4 | 3 | 4 | 4 | 3 | 4 | 3 | 4 | -->

## Axis meaning

- **Architecture** — boundaries clean, coupling low.
- **Performance** — within the adapter budget, no obvious waste.
- **Security** — inputs validated, secrets handled, surface minimal.
- **Testing** — meaningful coverage where it matters.
- **UX** — states covered, feedback clear (n/a for non-UI work).
- **Docs** — memory and docs match reality.
- **Tech-debt** — deliberate shortcuts tracked, not accumulating silently.
- **Complexity** — smallest correct shape; Delete Before Create honored.

## Grounding in real eval data

Axes stay subjective 1–5 vibes by default — that's fine, this score is advisory only (see ADR-0004).
Where a skill has real benchmark data (`core/skills/<skill>/evals/results/*/benchmark.json`, per
ADR-0012), let it inform the related axis instead of guessing: a skill with a measured pass-rate
delta backs the **Complexity** or **Tech-debt** score it drove that loop. No benchmark yet for most
skills — score by judgment until one exists, same as before.

## Notes
<!-- One line per axis movement: "NNNN — testing 3→4: added regression for the parser." -->
