# Release Versioning Guide

Brain OS uses semantic versioning for public releases:

```text
MAJOR.MINOR.PATCH
```

Use this guide when deciding whether a change should be released as a patch, minor, or major update.

## Quick decision table

| Change type | Version bump | Examples |
|---|---:|---|
| Typo fixes, broken links, small clarification | PATCH | `1.2.0` → `1.2.1` |
| New docs page or example that does not change behavior | PATCH or MINOR | new guide, new FAQ |
| New reusable skill, prompt, schema, or script | MINOR | `1.2.0` → `1.3.0` |
| New cron example or install profile capability | MINOR | new governance audit example |
| Backward-compatible behavior improvement | MINOR | safer lint, better verifier |
| Breaking vault layout, config, or install contract | MAJOR | `1.x` → `2.0.0` |

## Patch releases

Use a patch release for small, safe improvements:

- docs fixes
- typo fixes
- broken link fixes
- README clarification
- small script bug fixes that keep the same interface
- placeholder cleanup

Patch releases should not require users to change their vault structure, cron jobs, or config.

## Minor releases

Use a minor release when Brain OS gains a new reusable capability:

- new skill
- new cron prompt template
- new cron example JSON
- new script or schema
- new guide that introduces a substantial workflow
- new install profile option
- new governance / safety module

Minor releases should remain backward-compatible.

## Major releases

Use a major release only when users may need migration steps:

- vault template layout changes that break existing paths
- config key renames or removals
- setup behavior that changes default installed modules
- cron architecture changes that require manual migration
- skill behavior changes that invalidate old docs

Major releases must include a migration guide.

## Changelog rules

Update both:

- `CHANGELOG.md`
- `CHANGELOG_CN.md`

Use these sections:

- `Added`
- `Changed`
- `Fixed`
- `Deprecated`
- `Removed`
- `Security`

Keep English and Chinese changelogs aligned.

## Bilingual docs rule

For user-facing docs, add or update both English and Chinese versions when the repository already has a bilingual pattern.

Examples:

| English | Chinese |
|---|---|
| `docs/governance-sync-boundary.md` | `docs/zh/governance-sync-boundary.md` |
| `docs/release-versioning.md` | `docs/zh/release-versioning.md` |
| `docs/governance-cron-guide.md` | `docs/zh/governance-cron-guide.md` |

If a Chinese page cannot be completed in the same PR, say so clearly in the PR body and explain why.

## Pre-PR checklist

Before opening a PR:

```bash
bash scripts/check-pii.sh
bash scripts/check-brain-config-leaks.sh
bash scripts/verify-install.sh
```

At minimum, run PII and config-leak checks for docs / prompt / skill changes.

## Release note template

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
