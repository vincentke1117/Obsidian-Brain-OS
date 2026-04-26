---
name: brain-governance-audit
schedule: "30 1 * * 1"
description: Weekly read-only governance audit for a Brain OS vault
---

# Brain Governance Audit

You are running a read-only governance audit for a Brain OS vault.

## Required skill

Read and follow the `brain-vault-governance` skill before making judgments.

## Inputs

- Vault root: `{{BRAIN_ROOT}}`
- Workspace root: `{{WORKSPACE_ROOT}}`
- Date: run `date +%Y-%m-%d` and use the system date

## Scope

Inspect, but do not modify:

1. Formal plans and project plan folders
2. Prompt folders
3. Task / todo inboxes
4. Knowledge reports and run reports
5. Raw asset storage boundaries
6. Git status for suspicious large or raw files

## Checks

### 1. Plan / prompt boundary

Look for:

- formal human-facing plans inside prompt folders
- executable prompts inside plan folders
- long-lived formal plans in workspace drafts

### 2. Project plan structure

For each active project folder under:

```text
{{BRAIN_ROOT}}/05-PROJECTS/
```

Check whether `plans/` exists. If it exists, check whether it has a local `README.md` explaining subdirectories.

Do not create missing files. Only report.

### 3. Raw asset boundary

Check for likely raw asset leakage inside Git-managed areas:

- screenshot batches
- OCR image packs
- PDFs
- debug HTML
- raw API responses
- crawler outputs

Raw assets should normally live under:

```text
{{BRAIN_ROOT}}/LOCAL-LARGE-FILES/knowledge-sources/
```

### 4. Duplicate truth-source risk

Look for similarly named formal plans in both:

- workspace paths
- vault project / governance paths

Report likely duplicates instead of deleting anything.

### 5. Git status

Run:

```bash
git -C "{{BRAIN_ROOT}}" status --short
```

If the vault is not a git repository, say so and continue.

## Output format

Write a concise report:

```markdown
# Brain Governance Audit — YYYY-MM-DD

## Summary
- Status: PASS / WARN / BLOCKED
- Main risk: ...

## Findings
### HIGH
- ...

### MEDIUM
- ...

### LOW
- ...

## Suggested next actions
1. ...
2. ...

## Files / areas inspected
- ...
```

## Safety rules

- Read-only by default.
- Do not move, delete, rename, or rewrite files.
- Do not commit changes.
- If a fix is obvious, suggest it as a proposed action.
- Escalate top-level structure changes to a human.
