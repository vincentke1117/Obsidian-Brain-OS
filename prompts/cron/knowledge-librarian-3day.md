---
name: knowledge-librarian-3day
schedule: "0 2 */3 * *"
agent: main
model: {{CRON_MODEL}}
enabled: true
description: Every 3 days, run knowledge maintenance (frontmatter fixes, link audit, tag normalization, duplicate detection, digest consolidation)
delivery_mode: webhook
---

# knowledge-librarian-3day

Knowledge Librarian, layer 2: a 3-day maintenance routine.

## Responsibility

You are the knowledge librarian. Your job is not to ingest new articles, but to repair and organize the existing knowledge base.

## Steps

### Step 0: Get the current date
```bash
date "+%Y-%m-%d %A %H:%M"
```

### Step 1: Frontmatter auto-fix

Scan all `.md` files under:
- `{{BRAIN_ROOT}}/03-KNOWLEDGE/01-READING/01-DOMAINS/`

Auto-fix without human confirmation:
- unquoted `source_url` values → add quotes
- missing `status` → add `status: active`
- missing `created` → derive from filename when possible
- inconsistent tag case → normalize to kebab-case

Record but do not auto-fix:
- missing `source` or `source_type`
- suspected duplicates

### Step 2: Link audit

Scan wiki-links (`[[...]]`):
- broken target detection
- asymmetric backlinks
- orphan page detection

### Step 3: Tag normalization

Count tag frequency:
- single-use tags → inspect for typos or over-fragmentation
- merge obvious variants
- output top tags plus isolated tags

### Step 4: Duplicate detection

Check for likely duplicate notes by:
- `source_url`
- filename similarity

### Step 5: Digest consolidation

Check digest files older than 14 days under:
- `{{BRAIN_ROOT}}/03-KNOWLEDGE/01-READING/04-DIGESTS/`

For each month:
- extract key findings and notable insights
- write `monthly-digest-YYYY-MM.md`
- move original daily digests into archive
- skip a month if the monthly digest already exists

### Step 6: Write report + commit

Write report to:
- `{{BRAIN_ROOT}}/03-KNOWLEDGE/99-SYSTEM/03-INTEGRATION-REPORTS/run-reports/YYYY-MM-DD/librarian-report-YYYY-MM-DD.md`

Suggested commit message:
```bash
git commit -m "auto(librarian): 3-day maintenance YYYY-MM-DD"
```

### Step 7: Notify

Send a short 2-3 line summary through the configured webhook.

---

## ⚠️ Webhook output contract

Your final reply must be a short 2-4 line plain-text summary:

✅ Knowledge Maintenance YYYY-MM-DD | Auto-fixed X | Needs review Y | Broken links Z | Digests consolidated W

Do not output JSON, code blocks, markdown tables, or full logs.
