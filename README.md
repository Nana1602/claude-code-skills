# Claude Code Skills — by Anna Bui

Skills and sub-agents built for Clay Bootcamp students.

## Install (run from your project root)

```bash
curl -fsSL https://raw.githubusercontent.com/Nana1602/claude-code-skills/main/install.sh | bash
```

## What's included

### `/system-design` Skill
A Claude Code advisor for system architecture and infrastructure design.

**Commands:**
- `/system-design` — overview and capabilities
- `/system-design review <thing>` — architecture review with scored report
- `/system-design tradeoffs <decision>` — compare approaches (A vs B vs C)
- `/system-design pattern <problem>` — recommend the right design pattern
- `/system-design diagram <system>` — Mermaid architecture diagram

### `system-design-advisor` Sub-Agent
Deep technical review sub-agent. Scores your system across Reliability, Scalability, Maintainability, Security, and Cost Efficiency. Produces a full written report with prioritised recommendations.

---

Built for [Clay Bootcamp](https://claybootcamp.com)
