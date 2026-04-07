# FAQ — Frequently Asked Questions

---

## General

### What is Obsidian Brain OS?

An AI-augmented personal context system built on Obsidian. It combines a structured knowledge vault, automated nightly processing pipeline, and AI-powered personal ops management into one coherent system.

### Do I need to use OpenClaw?

For the **full experience** (nightly pipeline, automated briefings): yes, OpenClaw handles scheduling.

For **knowledge management only**: no. The vault structure, templates, and skills work with any AI assistant. You just won't have automated cron jobs.

### Do I need to use Agora?

No. Agora is recommended for task management but not required. The project registry in Brain OS works standalone. See [Project Management](project-management.md) for alternatives.

### Can I use this with Claude, GPT, or other AI assistants?

Yes. The skills and prompts are written in a format compatible with most AI assistants. OpenClaw provides the scheduling layer, but the knowledge structure and methodology work anywhere.

---

## Setup

### Can I use my existing Obsidian vault?

Yes, but it's recommended to start fresh with the Brain OS template. You can gradually migrate content from your old vault.

To adopt the structure in an existing vault:
1. Copy the directory structure from `vault-template/`
2. Move your existing notes into the appropriate directories
3. Install the skills and configure cron jobs

### What if I don't want to use all the features?

Brain OS supports **modular installation**. See [Getting Started](getting-started.md) for three profiles:
- **Knowledge Only** — vault structure + article processing
- **Personal Ops Only** — todo management + daily briefings
- **Full System** — everything

### How do I change the timezone?

1. Edit `scripts/config.env` → `TIMEZONE="Your/Timezone"`
2. Edit cron job configs → `schedule.tz`
3. Replace `CST` in skill files

---

## Nightly Pipeline

### The pipeline keeps saying "no-op" — is something broken?

No. "No-op" means there were no new articles or conversations to process. This is normal on quiet days. The pipeline still writes a report confirming it checked.

### Can I change the pipeline schedule?

Yes. Edit the cron schedule in `cron-examples/`:
```json
{
  "schedule": {
    "expr": "0 2 * * *",
    "tz": "America/New_York"
  }
}
```

### What if a stage fails?

Other stages continue independently. Check the run report in `99-SYSTEM/03-INTEGRATION-REPORTS/` for the specific error. Common fixes:
- Missing transcripts → install `convs` CLI
- Missing scripts → check `scripts/` directory exists
- Permission errors → `chmod +x scripts/*.sh`

### Can I add my own pipeline stages?

Yes. Create a new prompt in `prompts/`, add a cron job referencing it, and follow the handoff protocol: read existing digest → fill your section → commit.

---

## Knowledge Base

### How do I add an article?

Create a new file in `03-KNOWLEDGE/02-WORKING/01-ARTICLE-NOTES/` using the article-note template. The nightly pipeline will process it automatically.

### How do I find things?

1. **Start from digests** (`04-DIGESTS/`) — AI tells you what's new
2. **Search in Obsidian** — built-in search + backlinks
3. **Dataview queries** — for structured queries across vault
4. **QMD** (optional) — semantic search for large vaults

### How do I prevent the knowledge base from growing too large?

- Run `knowledge-lint.sh` weekly to catch issues
- Archive stale notes (change status to `archived`)
- Review `02-WORKING/` periodically — delete truly irrelevant drafts
- Let the pipeline handle curation — it won't force updates

---

## Personal Ops

### Can AI delete my todos?

No. AI can only reorder, consolidate, and downgrade items. Only you can mark items as complete or archive them.

### How do I add a new todo?

Append to `00-INBOX/todo-backlog.md`. AI will pick it up in the next morning brief.

### The morning brief doesn't match my priorities — how do I fix it?

1. Check that your items in `todo-backlog.md` have correct priority levels
2. Verify the `截止` (deadline) field is set for urgent items
3. Edit the briefing directly — your manual edits take precedence until the next auto-generation

---

## Skills

### How do I create a custom skill?

See [Skills Guide](skills-guide.md). Create a directory with a `SKILL.md` file following the frontmatter format.

### Can I use skills from other sources?

Yes. Just copy them into your skills directory. Brain OS skills are compatible with OpenClaw's skill system.

### How do I disable a skill?

Rename `SKILL.md` to `SKILL.md.disabled` or move the directory out of the skills path.

---

## Troubleshooting

| Problem | Solution |
|---------|----------|
| Obsidian won't open vault | Check path is a directory, not a file |
| Scripts fail with permission error | `chmod +x scripts/*.sh` |
| Cron jobs not running | `openclaw gateway status` — is it running? |
| Knowledge lint finds nothing | Check `BRAIN_PATH` in config |
| Digest not generated | Check cron job logs in `~/.openclaw/cron/runs/` |
| Placeholder not replaced | Search for `{{` in your config files |
| Git commit fails | Check `git status`, resolve conflicts |
