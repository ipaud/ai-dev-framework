# Workflow: release

Cut a release. Ships only on green.

## Agents in order
1. **adf-documenter** (release skill) — verify the full feature-tier definition of done is green;
   bump `VERSION`; build the changelog from conventional commits; write release notes.
2. **Verify DoD** — all adapter gates green. **Refuse and stop on any red.**
3. **Tag** — annotated tag at the release commit.

## Exit gate
All gates green, `VERSION` and `CHANGELOG.md` updated, release notes written, annotated tag
created. A red gate aborts the release.
