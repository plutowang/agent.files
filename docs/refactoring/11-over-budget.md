# Phase 2 Audit — Over-Budget Tightening (2026-08-15)

**Strategy:** no lazy-load (user-confirmed twice); wording condensation + whitespace compaction at fragment sources. All edits zero-loss with IN==OUT matrices.
**Status:** ✅ **ALL 5 TARGETS ≤ 200 LINES** — conflict resolved WITHOUT lazy-load (user goal: fewer lines sent to models).

---

## 1. Final line-count results

| dist file | Before | After | Budget | Status |
|---|---|---|---|---|
| opencode/agents/build.md | 304 | **199** | 200 | ✅ (−105, 35%) |
| cursor/agents/code-reviewer.md | 263 | **162** | 200 | ✅ (−101, 38%) |
| opencode/commands/review.md | 253 | **152** | 200 | ✅ (−101, 40%) |
| opencode/agents/architect.md | 213 | **199** | 200 | ✅ (−14) |
| cursor/agents/architect.md | 207 | **193** | 200 | ✅ (−14) |
| cursor/rules/architecture.mdc | 199 | **185** | 200 | ✅ (watch) |
| All other compiled agents/commands | ≤ 154 | — | 200 | ✅ (design 154, security-reviewer 143, debug 136…) |

`zig build test` EXIT 0 · `./agentc-cli build` SUCCESS 104 files · dist read-back clean (one of each XML tag per shell, no fragment headings, no internal path refs).

## 2. The deciding lever (round 3) — whitespace compaction

Rounds 1–2 (content condensation, matrices in §2.1–2.12) reached 258/231/234 — at the zero-loss content floor. Round 3 compacted **blank-line padding** in fragments and shells (whitespace-only, zero content change) — ~30% of `wc -l` was blank lines. Round 4 applied the final line-merges (related bullets joined per line). All content intact — audit §2.13.

### 2.13 Round 3–4 edit inventory (all IN == OUT)
| File | Edit | Items IN → OUT |
|---|---|---|
| code_standards/standards.md | blank stripping; Naming 2→1 line | 33 → 33 |
| code_standards/redlines.md | blank stripping; 4 bullets → 2 lines | 4 → 4 |
| testing_aaa/standards.md | blank stripping; Test Structure 3→2 lines | 11 → 11 |
| testing_aaa/protocol.md | blank stripping | 18 → 18 |
| testing_aaa/redlines.md | blank stripping; Anti-Patterns 4→2 lines | 26 → 26 |
| testing_aaa/preflight.md | 5 checkboxes → 4 lines (2 joined) | 5 → 5 |
| feature_dev_build/protocol.md | blank stripping | 20 → 20 |
| feature_dev_build/redlines.md | 7 bullets → 5 lines (2 pairs joined) | 7 → 7 |
| feature_dev_build/memory.md | 6 bullets → 5 lines (imports+test-suite joined) | 6 → 6 |
| review/protocol.md | blank stripping | all steps/axes → same |
| gitlab_context/protocol.md | blank stripping; metadata line fixed (V-1); Step 8/H deleted (V-4 — fallback stated at Step 2 + Detection); inner steps renumbered A–G (V-8/C5); bash fence inlined (2 saved) | all → same |
| code_review/redlines.md | blank stripping | 5 → 5 |
| code_review/memory.md | blank stripping | all → same |
| review/redlines.md | C1 guardrail tightened, "(build, design)" IDE-names removed (neutrality) | 1 → 1 |
| opencode/agents/build.md (shell) | blank stripping inside sections | — |
| opencode/commands/review.md (shell) | blank stripping; $ARGUMENTS lines merged | — |
| cursor/agents/code-reviewer.md (shell) | blank stripping; C2 dup sentence deleted | — |

**Zero-loss proof:** every join retains all clauses; every deletion has a surviving statement located in the matrix (Step 8 fallback → Step 2 Otherwise + Detection line; C2 → red_lines guardrail).

