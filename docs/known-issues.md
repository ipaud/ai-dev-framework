# Known issues

Logged, not fixed. These are accepted limitations of ADF v0.1.0; revisit as the framework is
used.

## Memory grows append-only
`decisions.md`, `lessons.md`, and the loop log are append-only by design. Over a long project they
grow without bound. **Deferred:** a future compaction pass (archive old loops, summarize stale
lessons). No action now — readability is fine at current scale.

_Partly addressed in v1.1:_ `PreCompact`/`SessionEnd` hooks (ADR-0008) keep active state durable
across context compaction and session boundaries, so compaction no longer silently loses the
active loop. The append-only *disk* growth is still unbounded — that archival pass remains deferred.

## Active-loop detection is mtime-based
`session-start.sh` and `pre-edit.sh` pick the active loop as the newest non-template file in
`adf-memory/loops/` by modification time (`ls -t`). Touching an old loop file, or a checkout that
rewrites mtimes, can misidentify the active loop. **Accepted:** mtime is good enough and needs no
state file; the agent can always open the intended loop explicitly.

## Copy-mode wiring goes stale
On filesystems without symlink support (e.g. exFAT), `adf-init.sh` copies skills and agents into
`.claude/` instead of symlinking. Copies do not track the core. **After a core submodule update,
re-run `adf-init.sh`** to refresh them. `adf-doctor.sh` cannot detect staleness — it only checks
that links resolve.

## shellcheck not run in this build
`shellcheck` was unavailable in the build environment, so shell scripts were validated with
`bash -n` (syntax) and a live init+doctor dry-run instead. **Action for contributors:** run
`shellcheck core/hooks/*.sh scripts/*.sh` when available and fix any findings.
