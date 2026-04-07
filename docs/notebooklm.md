# NotebookLM Integration Guide

> Use Google's NotebookLM for deep research, powered by Brain OS.
> **Chinese version**: [docs/zh/notebooklm.md](docs/zh/notebooklm.md)

---

## What is NotebookLM?

NotebookLM is Google's AI-powered research tool. You feed it sources (URLs, PDFs, YouTube videos), and it generates:
- **Deep research reports** with citations
- **Audio overviews** (podcast-style)
- **Study guides**, flashcards, quizzes
- **Briefing documents** on any topic

**Why it matters for Brain OS**: NotebookLM does the heavy research lifting. Brain OS captures the output and routes it into your knowledge pipeline (Nightly Pipeline Stage 0: Research Seed).

---

## The CLI Tool: `notebooklm-py`

Brain OS uses **[notebooklm-py](https://github.com/teng-lin/notebooklm-py)** — an open-source CLI that provides full programmatic access to NotebookLM, including capabilities not in the web UI.

### Installation

```bash
# From PyPI (recommended)
pip install notebooklm-py

# Authenticate
notebooklm login    # Opens browser for Google OAuth
notebooklm list     # Verify it works
```

⚠️ **Always use PyPI or a release tag** — never install from main branch (unstable).

---

## How It Fits Into Brain OS

```
You discover a topic worth researching
       ↓
Main Agent uses notebooklm skill → creates notebook + uploads sources
       ↓
notebooklm generate report --format briefing-doc
       ↓
Output saved as Research Seed → 03-KNOWLEDGE/ or 00-INBOX/
       ↓
Nightly Pipeline picks it up → conversation mining → knowledge amplification
       ↓
Patterns & insights enter your permanent knowledge base
```

**NotebookLM is Stage 0 of the research pipeline** — it produces raw material that Brain OS refines into structured knowledge.

---

## Quick Workflow

### 1. Create a Research Notebook

```bash
# Create notebook
notebooklm create "My Research Topic"

# Add sources (URLs, YouTube, PDFs, audio)
notebooklm source add https://example.com/article1
notebooklm source add https://youtube.com/watch?v=XYZ
notebooklm source add ./paper.pdf

# Wait for processing
notebooklm source wait

# Generate deep research report
notebooklm generate report --format briefing-doc

# Download
notebooklm download report ./research-output.md
```

### 2. From Within Your Agent

Just tell your agent:
> "Use NotebookLM to research [topic]. Upload these sources: [URLs]. Generate a briefing document."

Your agent (with the `notebooklm` skill installed) will handle everything automatically.

---

## Integration With Nightly Pipeline

When you run NotebookLM research as part of your nightly workflow:

1. **Research seed candidates** are identified during daily operations or conversation mining
2. Main Agent (or a dedicated sub-agent) creates NotebookLM notebooks with relevant sources
3. Reports are downloaded to `03-KNOWLEDGE/99-SYSTEM/02-RESEARCH/` or `00-INBOX/`
4. Next Nightly Pipeline run processes them through the standard stages

**Important**: NotebookLM output should **not** go directly into your reading/knowledge layers without review. The pipeline's quality gates (article-integration → conversation-mining → amplification) ensure only validated insights become permanent knowledge.

---

## Configuring the Skill

The `notebooklm` skill (`skills/notebooklm/SKILL.md`) contains complete instructions for your agent, including:
- All CLI commands and options
- Source type handling (URL vs PDF vs YouTube vs audio)
- Output format selection
- Error handling and retry logic
- Parallel agent safety (context isolation)

Install it by running `setup.sh` (includes core skills) or manually:
```bash
cp -r skills/notebooklm ~/.agents/skills/
```

---

## Tips

| Tip | Detail |
|-----|--------|
| **Start small** | 2-4 sources per notebook for best results |
| **Use specific formats** | `briefing-doc` for Brain OS integration; `study-guide` for learning |
| **Re-authenticate monthly** | Google OAuth tokens expire |
| **Batch sources** | Add all sources before generating (better cross-referencing) |
| **Save notebook IDs** | Re-use notebooks for follow-up research on same topic |

---

## Related

- [NotebookLM Skill](skills/notebooklm/SKILL.md) — Complete agent instructions
- [nightly-pipeline.md](nightly-pipeline.md) — How research feeds into the pipeline
- [deep-research skill](skills/deep-research/SKILL.md) — Multi-source research (alternative/complement)
- [QMD Setup](qmd-setup.md) — Semantic search for large vaults
- **notebooklm-py repo**: <https://github.com/teng-lin/notebooklm-py>
