# Project Management — Lightweight Registry and Tool Recommendations

---

## Brain OS Philosophy on Projects

Brain OS is not a project management tool. It's a **personal context system** that helps you stay organized.

For project management, Brain OS provides:

1. **A lightweight project registry** (`04-PROJECTS/`) — just enough to give AI context
2. **Integration recommendations** for external tools — when you need real task tracking

---

## The Lightweight Project Registry

### When to Use It

- You have a project that's < 5 lines of context
- You want AI to know what you're working on (for briefings and knowledge integration)
- You need a quick reference to external project links

### When NOT to Use It

- You need kanban boards, burndown charts, or sprint planning
- You're managing a team with multiple contributors
- You need issue tracking with assignments and due dates

→ Use an external tool instead.

---

## Project Brief Format

Each project gets one markdown file in `04-PROJECTS/01-ACTIVE/`:

```yaml
---
title: "My Project"
date: 2026-04-07
project_ref: "my-project"
status: active          # active | paused | completed
source_of_truth: "https://github.com/user/repo"
owner: "{{USER_NAME}}"
tags: [web, side-project]
---

# My Project

## One-Liner
Build a personal blog with AI-powered content suggestions.

## Current Phase
MVP Development

## Current Focus
Setting up the article generation pipeline.

## Source of Truth
- Code: `https://github.com/user/my-blog`
- Tasks: `https://linear.app/workspace/project/my-blog`
- Docs: `{{BRAIN_PATH}}/04-PROJECTS/01-ACTIVE/my-project.md`

## Related Knowledge
- [[content-generation-patterns]]
- [[ai-writing-assistants]]

## Key Decisions
| Date | Decision | Reason |
|------|----------|--------|
| 2026-04-01 | Use Astro framework | Best static site performance |
| 2026-04-05 | AI-generated drafts only | Speed over perfection |

## Search Keywords
my-blog, astro, content-generation, side-project
```

---

## Recommended External Tools

### 1. Agora — AI-Native Task Management

**Best for:** People who want AI deeply integrated into their task workflow.

[![Agora](https://img.shields.io/badge/Tool-Agora-blue)](https://github.com/nicepkg/aide)

Agora provides:
- AI-native task management with context infrastructure
- Automatic context packaging for AI agents
- NotebookLM integration for deep research
- Built-in knowledge graph for task relationships

**Why we recommend it:** Agora's "context infrastructure" approach pairs perfectly with Brain OS. Brain OS manages your knowledge and personal context; Agora manages your tasks and projects. Together, they give AI the full picture.

**Setup with Brain OS:**
1. Install Agora
2. Create project briefs in `04-PROJECTS/` pointing to Agora task URLs
3. AI reads project context from Brain OS when working on Agora tasks

### 2. Linear

**Best for:** Software teams that need fast, modern issue tracking.

[![Linear](https://img.shields.io/badge/Tool-Linear-purple)](https://linear.app)

Clean interface, great keyboard shortcuts, good API. Link tasks to Brain OS project briefs.

### 3. GitHub Issues / Projects

**Best for:** Open-source projects or teams already on GitHub.

[![GitHub](https://img.shields.io/badge/Tool-GitHub-black)](https://github.com)

No additional setup needed. Reference issue URLs in project briefs.

### 4. Notion

**Best for:** Teams that need a flexible, all-in-one workspace.

[![Notion](https://img.shields.io/badge/Tool-Notion-white)](https://notion.so)

Powerful but heavy. Good if you're already in the Notion ecosystem.

---

## Integration Pattern

```
Brain OS (04-PROJECTS/)
    │
    │  "What am I working on?"
    │  AI reads project briefs for context
    │
    ├──→ Agora / Linear / GitHub Issues
    │    "What are the specific tasks?"
    │    Detailed task tracking happens here
    │
    └──→ 03-KNOWLEDGE/
         "What have I learned?"
         Knowledge from project work flows here
```

The project brief in Brain OS is the **bridge** between your task tool and your knowledge base.

---

## Project Lifecycle

```
01-ACTIVE/      ← Currently working on
    │
    ├─→ 02-PAUSED/     ← On hold (with reason)
    │       │
    │       └─→ 01-ACTIVE/  (resumed)
    │
    └─→ 03-COMPLETED/  ← Done (with retrospective notes)
```

When moving a project:
1. Update `status` in frontmatter
2. Move the file to the appropriate directory
3. Add a brief note about why it moved (paused/completed)
4. For completed projects: add key learnings to `03-KNOWLEDGE/`
