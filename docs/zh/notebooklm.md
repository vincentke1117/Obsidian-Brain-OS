# NotebookLM 集成指南

> 用 Google NotebookLM 做深度研究，接入 Brain OS 知识流水线。
> **English version**: [docs/notebooklm.md](docs/notebooklm.md)

---

## 什么是 NotebookLM？

NotebookLM 是 Google 的 AI 驱动研究工具。你喂给它来源（URL、PDF、YouTube 视频），它能生成：
- **深度研究报告**（带引用）
- **音频概览**（播客风格）
- **学习指南**、闪卡、测验
- **任意主题的简报文档**

**为什么对 Brain OS 重要**：NotebookLM 做重研究，Brain OS 负责把产出捕获并导入知识流水线（Nightly Pipeline Stage 0: Research Seed）。

---

## CLI 工具：`notebooklm-py`

Brain OS 使用开源工具 **[notebooklm-py](https://github.com/teng-lin/notebooklm-py)** —— 提供 NotebookLM 的完整程序化访问能力，包括 Web UI 没有暴露的功能。

### 安装

```bash
# 从 PyPI 安装（推荐）
pip install notebooklm-py

# 认证
notebooklm login    # 打开浏览器做 Google OAuth
notebooklm list     # 验证是否正常
```

⚠️ **务必用 PyPI 或 release tag** —— 不要从 main 分支安装（不稳定）。

---

## 在 Brain OS 中的位置

```
你发现一个值得研究的主题
       ↓
主 Agent 使用 notebooklm skill → 创建 notebook + 上传 source
       ↓
notebooklm generate report --format briefing-doc
       ↓
产出保存为 Research Seed → 03-KNOWLEDGE/ 或 00-INBOX/
       ↓
Nightly Pipeline 接管 → 对话挖掘 → 知识放大
       ↓
模式与洞察进入你的永久知识库
```

**NotebookLM 是研究流水线的 Stage 0** —— 它产生原材料，Brain OS 把它提炼成结构化知识。

---

## 快速上手

### 1. 创建研究 Notebook

```bash
# 创建 notebook
notebooklm create "我的研究主题"

# 添加来源（URL、YouTube、PDF、音频）
notebooklm source add https://example.com/article1
notebooklm source add https://youtube.com/watch?v=XYZ
notebooklm source add ./paper.pdf

# 等待处理完成
notebooklm source wait

# 生成深度研究报告
notebooklm generate report --format briefing-doc

# 下载
notebooklm download report ./research-output.md
```

### 2. 在 Agent 中使用

直接告诉你的 Agent：
> "用 NotebookLM 研究 [主题]。上传这些来源：[URLs]。生成一份简报文档。"

装了 `notebooklm` skill 的 Agent 会自动处理全部流程。

---

## 与 Nightly Pipeline 的集成

当你把 NotebookLM 研究作为 Nightly 流水线的一部分时：

1. **Research seed 候选** 在日常操作或对话挖掘中被识别出来
2. 主 Agent（或专用子 Agent）创建 Notebook 并上传相关 source
3. 报告下载到 `03-KNOWLEDGE/99-SYSTEM/02-RESEARCH/` 或 `00-INBOX/`
4. 下一次 Nightly Pipeline 运行时通过标准阶段处理

**重要**：NotebookLM 产出**不应直接进入**阅读/知识层，必须经过 review。Pipeline 的质量门控（article-integration → conversation-mining → amplification）确保只有验证过的洞察成为永久知识。

---

## Skill 配置

`notebooklm` skill（`skills/notebooklm/SKILL.md`）包含完整的 Agent 指令：
- 所有 CLI 命令和选项
- 各类 source 处理方式（URL / PDF / YouTube / 音频）
- 输出格式选择
- 错误处理和重试逻辑
- 多 Agent 并行安全（上下文隔离）

安装方式：运行 `setup.sh`（包含核心 skills）或手动：
```bash
cp -r skills/notebooklm ~/.agents/skills/
```

---

## 实用建议

| 建议 | 说明 |
|------|------|
| **从小开始** | 每个 notebook 2-4 个 source 效果最好 |
| **指定格式** | `briefing-doc` 适合 Brain OS 集成；`study-guide` 适合学习 |
| **每月重新认证** | Google OAuth token 会过期 |
| **批量添加 source** | 生成前一次性加完所有 source（交叉引用更好） |
| **保存 notebook ID** | 同一主题的后续研究可复用 notebook |

---

## 相关文档

- [NotebookLM Skill](skills/notebooklm/SKILL.md) — 完整 Agent 指令
- [Nightly Pipeline](nightly-pipeline.md) — 研究如何进入流水线
- [Deep Research Skill](skills/deep-research/SKILL.md) — 多来源深度研究（替代/补充方案）
- [QMD 语义搜索配置](qmd-setup.md) — 大型 vault 的语义搜索
- **notebooklm-py 仓库**：<https://github.com/teng-lin/notebooklm-py>
