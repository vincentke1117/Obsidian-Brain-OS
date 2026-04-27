# Agent Bootstrap Guide: AGENTS.md and References

> Chinese version: [docs/zh/agent-bootstrap-guide.md](zh/agent-bootstrap-guide.md)

Brain OS works best when each agent has a small always-on bootstrap and a set of on-demand references.

This guide explains how to write `AGENTS.md`, when to use `USER.md`, and how to organize `references/` so agents can install, audit, and maintain Brain OS without loading a giant manual on every turn.

---

## Recommended workspace shape

```text
agent-workspace/
├── AGENTS.md                 # always-on operating constitution
├── USER.md                   # stable owner preferences, no secrets
├── MEMORY.md                 # optional long-term memory, private
├── TOOLS.md                  # local tool notes, private
├── references/               # on-demand manuals
│   ├── README.md
│   ├── vault-write-rules.md
│   ├── open-source-sync-rules.md
│   ├── channel-collaboration-rules.md
│   └── cron-rules.md
├── memory/                   # daily logs, if your runtime uses them
├── scripts/
├── prompts/
└── outputs/
```

For copyable examples, see:

```text
examples/agent-workspace/AGENTS.example.md
examples/agent-workspace/USER.example.md
examples/agent-workspace/references/
```

---

## What belongs in AGENTS.md

`AGENTS.md` is the always-on constitution. Keep it short enough to load every session.

Put these in `AGENTS.md`:

- startup checklist
- identity and role
- safety boundaries
- operating principles
- Brain OS source-of-truth rules
- reference index
- done criteria

Do not put long tool manuals, huge team rosters, or detailed SOPs directly in `AGENTS.md`.

Recommended size: under ~250 lines.

---

## What belongs in USER.md

`USER.md` stores stable owner preferences that help the agent behave correctly.

Good examples:

- preferred language and timezone
- response style
- safe defaults
- vault path placeholder
- install profile preference

Do not store secrets, API keys, passwords, access tokens, or private documents in `USER.md`.

---

## What belongs in references/

References are loaded only when needed.

Use references for task-specific rules such as:

- vault write / move rules
- open-source sync boundaries
- channel collaboration rules
- cron prompt rules
- project-specific runbooks
- troubleshooting notes

Each reference should include:

1. when to read it
2. core rule
3. procedure
4. safe examples
5. common mistakes

---

## Reference index pattern

Add a small table to `AGENTS.md`:

```markdown
## Reference Index

| Reference | Trigger |
|---|---|
| `references/vault-write-rules.md` | Creating or moving durable vault files |
| `references/open-source-sync-rules.md` | Deciding what belongs in a public repo |
| `references/cron-rules.md` | Creating or editing scheduled jobs |
```

The agent should read references only when their trigger matches the task.

---

## Public vs private bootstrap files

For open source repositories:

- publish examples and templates
- use placeholders like `{{BRAIN_ROOT}}`, `{{OWNER_NAME}}`, `{{DISCORD_CHANNEL_ID}}`
- never publish your real `AGENTS.md` if it contains private identity, memory, team IDs, or local paths
- never publish `MEMORY.md`, private `TOOLS.md`, or private runtime configuration

For local deployments:

- keep private context local
- store secrets in environment variables or secret providers
- keep long-term memories separate from public examples

---

## Agent install checklist

When an agent installs this layer:

1. Copy `examples/agent-workspace/AGENTS.example.md` to the target workspace as `AGENTS.md`.
2. Copy `examples/agent-workspace/USER.example.md` to `USER.md` if useful.
3. Copy or adapt `examples/agent-workspace/references/`.
4. Replace every `{{PLACEHOLDER}}`.
5. Remove any reference that does not apply.
6. Add deployment-specific references only if they are reusable.
7. Run a privacy scan before committing any adapted file.

---

## Common mistakes

- Making `AGENTS.md` a giant manual.
- Hiding critical safety rules deep inside a reference.
- Creating references with no trigger in the index.
- Publishing local private bootstrap files instead of sanitized examples.
- Letting examples contain real channel IDs, owner names, local paths, or tokens.

---

## Related docs

- [Feature Matrix](feature-matrix.md)
- [Agent Workspace Cleanup Guide](agent-workspace-cleanup-guide.md)
- [Skill Authoring Guide](skill-authoring-guide.md)
- [PII Deidentification Guide](references/pii-deidentification-guide.md)
