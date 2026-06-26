---
name: release
description: Bump the version, build the changelog from conventional commits, tag, and write release notes. Use when cutting a release. Refuses to release unless the feature-tier definition of done has passed.
---

# release

## Purpose
Cut a release that is honest about what changed and only ships on green.

## Trigger
A release is requested and the work is believed done.

## Procedure
1. **Gate first** — verify the feature-tier definition of done: all adapter gates green. **If any
   gate is red, refuse and stop.** Do not release on red.
2. **Version** — bump `VERSION` per semver (pre-1.0 rules while major is 0).
3. **Changelog** — derive entries from conventional commits since the last tag; group by type
   (feat/fix/…); edit for readability under `CHANGELOG.md`.
4. **Notes** — short human release notes: highlights, breaking changes, migration if any.
5. **Tag** — annotated tag at the release commit.

## Output
Updated `VERSION` and `CHANGELOG.md`, release notes, and an annotated tag — only when gates are
green.

## Anti-patterns
- Releasing with a red or unrun gate.
- A changelog that doesn't match the commits.
- Skipping the version bump or tagging the wrong commit.
