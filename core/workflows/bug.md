# Workflow: bug

For a reported bug or failing behavior.

## Agents in order
1. **adf-debugger** — reproduce → isolate → root cause → minimal fix.
2. **adf-tester** — regression test that fails before the fix and passes after.
3. **adf-documenter** — record the lesson in `lessons.md` and add a release note if user-facing.

## Exit gate
The adapter's test gate green with the new regression test, real output in the loop's Validate,
and a `lessons.md` entry for the root cause.
