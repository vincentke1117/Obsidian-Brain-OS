# Governance Cron Guide

This guide shows how to run a lightweight Brain OS governance audit as a scheduled agent job.

## What it does

The governance audit checks whether your vault is drifting structurally:

- formal plans misplaced in workspaces or prompt folders
- prompts mixed into human-facing plan directories
- raw assets accidentally committed to Git
- duplicated source-of-truth documents
- new folders created without following local structure
- project plans missing local `plans/README.md` conventions

It does **not** rewrite your vault automatically.

## Files

| File | Purpose |
|---|---|
| `skills/brain-vault-governance/` | Rules the agent should follow |
| `prompts/cron/brain-governance-audit.prompt.md` | Scheduled audit prompt |
| `cron-examples/governance.json` | Importable OpenClaw cron example |

## Recommended schedule

Start weekly:

```text
Monday 01:30
```

Run more often only after the reports are useful and low-noise.

## Install steps

1. Copy or install the `brain-vault-governance` skill into your agent skills directory.
2. Copy `prompts/cron/brain-governance-audit.prompt.md` into your vault prompt directory:
   ```text
   {{BRAIN_ROOT}}/04-SYSTEM/prompts/cron/brain-governance-audit.prompt.md
   ```
3. Import or adapt `cron-examples/governance.json`.
4. Replace placeholders such as:
   - `{{BRAIN_ROOT}}`
   - `{{WORKSPACE_ROOT}}`
   - `{{MAIN_MODEL}}`

## OpenClaw import example

```bash
openclaw cron import cron-examples/governance.json
```

If your OpenClaw version does not support import, copy the job object into your cron config manually.

## What the report should include

A useful report contains:

1. Summary: pass / warnings / blockers
2. Misplaced plans
3. Prompt / plan boundary issues
4. Raw asset leakage risks
5. Duplicate truth-source risks
6. Suggested fixes
7. Files inspected

## Safety rules

The scheduled audit should be read-only by default.

It may suggest moves or rewrites, but should not perform them unless a human explicitly asks for execution.

## Escalation

Escalate to a human when:

- a top-level folder change is needed
- many files need migration
- deletion is proposed
- private data may have entered Git
- the audit finds a repeated governance failure
