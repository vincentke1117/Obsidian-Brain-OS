# Cron Configuration Examples

This directory contains anonymized OpenClaw cron job templates for the Obsidian-Brain-OS system.

## Files

### `nightly-pipeline.json`

Automated knowledge processing pipeline that runs on a nightly schedule:

| Job | Schedule | Purpose |
|-----|----------|---------|
| `knowledge-lint-weekly` | Mon 01:00 Asia/Shanghai | Knowledge base content lint |
| `article-notes-integration-nightly` | 02:00 daily | Article ingestion and integration |
| `conversation-knowledge-mining-nightly` | 03:00 daily | Conversation transcript mining |
| `knowledge-flywheel-amplifier-nightly` | 04:00 daily | Knowledge synthesis and amplification |
| `daily-knowledge-graph-canvas-0500` | 05:00 daily | Auto-generate knowledge graph canvas |

**Pipeline order**: lint → article → conversation → amplifier → canvas. Each stage reads the output of the previous stage when available.

### `personal-ops.json`

Personal operations automation jobs:

| Job | Schedule | Purpose |
|-----|----------|---------|
| `personal-ops-morning-brief` | 07:00 daily | Generate daily driving cockpit |
| `personal-ops-weekly-plan` | Mon 05:10 | Generate weekly plan |
| `personal-ops-monthly-milestones` | Day 1, 06:20 | Generate monthly milestones |
| `personal-ops-todo-reminder-1500` | 15:00 daily | Afternoon todo follow-up |
| `personal-ops-todo-reminder-2000` | 20:00 daily | Evening todo follow-up |
| `knowledgebase-commit-patrol-30m` | Every 30 min | Auto-commit pending Brain changes |

## Placeholders to Replace

Before importing, search and replace all placeholders:

| Placeholder | Description |
|-------------|-------------|
| `{{USER_HOME}}` | Your home directory path |
| `{{BRAIN_PATH}}` | Obsidian vault path |
| `{{WORKSPACE_PATH}}` | OpenClaw workspace path |
| `{{SKILLS_PATH}}` | Skills directory path |
| `{{PROJECTS_PATH}}` | Projects directory path |
| `{{USER_NAME}}` | Your name (e.g. 李主席) |
| `{{USER_DISPLAY_NAME}}` | Your Discord display name |
| `{{USER_HANDLE}}` | Your Discord handle (lowercase) |
| `{{DISCORD_USER_ID}}` | Your Discord user ID |
| `{{DISCORD_CHANNEL_ID}}` | Target Discord channel ID |
| `{{GUILD_ID}}` | Discord guild/server ID |
| `{{DISCORD_WEBHOOK_URL}}` | Discord webhook URL |
| `{{AGENT_ID}}` | OpenClaw agent identifier |

## Importing to OpenClaw

### Option 1: Import command

```bash
openclaw cron import cron-examples/nightly-pipeline.json
openclaw cron import cron-examples/personal-ops.json
```

### Option 2: Manual merge

Copy the `jobs` array from each file into `~/.openclaw/cron/jobs.json`, merging with existing jobs. Make sure to resolve duplicate `name` fields.

### Option 3: Direct API

```bash
# Edit directly
openclaw cron edit
```

## Schedule Order Notes

- `knowledge-lint-weekly` runs Monday 01:00 — before the main nightly pipeline
- `article-notes-integration-nightly` at 02:00 starts the pipeline
- `conversation-knowledge-mining-nightly` at 03:00 reads article integration output
- `knowledge-flywheel-amplifier-nightly` at 04:00 synthesizes all prior outputs
- `daily-knowledge-graph-canvas-0500` at 05:00 generates the knowledge graph
- `personal-ops-morning-brief` at 07:00 reads from Brain driving cockpit files

## Notes

- All jobs use `sessionTarget: isolated` for clean execution environment
- Most jobs deliver via `webhook` mode with `bestEffort: true`
- Adjust `model` and `timeoutSeconds` based on your infrastructure
- The `knowledge-lint-weekly` and `knowledgebase-commit-patrol` jobs ensure the Brain stays clean and synchronized to Obsidian
