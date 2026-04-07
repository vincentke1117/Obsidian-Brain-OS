# Skills Guide — Understanding and Customizing Brain OS Skills

---

## What Are Skills?

Skills are specialized instruction sets that tell AI agents how to perform specific tasks. In Brain OS, skills power the nightly pipeline, personal ops, and knowledge management.

Each skill is a directory containing at least a `SKILL.md` file with:
- **Description**: When this skill should be activated
- **Instructions**: Step-by-step procedures
- **Templates**: Output formats and file locations
- **Guardrails**: What the skill should NOT do

---

## Core Skills

### 1. `article-notes-integration`

**What it does:** Processes raw article notes and integrates them into the knowledge base.

**When it runs:** 02:00 daily (via cron)

**Key behaviors:**
- Reads `02-WORKING/01-ARTICLE-NOTES/` for new/pending articles
- Extracts key concepts and writes domain knowledge cards
- Updates topic pages when justified
- Writes to the shared nightly digest
- Never forces updates when there's no signal

**Files it reads:**
- `02-WORKING/01-ARTICLE-NOTES/*.md` (status: pending)
- `01-READING/01-DOMAINS/*.md` (existing knowledge for context)

**Files it writes:**
- `01-READING/01-DOMAINS/*.md` (new/updated knowledge cards)
- `01-READING/02-TOPICS/*.md` (topic page updates)
- `01-READING/04-DIGESTS/nightly-digest-YYYY-MM-DD.md`
- `99-SYSTEM/03-INTEGRATION-REPORTS/run-reports/YYYY-MM-DD/article-integration-report-YYYY-MM-DD.md`

### 2. `conversation-knowledge-flywheel`

**What it does:** Mines AI conversation transcripts for actionable insights.

**When it runs:** 03:00 daily (via cron)

**Key behaviors:**
- Exports recent conversations via `scripts/export-conversations.sh`
- Uses semantic search (QMD) to find relevant past knowledge
- Generates 1-3 knowledge note drafts when justified
- Never dumps raw transcripts into Brain

### 3. `knowledge-flywheel-amplifier`

**What it does:** Cross-references knowledge entries and finds connections.

**When it runs:** 04:00 daily (via cron)

**Key behaviors:**
- Reads the full nightly digest (Stages 1 & 2 output)
- Adds cross-references between related notes
- Generates "Today's recommended reading"
- This is the "big picture" synthesis stage

### 4. `personal-ops-driver`

**What it does:** Manages the personal ops system — todos, briefings, plans.

**When it runs:** 07:00 daily (morning brief) + ad-hoc

**Key behaviors:**
- Generates daily briefing from todo-backlog + commitments + decisions
- Never deletes user items (only reorders, consolidates, downgrades)
- Commits changes to Brain git repo

### 5. `deep-research`

**What it does:** Conducts deep research on topics, producing comprehensive reports.

**When it runs:** On demand (user-triggered)

**Key behaviors:**
- Takes a research question as input
- Searches web, reads sources, synthesizes findings
- Produces structured research notes
- Integrates findings into Brain when appropriate

### 6. `notebooklm`

**What it does:** Integrates with Google's NotebookLM for deep research.

**When it runs:** On demand (user-triggered)

---

## Recommended General Skills

These skills enhance the core system but aren't required:

| Skill | Purpose | Use When |
|-------|---------|----------|
| `planning-with-files` | Persistent planning with markdown files | Starting complex projects |
| `brainstorming` | Creative exploration before building | Designing features or solutions |
| `writing-plans` | Structured execution plans | After brainstorming, before building |
| `writing-skills` | Creating new skills | When you want to extend Brain OS |
| `humanizer` | Make AI text sound more natural | Polishing AI-generated content |
| `polish` | Final quality pass | Before publishing or sharing |
| `critique` | Design review | Reviewing architecture or decisions |
| `extract` | Extract reusable components | Finding patterns in existing work |
| `distill` | Simplify complex designs | Reducing complexity |
| `normalize` | Ensure design consistency | Maintaining standards |
| `clarify` | Improve UX copy and labels | Making interfaces clearer |
| `arrange` | Improve layout and spacing | Visual design improvements |
| `optimize` | Performance optimization | Speed and efficiency |
| `teach-impeccable` | Gather context for AI | Preparing comprehensive briefs |
| `skill-creator` | Create new skills from scratch | Extending the system |
| `skillshare` | Share skills across agents | Team collaboration |

---

## Customizing Skills

### Adding a New Skill

1. Create a directory: `skills/my-skill/`
2. Write `SKILL.md` with frontmatter:

```yaml
---
name: my-skill
description: When to activate this skill
---
```

3. Add instructions, templates, and guardrails
4. Copy to `~/.agents/skills/my-skill/` (or your skills directory)

### Modifying Existing Skills

Edit the `SKILL.md` directly. Changes take effect on the next AI session that activates the skill.

**Important:** Keep the frontmatter format. OpenClaw uses `name` and `description` to match skills to user requests.

### Disabling a Skill

Rename `SKILL.md` to `SKILL.md.disabled` or move the skill directory out of the skills path.

---

## Skill File Structure

```
skills/my-skill/
├─ SKILL.md              # Main skill definition (required)
├─ references/           # Supporting files (optional)
│   ├─ guide.md
│   └─ examples.md
├─ scripts/              # Helper scripts (optional)
│   └─ preflight.sh
└─ templates/            # Output templates (optional)
    └─ output-template.md
```

---

## Writing Good Skill Instructions

### Do
- Be specific about file paths (use `/tmp/brain-os-test/vault` for portability)
- Include guardrails (what NOT to do)
- Define clear output formats
- Specify commit requirements
- Include error handling instructions

### Don't
- Write vague instructions ("be helpful")
- Skip the guardrails section
- Hardcode personal information
- Assume the AI has context from previous sessions
