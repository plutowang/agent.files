# Research Verification Note — 2026-08-15 (research-skill pass)

**Question:** Are the Phase-3 research findings (2025–2026 prompt-wording evidence) latest and correct, at high confidence?
**Method:** Loaded the `research` skill (primary sources only, every claim cited). Three verification agents re-fetched every load-bearing source page directly (not snippets) and quoted exact text; a newest-content sweep covered 2026-08-10 → 08-15.

## Findings

### Verdicts (28 claims re-verified)

| Group | Claims | Result |
|---|---|---|
| OpenAI GPT-5.6 guidance | A1–A6 | **All confirmed**; 2 wording corrections (A2 exact phrase = "Keep the policy in one place and state each rule once."; A5 exact phrase = "check whether broad brevity instructions… are still useful… can sometimes make responses too brief") |
| Anthropic + Claude Code | B7–B9, C10–C11 | **All confirmed verbatim** (30% query-at-end, Opus 4.8 literalism, "dial back aggressive language", 200-line CLAUDE.md budget, contradiction→arbitrary pick, pruning litmus test) |
| Gemini 3 | A1–A3 | Confirmed; **source correction**: negative-constraints-at-end sentence lives in the Google Cloud Gemini 3 prompting guide + Google's official `intro_prompt_design.ipynb` — NOT on ai.google.dev prompting-strategies |
| MiniMax | B4–B9 | **All confirmed verbatim** (flat structure, task-at-end, boundaries-before-generation, concrete output contracts, explain-why, concise system prompts) |
| DeepSeek V4-Pro | C10–C15 | **All confirmed**; corrections: "will not trigger an error but will also have no effect" (not "silently ignored"); tool-call hallucination warning is on the Chat Completions API reference, not guides/tool_calls; changelog re-verified: newest entry 2026-08-13, **nothing newer as of 2026-08-15** |
| arXiv papers (9 load-bearing) | #1–#9 | **All 9 IDs live — no hallucinated citations**; every quoted claim confirmed against abstract/body; one figure corrected (underspecification: "41–45% token reduction", body not abstract) |

### Newest-content sweep (2026-08-10 → 08-15)

- OpenAI Aug 13: Ultrafast service tier (not prompting guidance). Anthropic Aug 14: watermark post (not prompting). DeepSeek: no article after 08-13. MiniMax newest models 07-31; Kimi changelog stale (Apr 2025).
- **Two new arXiv papers (Aug 12, 2026) strengthen the findings**: 2608.12426 (probe-level success <50% at **7 constraints** for the strongest model; no inference-time fix) and 2608.11727 (aggregate scores overstate compliance; precedence does not follow prompt depth).

### Confidence levels

- **HIGH:** E1.1–E1.10 (vendor guidance), E2.1–E2.3 (MiniMax/Kimi/DeepSeek), E3.1–E3.13, E3.15, E3.17–E3.20 (academic — all re-fetched live)
- **MEDIUM (flagged):** E3.14 (CAVEWOMAN — single unreviewed preprint), E3.16 (SDE — incomplete draft, placeholder tables)
- No finding changed direction as a result of verification.

## Sources

- https://developers.openai.com/api/docs/guides/prompt-guidance-gpt-5p6
- https://platform.claude.com/docs/en/build-with-claude/prompt-engineering/claude-prompting-best-practices
- https://platform.claude.com/docs/en/build-with-claude/prompt-engineering/prompting-claude-opus-4-8
- https://code.claude.com/docs/en/memory · https://code.claude.com/docs/en/best-practices
- https://docs.cloud.google.com/gemini-enterprise-agent-platform/models/start/gemini-3-prompting-guide (currently 404; verified via official notebook)
- https://github.com/GoogleCloudPlatform/generative-ai/blob/main/gemini/prompts/intro_prompt_design.ipynb
- https://ai.google.dev/gemini-api/docs/gemini-3 · /docs/prompting-strategies
- https://platform.minimax.io/docs/token-plan/prompting-best-practices.md
- https://api-docs.deepseek.com/news/news260813 · /updates · /guides/thinking_mode · /guides/json_mode · /api/create-chat-completion · /quick_start/pricing
- https://huggingface.co/deepseek-ai/DeepSeek-V4-Pro-0813
- arXiv: 2512.17920, 2601.22047, 2608.02639, 2603.23527, 2505.13360, 2607.19257, 2511.14342, 2507.11538, 2512.14982, 2608.12426, 2608.11727
- https://developers.openai.com/changelog · https://www.anthropic.com/news · https://platform.minimaxi.com/docs/release-notes/models.md · https://platform.kimi.ai/docs/platform-changelog