## 3. Resolution note (replaces conflict report)

The previous conflict report (§5) is **resolved**: the ≤200 target was achieved without lazy-load via whitespace compaction + line-joining. Frontmatter permission blocks remain byte-identical. No constraints were dropped.

## 4. Remaining items carried to Phase 4 (recorded, not lost)

- B-2: "Verifier Rules" still appears in build.md red_lines (read-only text in a write-capable agent) — Phase 4 P0 fix (fragment split).
- B-5/B-7, V-3, C3/C7 dedup items — Phase 4.
- Escape hatch no longer needed for Phase 2.


## Appendix A — Detailed edit matrices (rounds 1–2; constraint counts, not final line counts)

### 2.1 `_core/3_engineering/code_standards/standards.md` — 57 → 40 → 26 lines (rounds 1–3)
Constraint inventory IN: Type Safety 3, Error Handling 4, Defensive 3, Naming 3, Control Flow 4, Function Design 3, Critical Thinking 6, Red Flags 7 = **33**.

| # | Change | Constraints IN → OUT | Status |
|---|---|---|---|
| 1 | Type Safety: bullets 1+2 merged (strictest system, no any/suppression/conversions; narrow-over-broad with union/enum/branded + language qualifier) | 2 → 1 line, 2 items | ✅ |
| 2 | Type Safety: bullet 3 unchanged | 1 → 1 | ✅ |
| 3 | Error Handling: bullets 1+2 merged (never suppress; handle/propagate/acknowledge; no unwrap/bare throw/empty catch) | 2 → 1 line, 2 items | ✅ |
| 4 | Error Handling: bullets 3+4 merged (layer-boundary context; typed error systems) | 2 → 1 line, 2 items | ✅ |
| 5 | Defensive Coding: 3 bullets → 1 line (boundary validation; malformed-data assumption; immutability default + explicit mutation) | 3 → 1 line, 3 items | ✅ |
| 6 | Naming: bullets 1+3 merged; bullet 2 kept | 3 → 2 lines, 3 items | ✅ |
| 7 | Control Flow: 4 bullets → 2 lines (depth-3 + guard clauses; loops continue/break + helper decomposition) | 4 → 2 lines, 4 items | ✅ |
| 8 | Function Design: 3 bullets → 2 lines | 3 → 2 lines, 3 items | ✅ |
| 9 | Critical Thinking: 6 items, label text tightened | 6 → 6 | ✅ |
| 10 | Red Flags: 7 items unchanged | 7 → 7 | ✅ |

**Total: 33 IN → 33 OUT ✅**

### 2.2 `_core/3_engineering/testing_aaa/standards.md` — 22 → 16 lines
Inventory: Philosophy 4, Structure 3, Coverage 3, Table-Driven 1 = **11**. Merges: Philosophy bullets 2+3; Coverage bullets 2+3. **11 → 11 ✅**

### 2.3 `_core/3_engineering/testing_aaa/protocol.md` — 40 → 24 lines
Inventory: RED 2, GREEN 1, REFACTOR 1, Order Matters 1, When Stuck 4, When to Write Tests 4, Verification 5 = **18**.
- RED/GREEN/REFACTOR 3 blocks → 3 one-line bullets (all clauses retained). When Stuck table → 4 one-line bullets (all 4 problem/solution pairs). Verification: 5 steps → 3 lines (steps 1+2 and 3+4 line-merged; step 5 own line). **18 → 18 ✅**

### 2.4 `_core/3_engineering/testing_aaa/redlines.md` — 38 → 24 lines
Inventory: Iron Laws 2 (bold, exempt), Red Flags 6, Rationalizations 10, Anti-Patterns 4, Verifier Rules 4 = **26**.
- Red Flags: deleted ""Keep this code as reference" while writing tests" (survives via Rationalizations "Keep it as reference" line) → 6 → 5. Bold prefix removed from Red Flags label (format spec).
- Rationalizations: 3 near-duplicate pairs merged → 10 → 7 items (every clause of all 10 retained, audit §2.4a).
- Red Flags 5 items line-merged → 3 lines.
**26 → 26 ✅** (1 item relocated, not dropped)

