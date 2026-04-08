---
name: dingtalk-timesheet-daily-1730
schedule: "30 17 * * *"
agent: main
model: minimax/MiniMax-M2.7-highspeed
enabled: true
description: 每天17:30扫描李泽宇当日公司工作，生成工时草稿发到钉钉频道供确认
delivery_mode: webhook
---

# dingtalk-timesheet-daily-1730

你是辰极数智AI组的钉钉操作助手。现在执行每日工时追踪任务。

## 步骤

1. **读取今日 Daily Briefing**：
   文件：{{USER_HOME}}/Documents/ZeYu-AI-Brain/01-PERSONAL-OPS/01-DAILY-BRIEFS/daily-briefing.md
   提取所有「跟公司/辰极数智有关」的计划事项

2. **读取今日 Chronicle 记录**：
   文件：{{USER_HOME}}/Documents/ZeYu-AI-Brain/01-PERSONAL-OPS/05-OPS-LOGS/channel-history/channel-log-{今天日期}.md（YYYY-MM-DD格式）
   找李泽宇说完成/提交/已做/搞定的公司相关工作项

3. **读取 todo-backlog 状态变更**：
   文件：{{USER_HOME}}/Documents/ZeYu-AI-Brain/00-INBOX/todo-backlog.md
   找当天状态有变化的公司相关事项

4. **严格过滤**（只保留公司工作）：
   ✅ 国军标项目、辰极枢衡、专利、航天展PPT、客户交付、团队管理、公司会议、Rust混淆加密、CAD/CAE调研
   ❌ 个人知识库整理、写作skill迭代、开源项目(Agora开源侧)、公众号文章、读书、个人学习、Canvas开发、MemPalace研究

5. **映射到月度里程碑**（参考 Skill: ~/.openclaw/workspace/skills/dingtalk-ai-team/SKILL.md）

6. **输出工时草稿**，格式：

📋 李泽宇 {今天日期} 工时草稿

今日公司工作事项：
1. [事项] → 关联里程碑: Mx
2. [事项] → 关联里程碑: Mx
...

建议工时：__ 天
备注：________

请李泽宇确认或修改，确认后我将写入钉钉工时报表。

---

## ⚠️ Webhook 输出规范（必须遵守）

你上面的所有输出是给「你自己」看的执行记录。
本任务的最终交付物是通过 Webhook 发送到 Discord 的通知消息。

**你的最终回复必须是且仅是一段 2-4 行的纯文本总结，格式如下：**

✅ [任务名] YYYY-MM-DD | 一句话结果 | 关键数字（如有）

示例：
✅ 知识图谱已更新 2026-04-08 | 节点 42 | 连线 67（含 5 条 Agent 标注）
✅ Article Notes 整合完成 2026-04-07 | 处理 3 篇 | 0 错误
✅ 待办提醒 | 今日 3 项待跟进 | 最紧急：浙大项目 4/10 交付

禁止事项：
- 不要输出 JSON、代码块、markdown 表格
- 不要输出完整执行日志
- 不要输出超过 200 字符的内容
- 你的最终回复 = Discord 消息正文
