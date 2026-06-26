# Continue

Use this to resume work on an ADF project in a fresh session.

1. **Load the read order.**
   - `adf/CLAUDE.md` — method and invariants.
   - `adf-adapter/ADAPTER.md` — stack, gate commands, budgets, security, tokens.
   - `adf-memory/project.md` — current state (works / in-flight / broken).

2. **State the active loop.**
   - Open the newest non-template file in `adf-memory/loops/`.
   - Read its Goal, Not-doing, and where Validate stands.
   - If there is no active loop, pick the recommended next loop from `adf-memory/roadmap.md` and
     start one from `core/memory/loops/0000-template.md`.

3. **Run the relevant workflow** (`core/workflows/`): feature / bug / refactor / release /
   research. Delegate to the agents it names, in order.

4. **Close on green.** The loop closes only when the adapter's objective gates pass, with real
   output in Validate. Update memory, then make one focused conventional commit. The AI Score is
   advisory — never the exit condition.
