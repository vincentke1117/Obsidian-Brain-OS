---
name: filing-approval-check-daily
schedule: "0 9 * * *"
agent: review
model: minimax/MiniMax-M2.7-highspeed
enabled: true
description: 每日提醒查看备案审批结果
delivery_mode: webhook
---

# filing-approval-check-daily

请提醒{{USER_NAME}}：今天查看一次备案审批结果。口径：备案已提交，当前只需跟踪政府审批进度，若有新状态/补件/反馈立即处理。保持2-3行，简洁。

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
