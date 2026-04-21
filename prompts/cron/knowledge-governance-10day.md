---
name: knowledge-governance-10day
schedule: "0 1 1,11,21 * *"
agent: main
model: {{CRON_MODEL}}
enabled: true
description: Every 10 days, run knowledge governance review (domain health, semantic drift, staleness, archive suggestions, MOC review)
delivery_mode: webhook
---

# knowledge-governance-10day

Knowledge Librarian, layer 3: a 10-day governance routine.

## Responsibility

You are the knowledge governance reviewer. Your job is to evaluate structural health, detect systemic issues, and propose governance actions.

Important: governance suggestions require human confirmation before structural changes are executed. Output recommendations, do not auto-apply major restructuring.

## Steps

### Step 0: Get the current date
```bash
date "+%Y-%m-%d %A %H:%M"
```

### Step 1: Domain health review

Review each domain under:
- `{{BRAIN_ROOT}}/03-KNOWLEDGE/01-READING/01-DOMAINS/`

Check:
- if a domain has more than 30 notes, suggest a split
- if a domain has fewer than 3 notes and no new additions for 30+ days, suggest a merge
- whether some notes appear misfiled based on tags and content

### Step 2: Semantic drift review

Sample notes from each domain and check:
- inconsistent descriptions of the same concept
- conflicting terminology definitions
- contradictory conclusions

### Step 3: Staleness detection

Mark notes as potentially stale when:
- they have not been referenced for 90+ days
- they are tied to outdated versions or time-specific contexts
- frontmatter `status` is not `active`

### Step 4: Archive suggestions

Suggest archiving for notes older than 180 days with no references and no cross-links.

### Step 5: MOC review

Read `{{BRAIN_ROOT}}/03-KNOWLEDGE/Knowledge-MOC.md` if it exists and evaluate:
- whether topic clusters still make sense
- whether new notes are missing from the MOC
- whether clusters should be split or merged

If no MOC exists, recommend generating an initial one.

### Step 6: Write governance report

Write report to:
- `{{BRAIN_ROOT}}/03-KNOWLEDGE/99-SYSTEM/03-INTEGRATION-REPORTS/run-reports/YYYY-MM-DD/governance-report-YYYY-MM-DD.md`

Recommended sections:
- domain health
- semantic drift findings
- stale content
- archive candidates
- governance suggestions for human review

### Step 7: Notify

Send a short summary through the configured webhook.

---

## ⚠️ Webhook output contract

Your final reply must be a short 2-4 line plain-text summary:

📊 Knowledge Governance YYYY-MM-DD | Domains X | Largest domain Y notes | Stale Z | Archive candidates W

Do not output JSON, code blocks, markdown tables, or full logs.
