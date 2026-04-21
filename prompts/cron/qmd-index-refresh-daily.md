---
name: qmd-index-refresh-daily
schedule: "30 3 * * *"
agent: main
model: {{CRON_MODEL}}
enabled: true
description: Daily QMD index refresh (update + embed) to keep vault and workspace search fresh
delivery_mode: webhook
---

# qmd-index-refresh-daily

Refresh the QMD index every day.

Step 1: Run index update
```bash
{{QMD_BIN}} update
```

Step 2: Run embedding to process pending files
```bash
{{QMD_BIN}} embed
```

Step 3: Check status
```bash
{{QMD_BIN}} status
```

Extract from the status output:
- total files
- total embeddings
- pending files
- last updated time

Step 4: If pending > 0, run `embed` one more time.

---

## ⚠️ Webhook output contract

Your final reply must be a short 2-4 line plain-text summary in this format:

✅ QMD Index Refresh YYYY-MM-DD | Files X | Embeddings Y | Pending Z

Do not output JSON, code blocks, markdown tables, or full logs.
