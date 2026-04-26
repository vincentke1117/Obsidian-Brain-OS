# 治理巡检 Cron 指南

本文说明如何把 Brain OS 治理巡检作为定时 agent 任务运行。

## 它做什么

治理巡检用于检查 vault 是否出现结构漂移：

- 正式计划误放在 workspace 或 prompt 目录
- prompt 混进面向人类的计划目录
- 原始资产被误提交到 Git
- 出现重复真相源
- 新建目录没有遵守本地结构
- 项目计划缺少本地 `plans/README.md` 约定

它默认**不自动重写 vault**。

## 相关文件

| 文件 | 用途 |
|---|---|
| `skills/brain-vault-governance/` | agent 应遵循的治理规则 |
| `prompts/cron/brain-governance-audit.prompt.md` | 定时巡检 prompt |
| `cron-examples/governance.json` | 可导入的 OpenClaw cron 示例 |

## 推荐频率

先从每周一次开始：

```text
周一 01:30
```

只有当报告稳定、噪音低时，再提高频率。

## 安装步骤

1. 将 `brain-vault-governance` skill 复制或安装到 agent skills 目录。
2. 将 `prompts/cron/brain-governance-audit.prompt.md` 复制到 vault 的 prompt 目录：
   ```text
   {{BRAIN_ROOT}}/04-SYSTEM/prompts/cron/brain-governance-audit.prompt.md
   ```
3. 导入或改写 `cron-examples/governance.json`。
4. 替换占位符：
   - `{{BRAIN_ROOT}}`
   - `{{WORKSPACE_ROOT}}`
   - `{{MAIN_MODEL}}`

## OpenClaw 导入示例

```bash
openclaw cron import cron-examples/governance.json
```

如果你的 OpenClaw 版本不支持 import，可以手动把 job 对象复制进 cron 配置。

## 报告应包含什么

一份有用的报告应包含：

1. 总结：通过 / 警告 / 阻塞
2. 错放的正式计划
3. prompt / plan 边界问题
4. 原始资产泄漏风险
5. 重复真相源风险
6. 建议修复动作
7. 已检查文件范围

## 安全规则

定时巡检默认只读。

它可以建议移动或重写，但不应直接执行，除非人类明确要求。

## 何时升级给人类确认

以下情况需要人工确认：

- 需要改变顶层目录
- 需要批量迁移很多文件
- 涉及删除
- 私有数据可能进入 Git
- 巡检发现重复治理失败
