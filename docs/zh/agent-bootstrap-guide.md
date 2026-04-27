# Agent Bootstrap 指南：AGENTS.md 与 References

> English version: [docs/agent-bootstrap-guide.md](../agent-bootstrap-guide.md)

Brain OS 最适合的 agent workspace 结构，是一个短小的常驻 bootstrap，加上一组按需读取的 references。

本文说明 `AGENTS.md` 怎么写、`USER.md` 放什么、`references/` 怎么组织，方便 agent 安装、审计和维护 Brain OS，而不是每次会话都加载一大本操作手册。

---

## 推荐 workspace 结构

```text
agent-workspace/
├── AGENTS.md                 # 常驻行为宪法
├── USER.md                   # 稳定用户偏好，不放密钥
├── MEMORY.md                 # 可选长期记忆，私有
├── TOOLS.md                  # 本地工具备注，私有
├── references/               # 按需读取的操作手册
│   ├── README.md
│   ├── vault-write-rules.md
│   ├── open-source-sync-rules.md
│   ├── channel-collaboration-rules.md
│   └── cron-rules.md
├── memory/                   # 如果 runtime 支持，可放 daily logs
├── scripts/
├── prompts/
└── outputs/
```

可复制示例见：

```text
examples/agent-workspace/AGENTS.example.md
examples/agent-workspace/USER.example.md
examples/agent-workspace/references/
```

---

## AGENTS.md 应该放什么

`AGENTS.md` 是常驻行为宪法，应该足够短，适合每次会话加载。

适合放在 `AGENTS.md`：

- 启动检查清单
- 身份与职责
- 安全边界
- 工作原则
- Brain OS 事实源规则
- reference 索引
- 完成标准

不适合把长工具手册、大量团队名册、详细 SOP 直接塞进 `AGENTS.md`。

建议规模：少于约 250 行。

---

## USER.md 应该放什么

`USER.md` 存放稳定用户偏好，帮助 agent 更安全、更贴合地工作。

适合内容：

- 常用语言和时区
- 回复风格
- 安全默认值
- vault 路径占位符
- 安装 profile 偏好

不要在 `USER.md` 放 secrets、API keys、passwords、access tokens 或私有文档。

---

## references/ 应该放什么

References 是按需读取的操作手册。

适合放：

- vault 写入 / 移动规则
- 开源同步边界
- 频道协作规则
- cron prompt 规则
- 项目 runbook
- 排障备忘

每个 reference 应包含：

1. 什么时候读
2. 核心规则
3. 操作步骤
4. 安全示例
5. 常见错误

---

## Reference 索引写法

在 `AGENTS.md` 保留一个小表：

```markdown
## Reference Index

| Reference | Trigger |
|---|---|
| `references/vault-write-rules.md` | 创建或移动持久 vault 文件 |
| `references/open-source-sync-rules.md` | 判断内容是否适合进公开仓库 |
| `references/cron-rules.md` | 创建或修改 scheduled jobs |
```

Agent 只在 trigger 匹配任务时读取对应 reference。

---

## 公开与私有 bootstrap 的边界

对开源仓库：

- 发布 examples 和 templates
- 使用 `{{BRAIN_ROOT}}`、`{{OWNER_NAME}}`、`{{DISCORD_CHANNEL_ID}}` 这类占位符
- 不要发布真实 `AGENTS.md`，尤其当里面有私有身份、记忆、团队 ID、本地路径时
- 不要发布 `MEMORY.md`、私有 `TOOLS.md` 或真实运行配置

对本地部署：

- 私有上下文留在本地
- secrets 放环境变量或 secret provider
- 长期记忆和公开示例分离

---

## Agent 安装检查清单

Agent 安装这一层时：

1. 复制 `examples/agent-workspace/AGENTS.example.md` 到目标 workspace，命名为 `AGENTS.md`。
2. 如有需要，复制 `examples/agent-workspace/USER.example.md` 为 `USER.md`。
3. 复制或改写 `examples/agent-workspace/references/`。
4. 替换所有 `{{PLACEHOLDER}}`。
5. 删除不适用的 reference。
6. 只有可复用的部署规则才新增 reference。
7. 提交前运行隐私扫描。

---

## 常见错误

- 把 `AGENTS.md` 写成巨型操作手册。
- 把关键安全规则藏在很深的 reference 里。
- reference 没有在索引中写触发场景。
- 把本地私有 bootstrap 文件当成开源模板发布。
- 示例里残留真实频道 ID、用户姓名、本地路径或 token。

---

## 相关文档

- [功能清单](feature-matrix.md)
- [Agent 工作区整洁指南](../agent-workspace-cleanup-guide.md)
- [Skill 编写指南](../skill-authoring-guide.md)
- [PII 脱敏指南](../references/pii-deidentification-guide.md)
