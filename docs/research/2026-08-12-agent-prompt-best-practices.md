# Research: 2025–2026 Agent Prompt/Rule Best Practices — Validation of High-Density XML Refactor Approach

**Date:** 2026-08-12
**Question:** Is the proposed high-density refactor (XML semantic tags, pyramid attention layout, imperative MUST/NEVER encoding, word-count budgets) the best-practice approach per 2025–2026 primary sources (Anthropic, OpenAI, Google, IDE docs, academic literature)?

---

## Executive Summary

| Plan element | Verdict | Primary evidence |
|---|---|---|
| XML semantic tags | ✅ **Validated** — recommended by all vendors; safe in every IDE rule format | Anthropic, OpenAI, Google docs (F1) |
| `<pre_flight_check>` at end | ✅ **Strongest-supported element** | Anthropic self-check guidance + Chain-of-Verification (F4) |
| Imperative MUST/NEVER encoding | ⚠️ **Supported with moderation** — positive-first, negatives targeted; never duplicate a rule | OpenAI current guide, Anthropic emphasis docs + over-trigger warning (F3) |
| Red lines at TOP | ⚠️ **Weakest-supported element** — primacy bias is conditional; Anthropic empirically prefers instructions at END | Liu 2023, Veseli 2025, Anthropic long-context post (F2) |
| Word-count budgets (300–500 / 200–400 / 250–450) | ❌ **No official basis** — vendors publish LINE/CHAR budgets, not word counts | Anthropic CLAUDE.md 200 lines, SKILL.md 500 lines, description 1024 chars (F5) |

---

## Findings

### F1 — XML semantic tags: validated by all primary sources

- **Anthropic** (prompting best practices, living doc): "Structure prompts with XML tags — XML tags help Claude parse complex prompts unambiguously, especially when your prompt mixes instructions, context, examples, and variable inputs." Recommends "consistent, descriptive tag names" and nesting. URL: https://platform.claude.com/docs/en/build-with-claude/prompt-engineering/claude-prompting-best-practices
- **Anthropic context engineering** (2025-09-29): "We recommend organizing prompts into distinct sections (like `<background_information>`, `<instructions>`, `## Tool guidance`, `## Output description`, etc) and using techniques like XML tagging or Markdown headers… **although the exact formatting of prompts is likely becoming less important as models become more capable**." URL: https://www.anthropic.com/engineering/effective-context-engineering-for-ai-agents
- **OpenAI** (current guide, fetched 2026-08-12): "XML tags can help delineate where one piece of content begins and ends… Markdown headers and lists can be helpful to mark distinct sections." Canonical developer-message order: Identity → Instructions → Examples → Context. Worked examples use `<user_query>`/`<assistant_response>`. URL: https://platform.openai.com/docs/guides/prompt-engineering
- **Google**: "Use consistent structure: Employ clear delimiters… XML-style tags (e.g., `<context>`, `<task>`) or Markdown headings are effective. Choose one format and use it consistently within a single prompt." URL: https://ai.google.dev/gemini-api/docs/prompting-strategies
- **GitHub** ships XML-tagged content in its own official `copilot-instructions.md` generation template (`<Goals>`, `<Limitations>`, `<WhatToAdd>`, `<StepsToFollow>`). URL: https://docs.github.com/en/copilot/customizing-copilot/adding-repository-custom-instructions-for-github-copilot
- **Academic evidence is mixed but not negative**: "Let Me Speak Freely?" (arXiv:2408.02442): overly restrictive schemas can hinder reasoning-heavy tasks; "Does Prompt Formatting Have Any Impact" (arXiv:2411.10541): GPT-4 is more robust to template variations than GPT-3.5; no controlled head-to-head shows XML > plain text for instruction-following. Verdict: XML is a parseability/reliability engineering choice endorsed by vendors, not a proven accuracy win.
- **IDE format compatibility — XML safe in all target formats**: Cursor `.mdc` (free-form markdown body; frontmatter `description`/`globs`/`alwaysApply`; "Keep rules under 500 lines" advisory) — https://cursor.com/docs/rules.md; Cursor agents (YAML frontmatter + free-form body) — https://cursor.com/docs/subagents.md; GitHub Copilot (all three formats, no byte cap documented, "natural language… in Markdown") — https://docs.github.com/en/copilot/concepts/prompting/response-customization; OpenCode AGENTS.md/agents/commands/skills (free-form bodies) — https://opencode.ai/docs/rules/, /docs/agents/, /docs/skills/; agents.md community spec ("no required fields… just standard Markdown") — https://agents.md
- **⚠️ Only structural constraints found:**
  - **Skill frontmatter BANS XML**: Anthropic skill `name` (≤64 chars) and `description` (≤1024 chars) "Cannot contain XML tags"; description must be third-person, "what it does + when to use it" — https://platform.claude.com/docs/en/agents-and-tools/agent-skills/overview. OpenCode skill name regex `^[a-z0-9]+(-[a-z0-9]+)*$` — https://opencode.ai/docs/skills/. → **XML tags in BODY only, never frontmatter.**
  - **OpenAI Codex**: combined AGENTS.md payload hard-capped at 32 KiB (`project_doc_max_bytes`) — content past cap silently dropped. Only relevant if a Codex target is added — https://learn.chatgpt.com/codex/agent-configuration/agents-md

