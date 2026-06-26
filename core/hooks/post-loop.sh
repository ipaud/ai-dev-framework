#!/usr/bin/env bash
# ADF Stop hook: loop-close checklist + conventional-commit reminder.
set -euo pipefail

echo "Loop close checklist:"
echo "  [ ] project.md updated (works / in-flight / broken)?"
echo "  [ ] ADR written if a boundary or pattern was decided?"
echo "  [ ] lesson recorded in lessons.md if something was learned?"
echo "  [ ] objective gates green, with real output pasted in the loop's Validate?"
echo "  [ ] AI Score line added (optional, advisory only)?"
echo "Commit: one focused conventional commit, e.g. 'feat: <what>' / 'fix: <what>'."
