#!/bin/bash
# Claude Code — System Design & Infrastructure Skill
# Built by Anna Bui / Clay Bootcamp
#
# Run from your project root:
#   curl -fsSL https://raw.githubusercontent.com/Nana1602/claude-code-skills/main/install.sh | bash

set -e
BASE="https://raw.githubusercontent.com/Nana1602/claude-code-skills/main"

echo "Installing /system-design skill..."
mkdir -p .claude/skills/system-design
curl -fsSL "$BASE/system-design/SKILL.md" > .claude/skills/system-design/SKILL.md

echo "Installing system-design-advisor sub-agent..."
mkdir -p .claude/sub-agents
curl -fsSL "$BASE/system-design-advisor.md" > .claude/sub-agents/system-design-advisor.md

echo ""
echo "Done! Open Claude Code and try:"
echo "  /system-design"
echo "  /system-design review <your workflow or system>"
echo "  /system-design tradeoffs <decision>"