### F2 — Pyramid layout / position effects: partially supported, primacy is fragile

- **Lost in the Middle** (Liu et al., 2023; arXiv:2307.03172, TACL 2024): U-shaped performance for **information retrieval** in long contexts — "performance is often highest when relevant information occurs at the beginning or end of the input context." Scope caveat: this is a *retrieval* finding, not an instruction-following finding. GPT-4 still showed the U-shape.
- **Found in the Middle** (Hsieh et al., 2024; arXiv:2406.16008): U-shape is intrinsic to attention — "tokens at the beginning and at the end of its input receive higher attention, regardless of their relevance."
- **⚠️ U-shape is conditional** (Veseli et al., 2025; arXiv:2508.07479): "the LiM effect is strongest when inputs occupy up to 50% of a model's context window. Beyond that, the primacy bias weakens, while recency bias remains relatively stable… we observe a distance-based bias, where model performance is better when relevant information is closer to the end." At full length: last > middle > first.
- **Newer models are more position-robust**: LongPiBench (arXiv:2410.14641): "most current models are robust against the 'lost in the middle' issue" (new spacing-based biases instead). Counting-Stars (arXiv:2403.11802): "cannot strongly corroborate the lost-in-the-middle phenomenon."
- **Anthropic's empirical position is the OPPOSITE for instructions**: "it does emphasize the importance of putting the instructions at the end of the prompt, as we want Claude's recall of them to be as high as possible" (long-context prompting post — https://www.anthropic.com/news/prompting-long-context). Also: "Put longform data at the top… Queries at the end can improve response quality by up to 30 percent" (prompting best practices). Claude Code memory doc: rule files load at the END of startup context (https://code.claude.com/docs/en/memory).
- **Google is the sole vendor supporting constraints-first**: "Place essential behavioral constraints, role definitions (persona), and output format requirements in the System Instruction or at the very beginning" — https://ai.google.dev/gemini-api/docs/prompting-strategies
- **Verdict**: top-placement of red lines is contested (Google: top; Anthropic: end). The safest engineering compromise: red lines at top (Google + primacy for short prompts) AND `<pre_flight_check>` at end re-anchoring them one-line each (recency zone + Anthropic self-check guidance). No study validates the full pyramid as a whole — treat as a heuristic consistent with the evidence.

### F3 — Imperative encoding / negative constraints: supported with moderation

