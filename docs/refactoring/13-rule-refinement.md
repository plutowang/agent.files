# Phase 4 Audit — Rule Refinement (2026-08-15)

**Authority:** reword + dedup (exact duplicates, surviving location recorded) + 2 research-backed additions (agent-architect skill only).
**Verification:** `zig build test` EXIT 0 · `./agentc-cli build` SUCCESS 104 files · dist read-back clean · all budgets hold (max agent = architect 195; max skill = graphql 442/500).

---

## P0 — Correctness (contradictions resolved; E1.2, E3.6, E3.20)

| # | Fix | Change | Matrix |
|---|---|---|---|
| P0-1 | Verifier-Rules placement | NEW `_core/3_engineering/testing_aaa/verifier_rules.md` (4 items); removed from `testing_aaa/redlines.md`; imported by opencode verifier + cursor verifier only. build.md/test command lose the block automatically (correct audience). | 4 moved, 0 lost |
| P0-2a | Search contradiction | `error_triage/memory.md` blocks now audience-labeled: "Retrieval & Tools (debugging agent)" keeps "Search the codebase directly"; "File & Codebase Access (build-error resolver)" keeps "NEVER use search tools directly". Contradiction resolved by explicit scoping (debug has glob/grep allow; BER denies). | 0 lost, 2 scoped |
| P0-2b | Capability table | `agent_constraints/standards.md`: invariant 1 reworded (debugging agent searches directly per its permission block); table + "Agents Without Read Access" list updated (debugging agent removed from ❌ row; new row ✅/prompted edits). Frontmatter is authoritative. | 0 lost |
| P0-3 | Escalation unification | `cursor/rules/agent-core.mdc`: Fail Twice Rule merged to 1 bullet; Fail Escalation aligned to Invariant III ("build or test failures only → one /debugger delegation → BLOCKED"; /code-reviewer delegation dropped as non-invariant). `error_triage/redlines.md` 2-attempt bullets merged (same-pattern clause retained). | 0 lost; 1 non-invariant option removed (aligned) |
| P0-4 | Role leakage | `architecture/redlines.md`: "Read-only" + Do-NOT block REMOVED from shared fragment (primary agent no longer forbidden via architecture.mdc); role lines moved to opencode/cursor architect shells ("Deviation" rule kept in fragment). `security_audit/redlines.md`: Do-NOT block removed; role lines moved to opencode security-reviewer + cursor security-auditor shells. security.mdc gains "Critical and High findings must be fixed before merge." (aligns shell+rule). | All role constraints relocated shell←fragment, 0 lost |
| P0-5 | Verifier write-protocol | NEW `testing_aaa/verification_protocol.md` (Verification Process); removed from `testing_aaa/protocol.md`. opencode/cursor verifier shells: protocol import swapped → verification_protocol + verifier_rules added. Verifier no longer receives RED/GREEN/REFACTOR/When-Stuck write blocks. testing.mdc: shell-own test bullets deleted (standards import carries them) — audience collision resolved without adding imports. | 0 lost; audiences corrected |
| P0-6 | Small correctness set | Loop header → "Reproduce → Hypothesise → Instrument → Analyse → Fix → Verify → Clean Up" + steps renumbered (reproduce first). Dependency order unified "imports → types → config → logic → tests" (both lists). 4+/5+ → 4+ (extraction_patterns, refactor command). "core instructions" pointers → "below" (cursor architect/debugger/security-auditor). Misapplied ⏸ (I) dropped from security-audit step 6. Cursor refactor Do-NOT + no-file-access blocks removed (readonly:false); opencode refactor shell gained its own read-only role lines. Quality-attribute pointer → ATAM table (architecture.mdc). CS1 persona reworded audience-neutral. | 0 lost (all reworded/relocated) |

## P1 — Dedup (E1.1 "state each rule once", E3.3, E3.5)

