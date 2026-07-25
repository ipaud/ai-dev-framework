#!/usr/bin/env bash
# ADF Stop hook: loop-close checklist + clean-state check + conventional-commit reminder.
# Clean, mergeable state is part of the exit gate (roadmap M3) — checked here for real, not just
# printed as a checklist item, since git status is cheap and this hook already runs at Stop.
set -euo pipefail

ROOT="$(git rev-parse --show-toplevel 2>/dev/null || pwd)"

echo "Loop close checklist:"
echo "  [ ] project.md updated (works / in-flight / broken)?"
echo "  [ ] ADR written if a boundary or pattern was decided?"
echo "  [ ] lesson recorded in lessons.md if something was learned?"
echo "  [ ] objective gates green, with real output pasted in the loop's Validate?"
echo "  [ ] AI Score line added (optional, advisory only)?"

if git -C "$ROOT" rev-parse --git-dir >/dev/null 2>&1; then
  dirty="$(git -C "$ROOT" status --porcelain 2>/dev/null | wc -l | tr -d ' ')"
  if [ "$dirty" -eq 0 ]; then
    echo "Clean-state gate: PASS — working tree clean."
  else
    echo "Clean-state gate: WARN — $dirty uncommitted change(s). Commit or stash before closing the loop."
  fi
else
  echo "Clean-state gate: SKIP — not a git repo."
fi

echo "Commit: one focused conventional commit, e.g. 'feat: <what>' / 'fix: <what>'."