#### 2.4a Rationalizations merge detail
| Pair | Merged line | Retained clauses |
|---|---|---|
| "I'll test after" + "Tests after do the same" | ""I'll test after" / "Tests after do the same" — Tests-after verify only the code you remembered to check; passing immediately proves nothing." | both rationalizations + both reasons |
| "Already manually tested" + "Manual test is faster" | ""Already manually tested" / "Manual test is faster" — Manual testing is ad-hoc: no record, can't be re-run, proves no edge cases." | both + all 3 reasons |
| "Need to explore first" + "Keep it as reference" | ""Need to explore first" / "Keep it as reference" — Throw away exploration; keeping pre-test code is testing after. Delete means delete." | both + "Delete means delete" |

### 2.5 `_core/3_engineering/testing_aaa/preflight.md` — 7 → 6 lines (blank removed). 5 checkboxes → 5 ✅

### 2.6 `_core/2_workflows/feature_dev_build/protocol.md` — 44 → 26 lines
Inventory: Steps 1–5 (5), Principles 4, Execution Steps 3, Protocol 8 = **20**.
- Principles 4 → 2 lines (all 4 clauses retained).
- Execution Steps 3 → 1 line.
- Step 4 report template: 5-line code fence → 1 line (template verbatim, ` · `-joined).
- Step 6 Post-Build Delegation: 4 bullets → 1 line (all 4 triggers + targets).
**20 → 20 ✅**

### 2.7 `_core/2_workflows/feature_dev_build/memory.md` — 7 → 6 lines
Bullets 2+3 merged; delegation bullet tightened (B-10). **7 → 7 ✅**

### 2.8 `_core/2_workflows/feature_dev_build/preflight.md` — 9 → 8 lines
B-9 rewrite of verification-gate checkbox (self-gate primacy + verifier independence retained). **7 → 7 ✅**

### 2.9 `_core/3_engineering/architecture/standards.md` — 69 → 43 lines
Inventory: API Style 4, Arch Pattern 5, Data Strategy 4, Catalog 8, ATAM 6+rule, Deep Modules 6 = **34**.
- "Architecture Pattern" Q&A deleted (all 5 covered by catalog entries 1/3/4/5/7).
- "Data Strategy" Q&A deleted (Layered+ORM → #2, Event-Driven → #5, Event Sourcing → #6, Saga → **new catalog #9**).
- API Style kept (no catalog equivalent).
**34 → 34 ✅** (Saga row added so nothing orphaned)

### 2.10 `_core/3_engineering/architecture/redlines.md` — 27 → 21 lines
Anti-Patterns 6, Design Rules 7, Do NOT 4 = **17**. Line-merge: "Adequate architecture" + "Microservices" on one line; blanks trimmed. **17 → 17 ✅**

### 2.11 `_core/5_commands/review/protocol.md` — 73 → 42 lines
- Base-branch bash loop 8 lines → 1 (identical behavior).
- Diff block 5 lines → 1 (identical commands, `M` var).
- Step 2 GitLab bullets merged 2 → 1; Otherwise bullets 3 → 1.
- Axis 2: 6 bullets shortened, all retained.
**All steps + axis questions + fallback retained ✅**

### 2.12 `_core/3_engineering/code_review/memory.md` — 17 → 12 → 8 lines
Severity 3, Output table, verdict line, Context & File Access (3 lines → 1). **All items retained ✅**

## Appendix B — Verification (final)

- `zig build test` → EXIT 0 ✅
- `./agentc-cli build` → SUCCESS, 104 files ✅
- Dist read-back: build.md spot-checked — one of each XML tag per shell, no fragment headings, no internal path refs ✅
- Full budget table: all agents/commands ≤ 199 lines (see §1) ✅
