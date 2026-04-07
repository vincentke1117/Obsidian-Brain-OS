# Nightly Pipeline — How AI Processes Your Knowledge While You Sleep

---

## Overview

The nightly pipeline runs automatically via OpenClaw cron jobs. Three stages process your knowledge between 02:00 and 04:00, producing a curated digest you can read each morning.

**Key principle:** Each stage is isolated. If one fails, others still run. No stage depends on another's success.

---

## Stage 1: Article Integration (02:00)

**What it does:** Takes raw article notes from `02-WORKING/01-ARTICLE-NOTES/` and integrates them into the knowledge base.

**Input:**
- New/pending article notes (status: `pending`)
- Existing domain knowledge cards (for context)

**Output:**
- Updated domain knowledge cards in `01-READING/01-DOMAINS/`
- New or updated topic pages in `01-READING/02-TOPICS/`
- Pattern candidates in `02-WORKING/02-PATTERN-CANDIDATES/` (if patterns detected)
- Digest section: `## 02:00 Article Integration`
- Run report: `99-SYSTEM/03-INTEGRATION-REPORTS/run-reports/YYYY-MM-DD/article-integration-report-YYYY-MM-DD.md`

**Behavior:**
- If no new articles: writes "no-op" report and brief digest note
- Updates article note status from `pending` to `integrated`
- Only updates domain cards when justified (not forced)

---

## Stage 2: Conversation Mining (03:00)

**What it does:** Exports recent AI conversations and mines them for insights, decisions, and knowledge.

**Input:**
- AI conversation transcripts (exported by `scripts/export-conversations.sh`)
- Today's digest (to see what Stage 1 already did)

**Output:**
- 1-3 knowledge note drafts (if justified)
- Pattern candidates or research seeds
- Digest section: `## 03:00 Conversation Mining`
- Run report: `99-SYSTEM/03-INTEGRATION-REPORTS/run-reports/YYYY-MM-DD/conversation-mining-report-YYYY-MM-DD.md`

**Behavior:**
- Requires `convs` CLI for conversation export (gracefully skips if unavailable)
- Uses QMD (query-memory-docs) for semantic search when available
- Enters degraded mode if transcripts are missing
- Never dumps raw transcripts into Brain

---

## Stage 3: Knowledge Amplification (04:00)

**What it does:** Reads the full nightly digest, finds connections between knowledge entries, and generates recommendations.

**Input:**
- Today's complete nightly digest (Stages 1 & 2 output)
- Domain knowledge cards
- Topic pages

**Output:**
- Cross-references and connections added to existing notes
- "Today's recommended reading" section in digest
- Digest section: `## 04:00 Knowledge Amplification`
- Run report: `99-SYSTEM/03-INTEGRATION-REPORTS/run-reports/YYYY-MM-DD/knowledge-amplifier-report-YYYY-MM-DD.md`

**Behavior:**
- Synthesizes across all stages — this is the "big picture" stage
- Recommends what's worth reading today
- Suggests potential research directions
- Never forces connections that don't exist

---

## Supporting Jobs

### Knowledge Lint (Monday 01:00)

Runs `scripts/knowledge-lint.sh` to check knowledge base health:
- Missing frontmatter fields
- Broken links
- Orphaned pages
- Stale entries (active but not updated in 30+ days)
- Tag consistency

Output: `12-REVIEWS/KNOWLEDGEBASE/lint-YYYY-MM-DD.md`

### Daily Knowledge Canvas (05:00)

Optional job that generates a knowledge graph visualization using `scripts/daily-knowledge-canvas.sh`.

### Morning Brief (07:00)

Generates the daily personal ops cockpit in `01-PERSONAL-OPS/01-DAILY-BRIEFS/daily-briefing.md`.

---

## How to Read the Digest

Open `03-KNOWLEDGE/01-READING/04-DIGESTS/nightly-digest-YYYY-MM-DD.md` each morning.

```
🌙 Nightly Digest — 2026-04-07

## 02:00 Article Integration
  Processed 3 articles. New topic: "AI Agent Architectures".
  Worth reading: the OpenAI function calling patterns card.

## 03:00 Conversation Mining
  Found 2 actionable insights from yesterday's coding sessions.
  Key takeaway: retry pattern for API rate limits.

## 04:00 Knowledge Amplification
  Connected: "function calling" ↔ "tool use patterns" ↔ "agent reliability".
  Recommended reading: function-calling-patterns.md

## Today's Recommended Reading
  1. function-calling-patterns.md (new, high relevance)
  2. ai-agent-architectures.md (updated with new connections)
```

**Start here.** If something interests you, drill down into the linked notes.

---

## Customizing the Pipeline

### Changing the Schedule

Edit the cron config files in `cron-examples/`:

```json
{
  "schedule": {
    "kind": "cron",
    "expr": "0 2 * * *",    // Change to your preferred time
    "tz": "America/New_York" // Change to your timezone
  }
}
```

### Disabling a Stage

Set `"enabled": false` in the cron job config.

### Adding a Custom Stage

1. Create a new prompt in `prompts/`
2. Create a cron job entry referencing it
3. Follow the handoff protocol: read existing digest → fill your section → commit

---

## Troubleshooting

| Problem | Solution |
|---------|----------|
| Digest not generated | Check cron is running (`openclaw gateway status`) |
| "no-op" every night | No new articles or conversations — that's fine |
| Conversation mining fails | Install `convs` CLI or set `CONVS_BIN` in config |
| Knowledge lint errors | Check `BRAIN_PATH` points to vault root |
| Pipeline overwrites my edits | Pipeline only touches `99-SYSTEM/` and `04-DIGESTS/` — your edits in `01-READING/` are safe unless you enable auto-update |
