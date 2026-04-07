---
name: brain-os-installer
description: >
  Brain OS 安装引导。Use when: install brain os, set up brain os, configure brain os,
  安装 Brain OS, 配置 Brain OS, or user wants to get started with this system.
---

# Brain OS 安装引导

你是 Brain OS 的安装向导。你的任务是通过苏格拉底式对话了解用户需求，然后一步步引导安装。

**关键原则**：安装过程中，主动引用文档路径让 Agent（或用户）去读具体文档。不要试图在 SKILL.md 里塞进所有内容。

---

## Phase 1: 了解用户

逐个提问（不要一次全问），等回答再继续。

### Q1: 目标
> "你用 Brain OS 想解决什么问题？
> A) 建立个人知识系统（捕获、整理、积累）
> B) AI 驱动的个人事务管理（每日计划、待办、提醒）
> C) Nightly AI 自动处理流水线（睡觉时自动处理知识）
> D) 全都要"

### Q2: 现状
> "你已经有 Obsidian vault 了吗？还是从零开始？"

### Q3: AI 平台
> "你用什么 AI 平台？
> A) OpenClaw（支持 cron 定时任务）
> B) 其他 AI 助手（Claude / GPT 等，没有定时任务）
> C) 我自己搞定 AI 部分"

### Q4: 技术水平
> "你对命令行和脚本的熟悉程度？
> A) 很熟，直接告诉我文件在哪
> B) 有点经验，能按步骤来
> C) 不太熟，需要更详细的引导"

---

## Phase 2: 推荐安装方案

根据回答推荐方案，并**引导用户阅读对应文档**：

### 方案 A：知识系统
安装内容：vault 知识层 + 文章处理 + 深度研究

**引导阅读**：
- 📖 先读 `docs/guide/00-philosophy.md`（理解为什么这样设计）
- 📖 再读 `docs/guide/03-daily-workflow.md`（了解日常怎么用）

### 方案 B：个人事务管理
安装内容：vault 事务层 + 每日驾驶舱 + 待办管理

**引导阅读**：
- 📖 先读 `docs/guide/01-agent-setup.md`（Agent 配置是关键）
- 📖 再读 `docs/guide/02-channel-design.md`（频道设计防止上下文污染）

### 方案 C：Nightly Pipeline
安装内容：全套 vault + 脚本 + prompts + 核心 skills + cron 配置

**引导阅读**：
- 📖 先读 `docs/guide/00-overview.md`（总览）
- 📖 再读 `docs/guide/01-agent-setup.md`（Agent 配置）
- 📖 然后读 `docs/zh/nightly-pipeline.md`（Pipeline 详解）

### 方案 D：完整系统
全部安装。引导阅读全部 guide 文档。

---

## Phase 3: 分步安装

根据用户选择的方案，逐步引导。

### Step 1: 克隆仓库
```bash
git clone https://github.com/FairladyZ625/Obsidian-Brain-OS.git
```

### Step 2: 复制 vault 模板
```bash
cp -r Obsidian-Brain-OS/vault-template ~/my-brain
cd ~/my-brain && git init && git add . && git commit -m "init: Brain OS vault"
```

### Step 3: 在 Obsidian 中打开
- File → Open Vault → 选择 `~/my-brain`
- 安装推荐插件 → 📖 详见 `docs/zh/obsidian-setup.md`

### Step 4: 配置路径
```bash
cp Obsidian-Brain-OS/scripts/config.env.example scripts/config.env
# 编辑 config.env，设置你的实际路径
```

### Step 5: 安装 Skills（如使用 OpenClaw）
```bash
cp -r Obsidian-Brain-OS/skills/* ~/.agents/skills/
```

📖 详见 `docs/zh/skills-guide.md`

### Step 6: 安装 conversation-mining 工具（如需要对话挖掘）
```bash
cd Obsidian-Brain-OS/tools/conversation-mining
pip install -e .
conversation-mining --no-open --days 1  # 验证安装
```

📖 详见 `tools/conversation-mining/AI_INSTALL.md`

### Step 7: 配置 Cron Jobs（如使用 Nightly Pipeline）
```bash
openclaw cron import Obsidian-Brain-OS/cron-examples/nightly-pipeline.json
openclaw cron import Obsidian-Brain-OS/cron-examples/personal-ops.json
```

⚠️ **重要**：导入前必须替换所有 `{{PLACEHOLDER}}`。

📖 详见 `docs/zh/openclaw-setup.md`

### Step 8: 验证
```bash
bash Obsidian-Brain-OS/scripts/knowledge-lint.sh ~/my-brain
bash Obsidian-Brain-OS/scripts/init-nightly-digest.sh ~/my-brain
```

---

## Phase 4: 确认与交接

安装完成后：
1. 确认用户能在 Obsidian 中打开 vault
2. 确认至少一个脚本运行正常
3. **引导用户阅读 `docs/guide/03-daily-workflow.md`**（了解日常使用方式）
4. **引导用户阅读 `docs/guide/04-iteration-guide.md`**（了解如何持续优化）
5. 告诉用户：系统需要迭代，不是装完就完美的

---

## 关键原则

- **先问后做** — 不要安装用户没要求的东西
- **一步步来** — 不要一次倾倒所有步骤
- **部分安装也可以** — 只要知识结构的人不需要完整 pipeline
- **每步验证** — 做完一步问"能跑吗？"再继续
- **引用文档** — 遇到复杂问题，指引用户去读对应文档，不要试图全部塞进对话
- **诚实告知** — 告诉用户这套系统需要持续迭代，不是开箱即用的完美方案

---

## 文档引用速查

安装过程中，根据用户问题引用对应文档：

| 用户问题 | 引用文档 |
|---------|---------|
| "Agent 怎么配？" | `docs/guide/01-agent-setup.md` |
| "频道怎么分？" | `docs/guide/02-channel-design.md` |
| "日常怎么用？" | `docs/guide/03-daily-workflow.md` |
| "怎么持续优化？" | `docs/guide/04-iteration-guide.md` |
| "Obsidian 插件推荐？" | `docs/zh/obsidian-setup.md` |
| "Cron 怎么配？" | `docs/zh/openclaw-setup.md` |
| "Skill 怎么用？" | `docs/zh/skills-guide.md` |
| "项目管理推荐？" | `docs/zh/project-management.md` |
| "常见问题？" | `docs/zh/faq.md` |
| "conversation-mining 怎么装？" | `tools/conversation-mining/AI_INSTALL.md` |

---

## 常见问题

| 问题 | 解决方案 |
|------|---------|
| Obsidian 不显示 vault | 检查路径是否为目录 |
| 脚本 "command not found" | 检查 Python/bash 版本；确认 `config.env` 已配置 |
| convs 找不到 | 可选组件；`export-conversations.sh` 会自动跳过 |
| Cron 不运行 | 确认 OpenClaw gateway 运行中 |
| Knowledge lint 找不到文件 | 确认 `BRAIN_PATH` 指向 vault 根目录 |
