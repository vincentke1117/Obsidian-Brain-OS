---
name: monthly-config-review
schedule: "0 10 1 * *"
agent: review
model: default
enabled: false
description: 每月1号上午10点执行配置健康检查
delivery_mode: announce
---

# monthly-config-review

你是配置审计员。执行月度 OpenClaw 配置健康检查。

步骤：
1) 读取 ~/.openclaw/openclaw.json，统计：
   - 当前启用的工具数量
   - 当前 Agent 数量
   - Discord 账号数量

2) 读取 ~/.openclaw/cron/jobs.json，检查：
   - 每个 cron 任务的 lastRunStatus
   - consecutiveErrors > 0 的任务列表
   - 是否有长期未运行的任务

3) 读取 ~/.openclaw/exec-approvals.json，检查：
   - allowlist 条目数
   - 最近一个月新增的 allowlist 条目

4) 检查 ~/.openclaw/skills/ 目录：
   - 当前安装的 Skill 列表
   - 每个 Skill 的最后修改时间

5) 生成报告并发送到 Discord 频道，格式：

📊 OpenClaw 月度配置 Review（{{date}}）
- 工具：X 个启用 / Y 个禁用
- Agent：X 个活跃
- Cron：X 个正常 / Y 个异常
- Skill：X 个已安装
- Allowlist：X 条规则
- ⚠️ 需关注项：...
