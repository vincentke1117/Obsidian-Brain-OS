# 发版与版本号指南

Brain OS 公开发版使用语义化版本：

```text
MAJOR.MINOR.PATCH
```

当你判断某个改动应该发 patch、minor 还是 major 时，使用本文档。

## 快速判断表

| 改动类型 | 版本号 | 示例 |
|---|---:|---|
| typo、坏链、轻量说明修正 | PATCH | `1.2.0` → `1.2.1` |
| 新增不改变行为的文档或示例 | PATCH 或 MINOR | 新 guide、新 FAQ |
| 新增可复用 skill、prompt、schema、script | MINOR | `1.2.0` → `1.3.0` |
| 新增 cron example 或安装档能力 | MINOR | 新 governance audit 示例 |
| 向后兼容的行为增强 | MINOR | 更安全的 lint、更好的 verifier |
| 破坏性 vault 结构、配置或安装契约变化 | MAJOR | `1.x` → `2.0.0` |

## Patch 版本

适合小而安全的改动：

- 文档修正
- typo 修正
- 坏链修复
- README 轻量澄清
- 不改变接口的小脚本 bug fix
- 占位符清理

Patch 不应该要求用户改 vault 结构、cron job 或配置。

## Minor 版本

当 Brain OS 新增可复用能力时，用 minor：

- 新 skill
- 新 cron prompt 模板
- 新 cron example JSON
- 新 script 或 schema
- 引入重要工作流的新 guide
- 新安装档选项
- 新治理 / 安全模块

Minor 应保持向后兼容。

## Major 版本

只有当用户可能需要迁移时，才发 major：

- vault-template 结构变化导致旧路径失效
- 配置 key 重命名或删除
- setup 默认安装模块发生改变
- cron 架构变化且需要人工迁移
- skill 行为变化导致旧文档失效

Major 必须提供 migration guide。

## Changelog 规则

同时更新：

- `CHANGELOG.md`
- `CHANGELOG_CN.md`

使用这些分区：

- `Added`
- `Changed`
- `Fixed`
- `Deprecated`
- `Removed`
- `Security`

英文和中文 changelog 要保持一致。

## 双语文档规则

面向用户的文档，如果仓库已经有中英双语模式，应同时新增或更新英文和中文版本。

示例：

| 英文 | 中文 |
|---|---|
| `docs/governance-sync-boundary.md` | `docs/zh/governance-sync-boundary.md` |
| `docs/release-versioning.md` | `docs/zh/release-versioning.md` |
| `docs/governance-cron-guide.md` | `docs/zh/governance-cron-guide.md` |

如果某个中文页无法在同一个 PR 中完成，必须在 PR 描述中说明原因。

## PR 前检查清单

开 PR 前运行：

```bash
bash scripts/check-pii.sh
bash scripts/check-brain-config-leaks.sh
bash scripts/verify-install.sh
```

对于 docs / prompt / skill 改动，至少要跑 PII 和 config-leak 检查。

## Release note 模板

```markdown
## Summary
- Added ...
- Updated ...

## Version impact
- Recommended bump: minor / patch / major
- Reason: ...

## Safety
- PII scan: pass
- Config leak scan: pass
```
