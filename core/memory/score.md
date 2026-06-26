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

## Notes
<!-- One line per axis movement: "NNNN — testing 3→4: added regression for the parser." -->