- **OpenAI current guide explicitly asks for negatives**: "What should the model do, and what should the model never do?" — URL: https://platform.openai.com/docs/guides/prompt-engineering. Legacy "say what to do instead of what not to do" survives only in the Help Center article (https://help.openai.com/en/articles/6654000-prompt-engineering-best-practices-for-chatgpt) — recommends *pairing* negatives with positive alternatives.
- **Anthropic**: MUST/emphasis officially endorsed — "You can tune instructions by adding emphasis (e.g., 'IMPORTANT' or 'YOU MUST') to improve adherence" (https://code.claude.com/docs/en/best-practices); skills docs endorse "stronger language such as 'MUST filter' instead of 'always filter'" (https://platform.claude.com/docs/en/agents-and-tools/agent-skills/best-practices).
- **⚠️ Moderation warnings**:
  - Anthropic: "**Tell Claude what to do instead of what not to do**… Instead of: 'Do not use markdown in your response' Try: 'Your response should be composed of smoothly flowing prose paragraphs.'" Bare prohibitions are weaker than explained ones ("NEVER use ellipses" < "never use ellipses since the text-to-speech engine will not know how to pronounce them").
  - Anthropic (Opus 4.5/4.6+): "If your prompts were designed to reduce undertriggering… these models may now overtrigger. The fix is to dial back any aggressive language. Where you might have said 'CRITICAL: You MUST use this tool when…', you can use more normal prompting."
  - OpenAI: "**State each instruction once**" — never encode the same rule as both a MUST and a NEVER (https://developers.openai.com/api/docs/guides/prompt-guidance).
- **Verdict**: imperative encoding validated; MUST/NEVER reserved for true invariants; positive primary directives; negatives targeted at specific failure modes, ideally with a reason; no duplicated rules.

### F4 — Self-verification loop at end: strongest-supported element

- **Anthropic**: "Ask Claude to self-check. Append something like 'Before you finish, verify your answer against [test criteria]'" — https://platform.claude.com/docs/en/build-with-claude/prompt-engineering/claude-prompting-best-practices
- **Chain-of-Verification** (Dhuliawala et al., Meta; arXiv:2309.11495): FACTSCORE +28%, MultiSpanQA +23% F1. Caveat: gains come from *structured independent* verification, not a naive "double-check yourself" suffix.
- **⚠️ Model-specific caveat**: "Claude Opus 5 is the exception: it verifies its own work well without explicit instruction, and verification instructions carried over from prompts tuned for earlier models can cause over-verification, adding tokens and latency." → keep `<pre_flight_check>` lean; note this for model-tuned outputs.
- Claude Code: "Give Claude a check it can run… Have Claude show evidence rather than asserting success" (https://code.claude.com/docs/en/best-practices).

### F5 — Length budgets: vendors publish line/char budgets, NOT word counts

| Source | Budget |
|---|---|
| CLAUDE.md | "target under **200 lines** per CLAUDE.md file. Longer files consume more context and reduce adherence" — https://code.claude.com/docs/en/memory |
| SKILL.md body | "Keep SKILL.md body under **500 lines** for optimal performance" — https://platform.claude.com/docs/en/agents-and-tools/agent-skills/best-practices |
| Skill description | ≤ **1,024 characters** (API spec); Claude Code truncates description+when_to_use at **1,536 chars** — https://code.claude.com/docs/en/agents-and-tools/agent-skills/overview, https://code.claude.com/docs/en/skills |
| Skill name | ≤ **64 characters** — agent-skills/best-practices |
| Cursor .mdc | "Keep rules under **500 lines**" (advisory) — https://cursor.com/docs/rules.md |
| Copilot | no byte cap documented; instruction-generation template says "no longer than 2 pages" — docs.github.com (see F1) |

- **Anthropic on bloated rules**: "Bloated CLAUDE.md files cause Claude to ignore your actual instructions!… The over-specified CLAUDE.md… Claude ignores half of it because important rules get lost in the noise. **Fix**: Ruthlessly prune." (https://code.claude.com/docs/en/best-practices)
- **Minimal-context principle**: "striving for the minimal set of information that fully outlines your expected behavior. (Note that minimal does not necessarily mean short…)" (https://www.anthropic.com/engineering/effective-context-engineering-for-ai-agents)
- **OpenAI leaner-prompts data**: "configurations with leaner system prompts improved evaluation scores by roughly 10–15% while reducing total tokens by 41–66%" (https://developers.openai.com/api/docs/guides/prompt-guidance)
- **Google Gemini 3**: "Be concise in your input prompts… It may over-analyze verbose or overly complex prompt engineering techniques used for older models" (https://ai.google.dev/gemini-api/docs/generate-content/gemini-3)

### F6 — Rules-file structure (CLAUDE.md convention)

- "There's no required format for CLAUDE.md files, but keep it short and human-readable"; "use markdown headers and bullets to group related instructions" — https://code.claude.com/docs/en/best-practices, https://code.claude.com/docs/en/memory. XML tagging is documented for API prompts; markdown is the documented rules-file format. Nothing forbids XML in rules bodies.
- Import mechanics validated: CLAUDE.md imports via `@path` (max depth 4); `.claude/rules/` path-scoped rules; skills for on-demand knowledge ("CLAUDE.md is loaded every session, so only include things that apply broadly") — mirrors the AUPC `<!-- @import -->` architecture.
- Anthropic skills progressive disclosure (3 levels: metadata ~100 tokens → instructions <5k tokens on trigger → reference files one level deep, ToC for >100-line references) — https://www.anthropic.com/engineering/equipping-agents-for-the-real-world-with-agent-skills, https://platform.claude.com/docs/en/agents-and-tools/agent-skills/overview

---

## Implications for the Refactor Plan (recommended changes)

1. **Keep XML semantic tags** (validated). Add explicit rule: **tags appear in BODY only — never in YAML frontmatter** (skill `name`/`description` ban XML; opencode name regex).
2. **Replace word budgets with line/char budgets grounded in official numbers**: CLAUDE.md/AGENTS.md < 200 lines; skill body < 500 lines; skill description ≤ 1,024 chars (target ≤ 1,536 combined listing); cursor .mdc < 500 lines. Word-count budgets downgraded to secondary heuristics.
3. **Moderate imperative encoding**: positive-first directives; MUST/NEVER reserved for true invariants (red lines); negatives targeted with reasons where possible; **never state the same rule twice**.
4. **Refine pyramid**: keep `<red_lines>` at top (Google + primacy for short prompts), but `<pre_flight_check>` at end re-anchors each red line in one line (Anthropic end-placement + self-check). Keep `<pre_flight_check>` lean (Opus 5 over-verification caveat).
5. **Verify per-phase against the line budgets** instead of word counts.
6. **Note Codex 32 KiB cap** if a Codex target is ever added to the compiler.
7. All other plan elements (import chains, Lexical Ban, permission alignment, dist hygiene, phased gates) are unaffected and remain.

---

## Sources

**Vendor docs**
- https://platform.claude.com/docs/en/build-with-claude/prompt-engineering/claude-prompting-best-practices (Anthropic, living)
- https://www.anthropic.com/engineering/effective-context-engineering-for-ai-agents (Anthropic, 2025-09-29)
- https://code.claude.com/docs/en/memory · /docs/en/best-practices · /docs/en/skills (Claude Code docs, 2026-era)
- https://platform.claude.com/docs/en/agents-and-tools/agent-skills/overview · /best-practices (Agent Skills)
- https://www.anthropic.com/engineering/equipping-agents-for-the-real-world-with-agent-skills (2025-10-16, upd. 2025-12-18)
- https://www.anthropic.com/news/prompting-long-context
- https://platform.openai.com/docs/guides/prompt-engineering (current, 2026-08)
- https://developers.openai.com/api/docs/guides/prompt-guidance
- https://help.openai.com/en/articles/6654000-prompt-engineering-best-practices-for-chatgpt (legacy)
- https://openai.com/business/guides-and-resources/a-practical-guide-to-building-ai-agents/
- https://developers.openai.com/cookbook/examples/gpt-5/gpt-5-2_prompting_guide · /gpt-5-1_prompting_guide · /realtime_prompting_guide
- https://ai.google.dev/gemini-api/docs/prompting-strategies · /generate-content/gemini-3
- https://cloud.google.com/vertex-ai/generative-ai/docs/learn/prompts/system-instruction-introduction

**IDE formats**
- https://cursor.com/docs/rules.md · https://cursor.com/docs/subagents.md
- https://docs.github.com/en/copilot/customizing-copilot/adding-repository-custom-instructions-for-github-copilot · https://docs.github.com/en/copilot/concepts/prompting/response-customization
- https://opencode.ai/docs/rules/ · /agents/ · /commands/ · /skills/
- https://learn.chatgpt.com/codex/agent-configuration/agents-md
- https://agents.md (AGENTS.md spec, Agentic AI Foundation)

**Academic**
- Liu et al., Lost in the Middle — arXiv:2307.03172 (TACL 2024)
- Hsieh et al., Found in the Middle — arXiv:2406.16008
- Veseli et al., Positional Biases Shift as Inputs Approach Context Window Limits — arXiv:2508.07479
- LongPiBench — arXiv:2410.14641 (ACL Findings 2025)
- Counting-Stars — arXiv:2403.11802
- Dhuliawala et al., Chain-of-Verification — arXiv:2309.11495 (ACL Findings 2024)
- Format Restrictions — arXiv:2408.02442; Prompt Formatting — arXiv:2411.10541; XML Prompting — arXiv:2509.08182
- Chroma Context Rot — https://research.trychroma.com/context-rot (cited by Anthropic)

**Access notes:** OpenAI agents-guide PDF (>5MB) verified via official web page; google prompting-strategies verified via live-crawl mirror; Anthropic "system prompts"/"structuring prompts" pages merged into claude-prompting-best-practices.

---

## Extension — 2026-08-15 (wording-optimization session, Phase 3)

### E1 — Vendor doc updates (Anthropic / OpenAI / Google, re-verified 2026-08-15)

| # | Finding | Source | Relevance |
|---|---|---|---|
| E1.1 | OpenAI (GPT-5.6 era): "configurations with leaner system prompts improved evaluation scores by roughly **10–15%** while reducing total tokens by **41–66%** and cost by **33–67%**" (verified verbatim 2026-08-15); "**Keep the policy in one place and state each rule once.**" | https://developers.openai.com/api/docs/guides/prompt-guidance-gpt-5p6 | Quantitative backing for ≤200-line budgets and dedup |
| E1.2 | OpenAI: "conflicting rules can create **more instability than missing detail**" | same | Contradiction-fixing outranks adding rules — validates Phase 1 P0 list |
| E1.3 | OpenAI: use ALWAYS/NEVER/MUST "only for true invariants"; "Repeating instructions such as 'ask first', 'do not mutate', or 'wait for approval' **can cause unnecessary approval requests**" | same | MUST/NEVER moderation + avoid repeating approval rules across sections |
| E1.4 | OpenAI: "check whether broad brevity instructions such as "Be concise" or "Keep it short" are still useful… **can sometimes make responses too brief**" — prefer specifying what a short answer must include | same | Audit "be concise" phrasings → pair with content-preservation rules |
| E1.5 | OpenAI suggested system-prompt sections: Role/Personality/Goal/Success criteria/Constraints/Tools/Output/Stop rules — "Keep each section short. **Add detail only where it changes behavior**." | same | External cross-check of our pyramid; pruning test |
| E1.6 | Anthropic: "Queries at the end can improve response quality by **up to 30 percent**" | https://platform.claude.com/docs/en/build-with-claude/prompt-engineering/claude-prompting-best-practices | Task-at-end; preflight re-anchoring validated again |
| E1.7 | Anthropic Opus 4.8 "interprets prompts **literally and explicitly**… it does not silently generalize an instruction… **state the scope explicitly**"; Opus 4.5/4.6: "dial back any aggressive language" | same + prompting-claude-opus-4-8 | Scope-explicit wording; moderate CRITICAL/MUST density |
| E1.8 | Claude Code: "target **under 200 lines** per CLAUDE.md file"; "if two rules contradict each other, **Claude may pick one arbitrarily**"; pruning test: "Would removing this cause Claude to make mistakes? If not, cut it." | https://code.claude.com/docs/en/memory · /best-practices | Direct vendor backing for the 200-line budget, contradiction audits, pruning litmus test |
| E1.9 | Gemini 3: "Be concise in your input prompts… It may **over-analyze verbose** or overly complex prompt engineering"; "Avoid unnecessary or overly persuasive language." | https://ai.google.dev/gemini-api/docs/gemini-3 | Third-vendor corroboration of aggressive trimming |
| E1.10 | Gemini 3 (2026-06-10 prompting strategies + **Gemini 3 prompting guide, Google Cloud Enterprise Agent Platform** — source-corrected 2026-08-15: the sentence lives in the Cloud guide + Google's official `intro_prompt_design.ipynb`, NOT on ai.google.dev): "the model may **drop negative constraints… if they appear too early**… place your core request and most critical restrictions as the **final line**… **negative constraints should be placed at the end**" — with the older "essential behavioral constraints… at the very beginning" | https://docs.cloud.google.com/gemini-enterprise-agent-platform/models/start/gemini-3-prompting-guide · https://github.com/GoogleCloudPlatform/generative-ai/blob/main/gemini/prompts/intro_prompt_design.ipynb · https://ai.google.dev/gemini-api/docs/prompting-strategies | Nuance for pyramid: positive/goal content early, NEVER-style negatives re-anchored at end (= our preflight pattern) |
| E1.11 | Anthropic: "the exact formatting of prompts is likely **becoming less important**"; "striving for the **minimal set of information**… minimal does not necessarily mean short" | https://www.anthropic.com/engineering/effective-context-engineering-for-ai-agents | Content curation > format dialect (weighs on XML-vs-markdown) |
| E1.12 | agents.md spec / Codex: closest-file-wins precedence; Codex concatenates root→cwd, hard cap **32 KiB** | https://agents.md · https://developers.openai.com/codex/guides/agents-md | Concrete ceiling if a Codex target is added |

### E2 — Chinese vendor official docs (DeepSeek / MiniMax / Moonshot Kimi / Qwen)

| # | Vendor | Finding | Source |
|---|---|---|---|
| E2.1 | **MiniMax** | Flat labeled sections (Task/Context/Source/Constraints/Output) — "**Keep the structure flat; deep nesting hurts readability**"; "For long inputs, write your question or task **after** the source documents… largest single impact on answer quality"; "**Boundaries before generation** — state allowed sources/time range/version before the task"; "Avoid vague asks like 'be detailed'… Prefer **concrete output contracts** — section names, table columns, bullet limits"; "When you explain **why** a constraint matters, the model can choose better tradeoffs"; keep system prompts concise in compression tools (early task termination risk) | https://platform.minimax.io/docs/token-plan/prompting-best-practices.md |
| E2.2 | **Moonshot Kimi** | **XML tags explicitly endorsed**: "delimiters… such as triple quotes/**XML tags**/section headings"; length budgets in words are "not highly precise" — "better at… **number of paragraphs or bullet points**"; system prompt: "The less the model has to guess about your needs, the more likely you are to get satisfactory results"; K2 recommended `temperature = 0.6`; K3 fixed `temperature=1.0, top_p=0.95` (don't pass) | https://platform.kimi.ai/docs/guide/prompt-best-practice · https://github.com/MoonshotAI/Kimi-K2 · https://platform.kimi.com/docs/guide/kimi-k3-quickstart.md |
| E2.3 | **DeepSeek (V4-Pro, GA 2026-08-13)** | **No prompt-engineering doctrine published** (prompt library is an empty stub; FAQ is JS-gated). V4-Pro: 1M context, 384K max output, `reasoning_effort` low/high/max (**default high, thinking on by default**); `temperature`/`top_p`/penalties "**will not trigger an error but will also have no effect**" in thinking mode (verified verbatim 2026-08-15) → instruction control comes from prompt text + effort level. JSON mode: prompt must contain the word "json" + an example; empty-content bug workaround = "modify the prompt". Tool calls: `arguments` "may hallucinate parameters not defined by your function schema. **Validate the arguments in your code**" (source-corrected: Chat Completions API reference, not guides/tool_calls); `reasoning_content` must be passed back or API 400s. Local sampling rec: `temperature=1.0`, `top_p=0.95` agentic. **Changelog verified: newest article 2026-08-13, none newer (checked 2026-08-15).** | https://api-docs.deepseek.com/news/news260813 · /updates · /guides/thinking_mode · /guides/json_mode · /api/create-chat-completion · /quick_start/pricing · https://huggingface.co/deepseek-ai/DeepSeek-V4-Pro-0813 |
| E2.4 | **Qwen/Alibaba** | Delimiter-based sections ("unique character combinations… `###`, `===`, `>>>`"); "Output examples… are the most effective way to prevent model hallucinations"; system message "optional but recommended"; Qwen3+ has no default system message; official tool template itself uses `<tools>`/`<tool_call>` **XML tags**; temperature 0.1 recommended for deterministic/code tasks | https://www.alibabacloud.com/help/en/model-studio/prompt-engineering-guide (2026-05-13) · https://qwen.readthedocs.io/en/latest/getting_started/concepts.html |

**Note (absence is a finding):** none of the four vendors publishes a line/char budget for rule files; the ≤200-line cap remains our own discipline, uncontradicted and loosely supported (MiniMax E2.1, OpenAI E1.1).

### E3 — Academic 2025–2026

| # | Paper (arXiv) | Finding | Applicability |
|---|---|---|---|
| E3.1 | CDCT — 2512.17920 (Dec 2025) | Constraint-compliance failures **peak at medium prompt lengths** ("instruction ambiguity zone"); best at 2–3 words AND 135+ words | "State fully or cut decisively" — no half-trimmed rules |
| E3.2 | LIFT — 2406.17744, EMNLP 2025 main | Length constraints among the **weakest-followed** constraint types (~50% violation) | Budget = authoring-time discipline, NOT a model instruction. Don't add "keep under 200 lines" as a rule for the model |
| E3.3 | Paradoxical Interference — 2601.22047 (Jan 2026) | Adding even **self-evident constraints** (extracted from the model's own output) degrades task performance | Every extra rule taxes performance → dedup/trim is quality work, not cosmetics |
| E3.4 | Underspecification — 2505.13360 (May 2025) | Accuracy drops ~19% as requirements multiply (19 reqs, GPT-4o); a Bayesian optimizer found prompts **43% shorter with +3.8% accuracy** | Fewer, well-chosen rules beat exhaustive lists |
| E3.5 | Instruction Stacking Collapse — 2608.02639 (Aug 2026) | Stacking 1→20 instructions drops follow-rate ~96%→20%; training-free compiler that **merges redundant rules + adds precedence** recovers +11pp (weak models) | Dedup + explicit precedence are the fixes; strongest support for our Phase-4 dedup work |
| E3.6 | ConInstruct — 2511.14342 (Nov 2025) | Models detect conflicts well (F1 91.5%) but "rarely explicitly notify users"; GPT-4o resolves 97.5% of conflict cases **silently** | Static conflict linting at authoring time — never trust the model to reconcile |
| E3.7 | Control Illusion — 2502.15851, AAAI 2026 | System/user prompt separation "fails to establish a reliable instruction hierarchy" | Resolve conflicts in text; placement alone isn't precedence |
| E3.8 | IFScale — 2507.11538 (Jul 2025) | Best models hit 68% at 500 instructions; primacy bias **saturates ~150–200 instructions**; omission errors dominate under load | Keep rule counts far below saturation; fewer non-redundant rules |
| E3.9 | Constraint position — 2601.18554 (Jan 2026) | Position effects **model-family-specific**: Llama/Qwen/DeepSeek primacy; Claude/Gemini recency (spike at idx 19, collapse at 20) | "Early is best" is an approximation; end-of-prompt re-anchoring (preflight) is the hedge |
| E3.10 | LiM theory — 2603.10123 (Mar 2026); failed repro — 2605.27105 (SIGIR 2026) | U-shape proven **at initialization** (inherent geometry); but a controlled reproduction fails to recover it — position bias is real yet **model-/setup-dependent** | Keep pyramid (edges-first) as structural default, not a guarantee |
| E3.11 | Instruction Survival Ψ — 2603.23527 (Mar 2026) | Under compression, "**essential task specifications that appear early survive**; mid-positioned instructions trigger verbose compensation (up to 56× output expansion)" | Hard constraints early (= red_lines at top) survive budget pruning |
| E3.12 | Compression RCT — 2603.23525 (Mar 2026) | Moderate compression (r=0.5) cut cost 27.9%; aggressive (r=0.2) **increased** cost | ≤200-line budget is a moderate cap — correct scale |
| E3.13 | Compression×Grounding — 2503.19114, EMNLP 2025 Findings | Compression that drops key details cuts grounding ~30–50 pts | Never compress rule **semantics** — only formatting (validates our whitespace-only compaction) |
| E3.14 | CAVEWOMAN — 2606.24083 (Jun 2026) | Input compression can trigger **longer outputs** (1.15–1.8×) as accuracy collapses | Terse prompts aren't cost-neutral; avoid over-truncating |
| E3.15 | Prompt Repetition — 2512.14982 (Dec 2025) | Repeating the ENTIRE prompt improves accuracy (47 wins/0 losses) — an **attention-coverage** effect | Not a license for duplicate rule text inside a prompt (E3.3 says that hurts) |
| E3.16 | SDE — 2604.17659 (Apr 2026, ⚠️ incomplete draft) | Higher information-per-token prompts beat diluted ones +8.4pp | Density heuristic; cite cautiously |
| E3.17 | Prompt Design at Scale — 2607.19257 (Jul 2026) | Perfect-response rate → 0 by N=80 rules regardless of format; "**no model shows a reliable markdown advantage**" | Keep rule counts « 80 per prompt; format isn't a magic lever |
| E3.18 | CoVe follow-ups — 2606.21724 DISC (Jun 2026); 2606.23196 | DISC beats CoVe on precision-recall; intrinsic self-correction helps only **verifiable** tasks | Preflight re-anchoring: keep it verification-shaped (checklists), not "double-check yourself" prose |
| E3.19 | **Phase Transitions in Compositional Constraint Satisfaction — 2608.12426 (Aug 12, 2026, NEW in verification sweep)** | "probe-level success falls below 50% at **7 constraints** for the strongest model, and at 3 or fewer for 12 of 15" models; structural constraints degrade 2× faster than lexical; **no inference-time fix** (planning, self-correction, best-of-5) moves the threshold | Hardest constraint-capacity datapoint yet: per-prompt rule counts must stay in single digits where possible |
| E3.20 | **Harness-IF — 2608.11727 (Aug 12, 2026, NEW in verification sweep)** | Aggregate instruction-following scores overstate compliance (AP-Acc 66.1–78.6% vs 72.1–85.9%); for conflicting rules, "**pooled precedence does not follow prompt depth**" | Placement alone is not precedence — conflicts must be resolved in text (reinforces E3.7/E4.1) |

**Verification provenance (2026-08-15, research-skill pass):** all 9 load-bearing arXiv IDs re-fetched and confirmed live (no hallucinated citations); E1.1–E1.8, E1.10, E2.1, E2.3 quotes re-verified verbatim against the pages themselves (4 wording corrections applied: E1.1 "state each rule once" exact phrasing, E1.4 exact OpenAI wording, E1.10 source = Google Cloud guide + official notebook, E2.3 "no effect" + tool-call URL). Underspecification figure corrected to "41–45% token reduction" (body, not abstract). Newest-content sweep (2026-08-10→15): OpenAI Aug 13 = Ultrafast service tier (not prompting); Anthropic Aug 14 = watermark post (not prompting); DeepSeek changelog ends 2026-08-13; MiniMax/Kimi no post-08-10 prompt updates. No finding changed direction; confidence now HIGH on E1.1–E1.10, E2.1–E2.3, E3.1–E3.13, E3.15, E3.17–E3.20; E3.14/E3.16 remain single-source drafts (flagged).

### E4 — Implications applied in Phase 4 (mapping)

1. **Contradictions first (P0)** — E1.2, E3.5–3.7: apply the Phase-1 P0 fix list (Verifier-Rules placement, search rule, escalation unification, role leakage, 4+/5+, loop order) before any wording polish.
2. **Dedup with surviving-location records** — E1.1 ("state each instruction once"), E3.3–3.5: merge exact duplicates; keep the single strongest statement; matrix row shows the surviving location.
3. **MUST/NEVER moderation** — E1.3, E1.7: audit red_lines for over-aggressive language; keep MUST/NEVER for true invariants; add explicit scope ("every section, not just the first").
4. **"Be concise" audit** — E1.4, E2.1: pair brevity rules with content-preservation ("keep all required facts; trim introductions and repetition") instead of bare "be concise".
5. **Negative constraints at end** — E1.10, E2.1 (M3): keep red_lines at top (survive compression, E3.11) AND the preflight re-anchoring at end (recency models) — the existing pyramid already does both; preserve it.
6. **Concrete output contracts** — E2.1 (M4), E1.5: prefer "Report: file:line + severity + verdict" over "be thorough but concise" alone; already largely in place (review output table, report templates).
7. **Budget as authoring discipline only** — E3.2, E3.12: never state the line budget as a model rule; 200-line cap stays an authoring-time gate.
8. **Rule-count guardrail** — E3.8, E3.17: per-prompt rule counts far below saturation; current files ≤ ~60 rules — within bounds.
9. **DeepSeek V4-Pro as deployment target** (also the model running this repo's own sessions): no prompt doctrine to follow; thinking mode default (temperature silently ignored) → prompt text is the only lever; JSON mode needs the literal word "json" + example if ever used; tool-call args must be validated in code. No repo changes required; noted for agentc targets.
10. **Whitespace compaction validated** — E3.13: compressing semantics hurts, compressing whitespace doesn't; Phase-2's compaction is the safe direction.