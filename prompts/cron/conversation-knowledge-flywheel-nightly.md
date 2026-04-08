---
name: conversation-knowledge-flywheel-nightly
schedule: "0 3 * * *"
agent: unknown
model: openai-codex/gpt-5.4
enabled: false
description: Superseded by split nightly pipeline: 02 article integration, 03 conversation mining, 04 amplifier
delivery_mode: none
---

# conversation-knowledge-flywheel-nightly

Read and follow {{USER_HOME}}/.openclaw/workspace/conversation-knowledge-flywheel.prompt.md. Use the conversation-knowledge-flywheel skill as the governing protocol. Target date is yesterday in Asia/Shanghai unless explicitly provided. {{MAIN_AGENT_NAME}} is the integrator: project grouping -> resolve likely project -> read 05-PROJECTS/<slug>/project-brief.md -> QMD recall -> Surveillance pre-screen -> final synthesis -> writer package -> formal Brain landing when there is real signal. When project mapping is clear, outputs should carry lightweight anchors such as project_ref and related_projects; if confidence is low, leave project linkage blank rather than hallucinating. If QMD is unhealthy, report degraded mode explicitly. Do not force output when there is no signal. Success means Brain write + git commit + post-commit sync + Obsidian visible.