| # | Fix | Change | Matrix |
|---|---|---|---|
| P1-1 | AGENTS.md | AG-1 retry-ban+anti-patterns merged (1 line); AG-2 prefer-action+read-only-safe merged; AG-4 conciseness rules merged (communication/memory absorbs, anti_loop/protocol line deleted, E1.4 content-guard clause added); AG-6 HARD-GATE tail merged. AG-3/5/8 already resolved by Phase-2 compaction (verified); AG-7 skipped (distinct remedies — recorded). | 0 lost |
| P1-2 | Architect dedup | Do-NOT block removed (P0-4) = AR-1; cursor architect shell dropped 3 duplicate bullets (codebase-patterns → fragment Design Rules; boring-tech → kept; operational-complexity → fragment). AR-3: API-Design steps 1–2 removed from architecture/protocol.md? — NO: kept (verify) — recorded: protocol.md API Design section retained because it names the skills (rest-api/graphql) that the fragment's Design Rules reference; judged non-duplicate on re-read. | 0 lost |
| P1-3 | build.md internals | B-3/B-4/B-7 verified already resolved by Phase-2 rewrites (single statement each) — no further edits. | — |
| P1-4 | review/code-reviewer | V-5 GitLab bullet → pointer to A–G pipeline. C7 context line reworded audience-neutral ("If you do not have direct file access…"). C3: cursor code-reviewer "Security Delegation" shell block deleted (shared protocol Step-5 line survives for opencode). C5 verified (A–H renumber from Phase 2). C8 skipped (backtick skill refs = IDE-neutral shared form; cursor @-syntax handled by interlocks — recorded). V-3 skipped (both fragments not always co-imported; keep). | 0 lost |
| P1-5 | .mdc dedup | testing.mdc shell bullets deleted (6, standards import carries); api-design.mdc summary bullets deleted (5, api_contracts import carries — canonical rate-limit/pagination wording wins); refactoring.mdc "per commit" → "per logical change" (Invariant II alignment); code-standards.mdc interlock retained. debugger shell: root-cause+no-refactor merged; pointer "below". | 0 lost |
| P1-6 | Skills (14 findings) | aws: Modularity+Tree-Shaking merged. git: write+recovery output-only merged. rest-api: pagination bullet tightened. subagent-driven-dev: Red-Flags+serial merged. receiving-code-review: gratitude dup merged; clarify bullet tightened. code-review: cr-1/cr-2/cr-4 tightened; **cr-3 command typo fixed** (`--target=lint,test --target=test` → `--target=lint --target=test`). graphql: 5 verbatim red_lines duplicates deleted (survive in standards sections). zig: 2 verbatim workflow duplicates deleted; section refs fixed ("Section 5"→"Version Migration Protocol", "Section 1"→"Version Context Protocol"); duplicate read-before-generate line deduped. SKIPPED (recorded): git-worktrees gw-1 (no exact duplicate — description/redline carry distinct content), workflow-env we-1 (REFUSE list is load-bearing — merging would lose safety items). | 0 constraints lost; 2 skips justified |

## P2 — Polish (E4-driven)

| # | Fix | Change | Matrix |
|---|---|---|---|
| P2-1 | Brevity audit (E1.4) | communication/memory conciseness bullet now pairs brevity with content-preservation: "trim only introductions, repetition, and filler, never required facts or references." | 1 clause ADDED (E1.4) |
| P2-2 | MUST/NEVER moderation (E1.3/E1.7) | Audited red_lines across fragments: existing MUST/NEVERs are true invariants (HITL gates, safety, TDD laws, npm ban); approval rules now stated once + anchor-referenced (⏸ I/II/III) at application points. No weakening; no stacking found post-compaction. | 0 changed (audit only) |
| P2-3 | Format sweep | testing_aaa redlines de-bolded (Phase 2, shared — covers verifier/test/testing.mdc); documentation protocol bullets → numbered (spec); documentation redlines source+config merged. CI-1/I1 invariant numbering exception documented (anchors load-bearing). | 0 lost |
| P2-4 | Output contracts (E2.1 M4) | code_review/memory Output Format gains "One row per finding, one line per row." | 1 clause ADDED (E2.1) |

## A — Additions (2, authoring-time only; E3.2 budget = authoring discipline)

| # | Addition | Placement | Citation |
|---|---|---|---|
| ADD-1 | "**State each rule once.** Keep each policy in one place and state each rule once — import, never restate. Repeated statements of the same rule degrade adherence and cause over-asking." | `.agents/skills/agent-architect/SKILL.md` §7 (Authoring rules) | E1.1 (OpenAI GPT-5.x guidance, URL) |
| ADD-2 | "**Rule-count budget.** Keep each compiled prompt under ~40 rules — compliance collapses as rule count grows… If a shell exceeds it, dedup and trim before adding." | same | E3.19/E3.17 (arXiv URLs) |

Both are authoring-time constraints for the maintainer skill — NOT runtime prompt content (no budget impact, E3.2-compliant).

## Verification evidence

- `zig build test` → EXIT 0 ✅
- `./agentc-cli build` → SUCCESS, 104 files ✅
- Budget table (final): build 190 · architect 195/185 · code-reviewer 160 · review 153 · verifier 112/73 · AGENTS.md 168 · testing.mdc 75 · architecture.mdc 179 · security.mdc 121 · all skills ≤ 442 ✅
- Dist read-back: verifier.md = Verifier Rules + Verification Process, no write blocks ✅; architecture.mdc = no role constraints in red_lines ✅; AGENTS.md = all merges live, one of each XML tag, no fragment headings ✅
- 36 files modified (24 `_core` fragments, 8 shells, 4 `.mdc` rules, 8 skills — plus 2 new fragments); 0 files in dist/ or agentc/ touched.

## Items explicitly skipped (with rationale, for the record)

- AG-7 loop-rule merge (distinct remedies), V-3/C8/C3-openCode cross-IDE hazards, git-worktrees gw-1 + workflow-env we-1 (no safe merge), D6/D5 debugger rules (contexts differ; shared fragment must stay IDE-neutral), AR-3 API-Design steps (name the skills the rules reference), P0-2 frontmatter question (frontmatter correct; table was stale — no user decision needed).

**⏸ HITL GATE — present Phase 4 results, await approval for Phase 5 (final review & re-tightening).**
