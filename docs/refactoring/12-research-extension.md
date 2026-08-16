# Phase 3 Audit — Research Extension (2026-08-15)

**Task:** Extend `docs/research/2026-08-12-agent-prompt-best-practices.md` with 2025–2026 primary sources on prompt wording precision, conciseness, and instruction-following quality.
**Method:** 4 delegated web-research agents (explore): vendor re-verification (Anthropic/OpenAI/Google), Chinese vendors (DeepSeek/MiniMax/Moonshot/Qwen), academic 2025–2026 (arXiv/ACL), DeepSeek V4-Pro latest articles (user-requested follow-up). Primary sources only; every claim carries a URL.

---

## 1. What was added

### Extension sections (appended to research doc)
- **E1 — Vendor doc updates** (12 findings): OpenAI GPT-5.6 guidance (10–15% leaner-prompt gain, contradiction > missing-detail, MUST/NEVER moderation, brevity-instruction caveat, section template), Anthropic (30% query-at-end, Opus 4.8 literalism), Claude Code (200-line budget confirmation, contradiction handling, pruning litmus test), Gemini 3 (conciseness; negative-constraints-at-end 2026 update), AGENTS.md/Codex 32KiB cap.
- **E2 — Chinese vendors** (4 vendors): MiniMax prompting best practices (flat sections, task-at-end, boundaries-before-generation, concrete output contracts, explain-why), Moonshot Kimi (XML tags endorsed, bullet-budget guidance, temperature notes), DeepSeek V4-Pro (no prompt doctrine; thinking-mode defaults; JSON-mode and tool-call caveats; V4-Pro specs), Qwen (delimiters, XML tool templates, temperature guidance).
- **E3 — Academic 2025–2026** (18 findings): CDCT ambiguity zone, LIFT length-constraint weakness, paradoxical interference, underspecification, instruction-stacking collapse, silent conflict resolution, hierarchy failure, IFScale saturation, model-specific position effects, LiM theory + failed reproduction, instruction survival under compression, compression RCTs, CAVEWOMAN, prompt repetition (attention coverage), SDE (flagged draft), prompt-design-at-scale, CoVe follow-ups.
- **E4 — Implications mapped to Phase 4** (10 items): contradiction-fix priority, dedup with surviving-location records, MUST/NEVER moderation, brevity-rule audit, negative-constraints-at-end preserved, concrete output contracts, budget as authoring discipline only, rule-count guardrail, DeepSeek V4-Pro deployment notes, whitespace compaction validated.

**Count:** 12 + 4-vendor + 18 + 10 = 44 new findings, all cited. Meets the ≥6 requirement.

## 2. Key validated findings (headline)

| Finding | Source |
|---|---|
| Leaner prompts: +10–15% scores, −41–66% tokens (OpenAI internal coding-agent evals) | E1.1 |
| Contradictions "create more instability than missing detail" | E1.2 |
| Repeated "ask first / do not mutate / wait for approval" rules cause over-asking | E1.3 |
| Claude Code 200-line CLAUDE.md budget + arbitrary conflict resolution confirmed | E1.8 |
| Gemini 2026: negative constraints drop if too early → place at end | E1.10 |
| MiniMax: flat sections (deep nesting hurts), task at end, concrete output contracts | E2.1 |
| Kimi: XML tags explicitly endorsed | E2.2 |
| DeepSeek V4-Pro: no prompt doctrine; temperature silently ignored in thinking mode; prompt text is the lever | E2.3 |
| Even self-evident constraints degrade performance (paradoxical interference) | E3.3 |
| 20 stacked instructions → ~20% follow-rate; merging redundant rules + precedence recovers | E3.5 |
| Models resolve conflicts silently (97.5%); system/user hierarchy unreliable | E3.6–3.7 |
| Essential early instructions survive compression; mid-position rules trigger 56× verbose compensation | E3.11 |
| Compressing semantics kills grounding (~30–50pts); compressing whitespace doesn't | E3.13 |

## 3. Source integrity notes (honest disclosure)

- `ai.google.dev` unfetchable directly (4 transport errors) — content verified via Google's indexed snippets of the official pages; flagged in report.
- `developers.openai.com/api/docs/guides/prompt-guidance` now redirects to the GPT-5.6 guide; prompt-specific content lives at `…/prompt-guidance-gpt-5p6` (fetched).
- DeepSeek: no `/news/` index page (sidebar enumeration, ends 2026-08-13); prompt library is an empty stub; FAQ is JS-gated; Wayback failed (429/404); GitHub repo `deepseek-ai/DeepSeek-V4` does not exist — Hugging Face `deepseek-ai` org used as official channel.
- Moonshot `docs.moonshot.ai` unreachable — equivalent official content from `platform.kimi.ai`/`platform.kimi.com`.
- arXiv verification: 4 central papers double-verified via abstract fetches (2512.17920, 2507.11538, 2601.22047, 2508.07479); 2026 preprints (E3.16 SDE, E3.17) are unreviewed — SDE explicitly flagged as incomplete draft.
- No vendor publishes line/char budgets for rule files (absence reported as a finding); no 2025–2026 paper isolates "duplicate rule text in one system prompt" (gap noted — dedup rationale built from E3.3/E3.5/E3.4).

## 4. Phase 4 input

The E4 implications list (research doc) is the authoritative candidate list for Phase 4 rule refinement. Priority order per E4.1: contradictions first (Phase-1 P0 list), then dedup, then moderation/polish.

## 5. Verification

- Research doc extended and self-consistent (E1–E4 sections, sources list, no uncited claims) ✅
- Every claim carries a URL + date where shown ✅
- ≥6 new findings requirement: 44 ✅
- No repo files changed in this phase (docs only) ✅

**⏸ HITL GATE — present findings summary; await approval for Phase 4.**
