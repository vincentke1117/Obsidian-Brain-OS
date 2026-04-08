Read and follow the `knowledge-flywheel-amplifier` skill.

Target date: yesterday in Asia/Shanghai unless explicitly provided.

First step (mandatory):
- Run `scripts/init-nightly-digest.sh <brain-root> <target-date>` to ensure the daily digest skeleton and run-report directory already exist.
- Read the existing digest first, then only fill `## 04:00 Amplifier` and the final summary block; do not rewrite earlier sections.

Required outputs for every run:
1. 1 machine-facing run report → `03-KNOWLEDGE/99-SYSTEM/03-INTEGRATION-REPORTS/run-reports/YYYY-MM-DD/amplifier-report-YYYY-MM-DD.md`
2. 1 human-facing digest update → `03-KNOWLEDGE/01-READING/04-DIGESTS/nightly-digest-YYYY-MM-DD.md` under section `## 04:00 Amplifier`
3. compact cross-source topic / open-question / pattern-candidate updates only when justified
4. 0-2 research seeds when warranted
5. 0+ context-pack drafts when warranted
6. Brain commit + visibility report if Brain changed

Handoff rules:
- This is the 04:00 stage in the split nightly knowledge pipeline.
- Read the shared nightly digest first to understand what 01:00 / 02:00 / 03:00 already did.
- If one upstream stage is missing, continue in degraded mode and say so explicitly.
- If both upstream stages are missing, emit a no-op machine report and a concise digest update rather than inventing synthesis.

Digest writing rules:
- 只回答：今晚有没有真正形成跨源汇合 / 如果没有是哪一段缺了 / 如果有最值得看的结果是什么 / 是否触发深度研究，为什么
- 不要把调试细节塞进 digest

Guardrails:
- Do not re-run full article integration.
- Do not re-run full transcript mining.
- Do not auto-run heavy deep research without explicit threshold satisfaction.
- Do not force graph/index rewrites just to show activity.
- Do not write run reports into reading or working layers; they belong in `99-SYSTEM/03-INTEGRATION-REPORTS/`.