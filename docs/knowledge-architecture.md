# Knowledge Architecture — How Your Knowledge Base Is Organized

---

## The Problem Brain OS Solves

Most personal knowledge systems fail because they mix three things:
1. **What you're reading** (curated, polished content)
2. **What AI is processing** (raw inputs, drafts, work-in-progress)
3. **How the system works** (indexes, state, reports)

When these overlap, your knowledge base becomes a mess of half-finished notes, duplicate entries, and processing artifacts.

Brain OS solves this with **physical separation**.

---

## The Three-Layer Architecture

### Layer 1: READING — What You Read

```
03-KNOWLEDGE/01-READING/
├─ 01-DOMAINS/        ← Domain knowledge cards (AI + you)
├─ 02-TOPICS/         ← Topic aggregation pages (AI)
├─ 03-PATTERNS/       ← Verified pattern cards (AI + you)
└─ 04-DIGESTS/        ← Daily/weekly summaries (AI auto-generated)
```

**This is where you start every day.** Open `04-DIGESTS/` and see what's new.

| Subdirectory | What's inside | Example |
|-------------|---------------|---------|
| `01-DOMAINS/` | Knowledge cards organized by domain | `ai-agents.md`, `distributed-systems.md` |
| `02-TOPICS/` | Cross-cutting topic pages | `llm-reliability.md`, `prompt-engineering.md` |
| `03-PATTERNS/` | Reusable patterns extracted from experience | `retry-with-exponential-backoff.md` |
| `04-DIGESTS/` | AI-generated daily/weekly summaries | `nightly-digest-2026-04-07.md` |

### Layer 2: WORKING — AI's Workshop

```
03-KNOWLEDGE/02-WORKING/
├─ 01-ARTICLE-NOTES/        ← Raw article inputs (your capture point)
├─ 02-PATTERN-CANDIDATES/   ← Patterns awaiting verification
├─ 03-TOPIC-DRAFTS/         ← Topic pages in progress
└─ 04-RESEARCH-QUESTIONS/   ← Open research questions
```

**You rarely need to look here.** This is AI's workspace.

| Subdirectory | What happens here |
|-------------|-------------------|
| `01-ARTICLE-NOTES/` | New articles land here (you or AI creates them) |
| `02-PATTERN-CANDIDATES/` | AI drafts patterns, you verify and promote to `03-PATTERNS/` |
| `03-TOPIC-DRAFTS/` | AI drafts topic pages, you review before publishing to `02-TOPICS/` |
| `04-RESEARCH-QUESTIONS/` | Open questions that might become research topics |

### Layer 3: SYSTEM — Pipeline Internals

```
03-KNOWLEDGE/99-SYSTEM/
├─ 01-INDEXES/               ← Auto-generated indexes
├─ 02-EXTRACTIONS/           ← Extracted facts/fragments
├─ 03-INTEGRATION-REPORTS/   ← Pipeline run reports
├─ 04-JOB-STATE/             ← Pipeline state checkpoints
└─ 05-META/                  ← Schema, metadata, path mappings
```

**You never need to look here.** This is entirely AI-internal.

---

## Knowledge Flow

```
You read an article
        │
        ▼
02-WORKING/01-ARTICLE-NOTES/
( raw capture with frontmatter )
        │
   [02:00 Pipeline]
        │
        ├─→ 01-READING/01-DOMAINS/   (new/updated knowledge card)
        ├─→ 01-READING/02-TOPICS/    (topic page updated)
        ├─→ 01-READING/03-PATTERNS/  (if pattern detected)
        └─→ 01-READING/04-DIGESTS/   (digest entry)
        │
   [04:00 Pipeline]
        │
        └─→ Cross-references added
        └─→ "Today's recommended reading" populated
```

---

## Article Note Lifecycle

```
pending     → Raw capture, just created
             │
             ▼
integrated  → Pipeline processed it, knowledge extracted
             │
             ▼
archived    → No longer actively referenced
             (kept for searchability)
```

---

## Domain Knowledge Card Format

```yaml
---
title: "AI Agent Architectures"
date: 2026-04-07
domain: AI-Agent
status: active        # active | archived | draft
tags: [agents, architecture, design-patterns]
source_type: curated  # article | curated | synthesized
related_notes:
  - [[tool-use-patterns]]
  - [[llm-reliability]]
updated: 2026-04-07
---

# AI Agent Architectures

## One-Liner
Common architectural patterns for building reliable AI agent systems.

## Key Concepts
- ReAct loop
- Tool calling
- Memory management
- Error handling patterns

## Patterns
- [[retry-with-exponential-backoff]]
- [[graceful-degradation]]

## Open Questions
- How to handle tool conflicts?
- Optimal context window management?
```

---

## Best Practices

### 1. Start from Digests
Don't browse `01-DOMAINS/` randomly. Check `04-DIGESTS/` first — AI tells you what's new and what matters.

### 2. Let AI Do the Wiring
Don't manually create cross-references. The pipeline does this automatically. You just capture inputs.

### 3. Verify Before Promoting
Pattern candidates in `02-WORKING/` are AI's best guesses. Review before they become permanent in `01-READING/`.

### 4. Don't Edit System Files
`99-SYSTEM/` is managed entirely by the pipeline. Your edits will be overwritten.

### 5. Archive, Don't Delete
Old knowledge cards should be moved to `status: archived`, not deleted. They're still useful for search.

---

## Scaling the System

As your knowledge base grows:

| Size | Strategy |
|------|----------|
| < 100 notes | No special handling needed |
| 100-500 notes | Run `knowledge-lint.sh` weekly to catch issues |
| 500+ notes | Consider QMD (query-memory-docs) for semantic search |
| 1000+ notes | Increase lint frequency, consider domain subdirectories |

---

## Integration with External Tools

- **QMD (query-memory-docs)**: Recommended for semantic search across large knowledge bases. Works as a drop-in search backend.
- **Obsidian**: Native markdown rendering, backlinks, graph view.
- **OpenClaw**: AI scheduling, nightly pipeline execution, cron jobs.
