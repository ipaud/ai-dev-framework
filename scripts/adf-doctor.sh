#!/usr/bin/env bash
# adf-doctor.sh — verify an ADF install in a consuming project.
# One pass/fail line per check; non-zero exit on any real failure (warnings don't fail).
set -uo pipefail

ADF="$(cd "$(dirname "$0")/.." && pwd)"
ROOT="$(dirname "$ADF")"
CLAUDE_DIR="$ROOT/.claude"

EXPECT_SKILLS=17
EXPECT_AGENTS=11

fails=0
warns=0
ok()   { echo "PASS: $1"; }
bad()  { echo "FAIL: $1"; fails=$((fails + 1)); }
warn() { echo "WARN: $1"; warns=$((warns + 1)); }

# 1. Core tree present with the expected counts.
core_skills=$(find "$ADF/core/skills" -mindepth 1 -maxdepth 1 -type d 2>/dev/null | wc -l | tr -d ' ')
core_agents=$(find "$ADF/core/agents" -mindepth 1 -maxdepth 1 -name '*.md' 2>/dev/null | wc -l | tr -d ' ')
[ "$core_skills" -eq "$EXPECT_SKILLS" ] && ok "core has $EXPECT_SKILLS skills" || bad "core skills: $core_skills (want $EXPECT_SKILLS)"
[ "$core_agents" -eq "$EXPECT_AGENTS" ] && ok "core has $EXPECT_AGENTS agents" || bad "core agents: $core_agents (want $EXPECT_AGENTS)"

# 2. Skills wired into .claude/ (symlink OR copy — test the resolved file).
wired=0
for dir in "$ADF"/core/skills/*/; do
  name="$(basename "$dir")"
  [ -e "$CLAUDE_DIR/skills/$name/SKILL.md" ] && wired=$((wired + 1)) || bad "skill not wired: $name"
done
[ "$wired" -eq "$EXPECT_SKILLS" ] && ok "$EXPECT_SKILLS skills wired in .claude/" || bad "skills wired: $wired (want $EXPECT_SKILLS)"

# 3. Agents wired into .claude/ (symlink OR copy).
wired=0
for file in "$ADF"/core/agents/*.md; do
  name="$(basename "$file")"
  [ -e "$CLAUDE_DIR/agents/$name" ] && wired=$((wired + 1)) || bad "agent not wired: $name"
done
[ "$wired" -eq "$EXPECT_AGENTS" ] && ok "$EXPECT_AGENTS agents wired in .claude/" || bad "agents wired: $wired (want $EXPECT_AGENTS)"

# 4. Hooks executable (settings points at the core copies by absolute path).
for h in session-start pre-edit post-loop; do
  [ -x "$ADF/core/hooks/$h.sh" ] && ok "hook executable: $h.sh" || bad "hook not executable: $h.sh"
done

# 5. Settings reference the hooks. Missing settings = fail; present-but-unmerged = warning (F).
settings="$CLAUDE_DIR/settings.json"
if [ -f "$settings" ]; then
  if grep -q "core/hooks/session-start.sh" "$settings" \
     && grep -q "core/hooks/pre-edit.sh" "$settings" \
     && grep -q "core/hooks/post-loop.sh" "$settings"; then
    ok "settings.json references the three hooks"
  else
    warn "settings.json exists but does not reference the hooks — merge the block printed by adf-init.sh"
  fi
else
  bad "no .claude/settings.json — run adf-init.sh"
fi

# 6. Project-local state seeded.
[ -f "$ROOT/adf-memory/project.md" ] && ok "adf-memory seeded" || bad "adf-memory/project.md missing — run adf-init.sh"
[ -f "$ROOT/adf-adapter/ADAPTER.md" ] && ok "adf-adapter seeded" || bad "adf-adapter/ADAPTER.md missing — run adf-init.sh"

echo "----"
echo "doctor: $fails failure(s), $warns warning(s)."
[ "$fails" -eq 0 ] || exit 1
