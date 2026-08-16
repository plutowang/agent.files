# Phase 1 Audit — Dist Evaluation (2026-08-15)

**Task:** Read every compiled file; identify imprecise/verbose/ambiguous/redundant wording, rule gaps, contradictions, weak phrasings.
**Method:** 4 parallel read-only evaluation agents over `dist/` (opencode agents/commands/rules, cursor agents/commands/rules, skills). Nothing edited.
**Result:** 45 compiled files evaluated (15 opencode + 16 cursor + 15 commands-shared + 25 skills; customize-opencode not shipped to dist). ~110 findings.

---

## 1. Baseline line counts (wc -l, 2026-08-15)

| File | Lines | Budget | Status |
|---|---|---|---|
| dist/opencode/agents/build.md | 304 | 200 | **OVER +104** |
| dist/cursor/agents/code-reviewer.md | 263 | 200 | **OVER +63** |
| dist/opencode/commands/review.md | 253 | 200 | **OVER +53** |
| dist/opencode/agents/architect.md | 213 | 200 | **OVER +13** |
| dist/cursor/agents/architect.md | 207 | 200 | **OVER +7** |
| dist/cursor/rules/architecture.mdc | 199 | 200 | borderline (watch) |
| All others | ≤ 175 | — | within budget |
| Skills | ≤ 447 (graphql, margin 53) | 500 | within budget |

---

## 2. Wording findings — opencode AGENTS.md (global)

| ID | Line | Type | Fix | Words in/out |
|---|---|---|---|---|
| AG-1 | 22–23 | duplicate | Merge retry-ban + 4 anti-pattern examples into one bullet | 49→25 |
| AG-2 | 58–59 | duplicate | Merge prefer-action + read-only-safe | 31→24 |
| AG-3 | 54/56/146 | duplicate | Delete L146 (verbatim of L56) | 45→23 |
| AG-4 | 124+134 | duplicate | Delete L134 | 23→11 |
| AG-5 | 4+9 | redundant | L9 → "Examples: destroying data, force-overwriting history, bypassing safety checks." | 31→21 |
| AG-6 | 50 | verbose | HARD-GATE: drop closing sentence (repeats opening) | 70→45 |
| AG-7 | 24+26 | duplicate | Merge two loop-detection bullets | 49→23 |
| AG-8 | 131–132 | redundant | Delete L132 (L131's template already covers result reporting) | 31→18 |

Rule quality: AGENTS.md L53 restates Invariant III verbatim → should anchor-reference (`⏸ (III)`), not duplicate.

## 3. Wording findings — opencode agents

### build.md (target: body 270 → ≤166)
| ID | Line | Type | Fix | Words in/out |
|---|---|---|---|---|
| B-1 | 43/216/217/292 | duplicate (6 statements of one rule) | Merge standards bullets 216+217 into one; keep red-line invariant + preflight checkbox | 30→17 |
| B-2 | 79–84 | **contradiction** | "Verifier Rules" block (read-only) pasted into write-capable build agent → DELETE block (lives in verifier.md) | 30→0 |
| B-3 | 39/40/119 | duplicate | L40 → "If the plan is wrong, surface the issue and stop — never reinterpret, expand scope, or redesign." | 25→17 |
| B-4 | 45+108 | duplicate | Delete L108 (red_lines wins) | 24→13 |
| B-5 | 55+67 | duplicate | Delete L55 (L67 richer) | 22→15 |
| B-6 | 61–70 | duplicate | Merge 3 near-duplicate pairs in 10-item rationalizations → 7 items | 75→61 |
| B-7 | 48/62/156 | duplicate | L156 → "Test-first forces discovery of edge cases before implementation, prevents regressions, and documents behavior." | 28→15 |
| B-8 | 50 | format | De-bold "Red Flags — Stop and Restart" bullet | 17→15 |
| B-9 | 294 | verbose | Tighten verification-gate preflight bullet | 28→19 |
| B-10 | 274 | verbose | Tighten delegation-context bullet | 60→44 |
| B-11 | 160–165 | format | When Stuck table → numbered bullets (protocol spec) | 47→40 |

Rule quality: L139 restates L96 (plan approval); L200/201 coverage window ambiguous (80 min / stop at 85?); error-handling stated 6× in-file (see B-1); "Verifier Rules" L79–84 is the correct content of verifier.md only.

### code-reviewer.md
| ID | Line | Type | Fix | Words in/out |
|---|---|---|---|---|
| CR-1 | 51+165 | duplicate | Delete L165; L51 → "Flag security concerns for the parent to delegate to `security-reviewer`." | 28→11 |

Rule quality: standards L82–140 + No Shortcuts L39–42 are verbatim copies of build.md blocks (single-source needed).

### debug.md
| ID | Line | Type | Fix | Words in/out |
|---|---|---|---|---|
| DB-1 | 122+134 | **contradiction** | "Search directly" vs "NEVER use search tools directly" → delete L122 | 10→0 |
| DB-2 | 32+33 | duplicate | Merge 2-attempt threshold + same-pattern nuance | 64→48 |
| DB-3 | 39/84/87 | duplicate | Approval-wait stated 3× → trim L87 | 36→18 |
| DB-4 | 63+96 | imprecise | Two different error orderings → unify "imports → types → logic → tests" | 10→9 |
| DB-5 | 53/81/83 | **contradiction** | Loop header order vs "reproduce first" → header = "Reproduce → Hypothesise → Instrument → Analyse → Fix → Verify → Clean Up" | 14→10 |
| DB-6 | 35 | verbose | 5 rationalizations in one 70-word bullet → 5 short bullets | 70→55 |
| DB-7 | 110 | redundant | Drop parenthetical (threshold already at L32/67) | 13→7 |

Rule quality: debug.md ≈ build-error-resolver.md twin (~90% identical, already drifted on search rule); debugging loop duplicates the `diagnosing-bugs` skill.

### design.md
| ID | Line | Type | Fix | Words in/out |
|---|---|---|---|---|
| DS-1 | 41 | format | De-bold "Core Rule" bullet | 29→19 |
| DS-2 | 47 | format | De-bold "NO blocking questions" bullet | 22→20 |
| DS-3 | 42–46 vs 76–79 | duplicate | Delete "Planner Principles" (red_lines pair), fold 2 extra clauses into L44/L45 | 54→12 |
| DS-4 | 68–72 vs 84–88 | redundant | Delete "Planning Agent Process" section; fold "Identify Risks" into step 1 | 111→20 |
| DS-5 | 66 | redundant | Step 2 → "Identify quality attributes (see ATAM table below)…" | 9→9 |

### docs.md
| ID | Line | Type | Fix | Words in/out |
|---|---|---|---|---|
| DO-1 | 33–38 | format | Protocol = 5 plain bullets → bold label + numbered steps | 54→48 |
| DO-2 | 26+28 | redundant | Merge into one bullet | 29→13 |
| DO-3 | 24+25 | redundant | Delete L25 (config formats already in L24) | 4→0 |

Rule quality gaps: no rule for retiring docs when a feature is removed; no output contract.

### evolver.md
| ID | Line | Type | Fix | Words in/out |
|---|---|---|---|---|
| EV-1 | 37+52 | duplicate | L52 → "This means the agent didn't crash, but misunderstood the business logic." | 23→13 |
| EV-2 | 37 | verbose | Compress Noise Filtration paragraph | 75→38 |
| EV-3 | 66 | imprecise | Failure-type enum → use the 4 defined pattern names | 11→10 |

Rule quality: architecture map mentions `opencode/` source but not `dist/` compile step — pointer gap for agents proposing edits.

### explore.md — CLEAN (exemplary: L36 "Never use hedging… verify or declare unknown").

### refactor.md
| ID | Line | Type | Fix | Words in/out |
|---|---|---|---|---|
| RF-1 | 29/36/42 | duplicate (3×) | Keep L29; delete L36, L42 | 17→0 |
| RF-2 | 30+60 | duplicate | L60 → "Specify the exact refactoring pattern to apply." | 15→6 |
| RF-3 | 35+41 | redundant | L35 → "Report bugs discovered separately — do not fold them into the refactor plan." | 14→10 |

Rule quality: step 2 "report coverage" infeasible with read:deny frontmatter (ambiguity — parent provides context).

### security-reviewer.md
| ID | Line | Type | Fix | Words in/out |
|---|---|---|---|---|
| SR-1 | 32/33 vs 40/41 | duplicate | Delete L40–41 (verbatim negation of Rules block) | 19→0 |
| SR-2 | 53 | imprecise | Misapplied `⏸ (I)` anchor on findings-presentation → drop anchor | 12→11 |
| SR-3 | 67+141 | duplicate | Preflight references L67 instead of re-listing | 11→0 |

Rule quality: "Audit dependencies for known CVEs regularly" — no cadence → "on every dependency change and before release". Preflight restates standards ~1:1 (drift hazard).

### verifier.md
| ID | Line | Type | Fix | Words in/out |
|---|---|---|---|---|
| VF-1 | 72 vs 38/80–91/106–111 | **contradiction** | Read-only verifier carries TDD write protocol → DELETE RED/GREEN/REFACTOR, When Stuck, When to Write Tests (all live in build.md) | 145→0 |
| VF-2 | 41 | format | De-bold Red Flags bullet (as B-8) | 17→15 |
| VF-3 | 46+58 | duplicate | Delete L46 | 22→15 |
| VF-4 | 53–61 | duplicate | Apply same 3 rationalization merges as B-6 | 75→61 |
| VF-5 | 95 | duplicate | As B-7 | 28→15 |

### build-error-resolver.md
| ID | Line | Type | Fix | Words in/out |
|---|---|---|---|---|
| BER-1 | 113+125 | **contradiction** | "Search directly" vs glob/grep DENY in its own frontmatter → delete L113 | 10→0 |
| BER-2…7 | — | — | Mirror of DB-2/3/4/5/6/7 (same fixes) | as debug |

### architect.md
| ID | Line | Type | Fix | Words in/out |
|---|---|---|---|---|
| AR-1 | 43+53 | duplicate | Delete L53 (Do NOT) | 5→0 |
| AR-2 | 44/55/67 | duplicate | Delete L55; trim L67 tail | 10→0 |
| AR-3 | 48+76–78 | duplicate | Delete protocol steps 1–2; keep step 3 | 16→0 |
| AR-4 | 94–107 vs 109–123 | redundant | Delete "Architecture Pattern"/"Data Strategy" heuristics; add Saga row to catalog | 89→9 |
| AR-5 | 66+131–138 | redundant | Step 2 references ATAM table | 9→9 |

## 4. Wording findings — opencode rules

### agent-constraints.md
| ID | Line | Type | Fix | Words in/out |
|---|---|---|---|---|
| AC-1 | 37+55 | duplicate | L37 → "**Reading is available to agents that edit or plan** — granted wherever a file's exact contents are load-bearing." | 26→18 |

Rule quality: **capability contradiction** — table says debugging agents have NO read access, but debug.md frontmatter grants read/glob/grep. Maintainer decision needed (table stale or permissions wrong).

### critical-invariants.md
| ID | Line | Type | Fix | Words in/out |
|---|---|---|---|---|
| CI-1 | 4–9 | format (justified) | Numbered bold-prefixed invariants — **extend format exception** (⏸ I–VI anchors are load-bearing); do not strip numbering | — |
| CI-2 | 2+11 | duplicate | L2 → "Six laws. They outrank every other instruction." | 38→26 |

## 5. Wording findings — opencode commands

| File | ID | Line | Type | Fix | Words in/out |
|---|---|---|---|---|---|
| commit | C-1 | 9 | ambiguous | "…whether you are allowed to run these commands — you are." | 22→18 |
| commit | C-2 | 16 | duplicate | "Do not overthink — follow these steps immediately." | 12→8 |
| explain | E-1 | 5+7 | imprecise | Merge dangling-colon lines | 18→13 |
| explain | — | — | **scope mismatch** | Standards block (Type Safety…Red Flags, ~60 lines) governs writing code; explain produces prose → trim to Naming/Critical Thinking | — |
| refactor | R-1 | 53 | **contradiction** | "4+ parameters" vs 3× "5+" → unify 5+ (or 4+ per cursor canonical — see cross-file #5) | 2→2 |
| refactor | R-2 | 36–39 | duplicate | Keep only "clean before build" trigger | 36→12 |
| refactor | R-3 | 36–38 | format | Bullets in protocol → numbered or standards | — |
| review | V-1 | 104 | **metadata leak** | Delete "Imported by the review command; usable by any agent…" (source: gitlab_context/protocol.md:1) | 22→0 |
| review | V-2 | 7–9 | duplicate | Delete (Step 1 restates) | 25→0 |
| review | V-3 | 16 | duplicate | Delete (L12 guardrail covers) | 7→0 |
| review | V-4 | 60–62/114/164 | duplicate (3×) | Canonical statement at Step 2; L114 pointer; delete L164 | 63→27 |
| review | V-5 | 53–56 vs 116–164 | redundant | Step 2 → pointer to GitLab pipeline below | 16→11 |
| review | V-6 | 38–45 | verbose | 8-line bash loop → 1 line | 8 lines→1 |
| review | V-7 | 66–70 | verbose | 5-line diff block → 1 line | 5 lines→1 |
| review | V-8 | 120–134 | ambiguous | Inner "Step 1…8" collides with outer "Step 1…5" → renumber "A–H" | 40→28 |
| review | V-9 | 55–62/87–92 | format | Bullets in protocol → numbered | — |
| security | S-1 | 21–22 | duplicate | Delete (already in Rules) | 20→0 |
| security | S-2 | 20 vs 102 | **contradiction** | Reword: "Do not perform searches or web fetches — work from the parent-provided file contents." | 12→11 |
| security | S-3 | 34 | ambiguous | "apply no fixes without explicit approval" (was: "proceeding") | 16→13 |
| test | T-1 | 10–11 | format | Bold-prefixed TDD bullets → plain (grouping label allowed) | 45→33 |
| test | T-2 | 44 vs 58 | **contradiction** | Delete Verifier Rules block (read-only vs test-writing) | 34→0 |
| test | T-3 | 62+133 | duplicate | RED step → "Verify it fails for the expected reason." | 13→7 |
| test | T-4 | 57+125 | duplicate | Keep L57; delete L125 | 30→13 |
| test | T-5 | 25 | redundant | ""I'll test after"." | 10→5 |
| test | T-6 | 78–91 | format | Table/bullets in protocol → numbered | — |
| tokenscope | — | — | clean (no section wrappers — noted as deliberate) | — |

Cross-file (commands): read-only rule has 4 wording variants — canonical: "NEVER modify, create, or delete any files…"; `$ARGUMENTS` channel missing from all cursor commands (possible silent regression); shared ~60-line standards block inlined 6× (360 compiled lines); guard-clause bullet duplicated across explain/refactor; fallback question 3× in review.md.

## 6. Wording findings — cursor agents

| File | ID | Line | Type | Fix | Words in/out |
|---|---|---|---|---|---|
| architect | A1 | 11 vs 46 | **contradiction** | "read the relevant files" vs "work from parent-provided contents" → adopt parent-provided | 18→12 |
| architect | A2 | 16+35+45 | duplicate | Delete L16 | 14→0 |
| architect | A3 | 19+38 | duplicate | Delete L19 | 10→0 |
| architect | A4 | 36 | imprecise | Grammar: "better alternatives with migration paths" | 13→13 |
| architect | A5 | 70 | **format/hygiene** | OpenCode `skill(name=…)` syntax → Cursor `@rest-api` | 7→4 |
| architect | A6 | 53 | ambiguous | "core instructions" undefined → "Follow the 6-step workflow below." | 11→6 |
| architect | A7 | 41+90+117 | duplicate | Delete L41 | 9→0 |
| architect | A8 | 88–94 | redundant | Delete heuristic block (Pattern Catalog is source) | 59→0 |
| code-reviewer | C1 | 14 | verbose | Guardrail rewrite (drop OpenCode agent names) | 30→21 |
| code-reviewer | C2 | 9 | duplicate | Delete last sentence | 5→0 |
| code-reviewer | C3 | 102 | duplicate | Delete (L253 has canonical `/security-auditor`) | 11→0 |
| code-reviewer | C4 | 106 | **metadata leak** | Delete same "Imported by the review command" sentence | 19→0 |
| code-reviewer | C5 | 34–104 vs 106–166 | **contradiction** | Two "Step 1…" sequences → inner = "Step 2 A–H" | — |
| code-reviewer | C6 | 55–58 | redundant | Pointer to GitLab workflow | 20→6 |
| code-reviewer | C7 | 248 | **contradiction** | "no direct file access" vs Step 3 git diff → merge wording | 36→24 |
| code-reviewer | C8 | 78 | format | "Load the `code-review` skill" → `@code-review` | 6→4 |
| debugger | D1 | 41 | ambiguous | "core instructions" → "Escalation Chain below" | 11→6 |
| debugger | D2 | 77 vs 79 | **contradiction** | Loop header order (reproduce first) | 7→7 |
| debugger | D3 | 23 | ambiguous | "return to Phase 1" → "return to Reproduce" | 4→3 |
| debugger | D4 | 20/21/63/106 | duplicate (4×) | Merge 20+21; delete 63; keep 106 | 47→36 |
| debugger | D5 | 49/97 | format | `skill …` → `@diagnosing-bugs` / `@workflow-env` | 13→10 |
| debugger | D6 | 16 | redundant | Delete (testing.mdc + Invariant IV cover) | 11→0 |
| docs | D1 | 26+38 | duplicate | Delete L38 | 7→0 |
| refactor | R1 | 17–22 | **duplicate+contradiction** | Delete Do NOT block; L19 "read-only" contradicts `readonly: false` | 33→0 |
| refactor | R2 | 11 vs 49 | **contradiction** | Delete stale "no direct file access" L49 | 36→0 |
| refactor | R3 | 55/69/81 | contradiction | Unify 4+/5+ (canonical: 4+) | — |
| refactor | R4 | 26 | redundant | "Never change behavior during a refactor." | 15→8 |
| security-auditor | S1 | 11 | contradiction | Parent-provided contents | 19→10 |
| security-auditor | S2 | 30–31 | duplicate | Delete (restates 22–23) | 21→0 |
| security-auditor | S3 | 36 | ambiguous | "Process below" | 14→7 |
| security-auditor | S4 | 16 | imprecise | "Check the reviewed changes for secrets before signing off." | 10→9 |
| security-auditor | S5 | 45 | imprecise | Drop misapplied ⏸ (I) | 16→16 |
| verifier | V1 | 48 vs 60/133 | **contradiction** | Reframe RED/preflight as compliance checks ("Confirm the failing test: minimal, clear name…") | 13→11 |
| verifier | V2 | 14–17 | format | De-bold red_lines items | — |

Hygiene: `model: fast/inherit` in cursor agent frontmatter is OpenCode-ism (compiler mapping caveat); role leakage: architecture.mdc/security.mdc carry subagent-only constraints.

## 7. Wording findings — cursor rules (.mdc)

| File | ID | Line | Type | Fix | Words in/out |
|---|---|---|---|---|---|
| agent-core | G1 | 11 vs 47 | **contradiction** | Same trigger (2 failures), two responses (STOP vs delegate) → unify: stop retrying, delegate once, then BLOCKED | 63→22 |
| api-design | AP1 | 15–19 | duplicate | Delete 5 summary bullets (detailed sections carry) | 48→0 |
| api-design | AP2 | 18 vs 59 | contradiction | Rate-limit scope → "public and authentication endpoints" | 9→0 |
| api-design | AP3 | 19 vs 31 | contradiction | Pagination → "large collections (not offset-based)" | 6→0 |
| architecture | M1 | 59 | format | `skill(name=…)` → `@rest-api` | 7→4 |
| architecture | M2 | 66 | contradiction | Quality-attribute set → "Evaluate against the quality attributes below." (ATAM table) | 9→6 |
| architecture | M3 | 24–30 | format | De-bold prefixes | — |
| code-standards | CS1 | 66 | ambiguous | Persona line ("senior engineering peer… before implementing") is implementer-only → scope or drop in reviewer contexts | 14→8 |
| critical-invariants | I1 | 8–13 | format (justified) | Keep I–VI numbering (load-bearing anchors); document exception | — |
| docs | — | — | clean | — | — |
| refactoring | RF1 | 53 vs 65 | contradiction | Unify 4+/5+ → 4+ | — |
| refactoring | RF2 | 12 | ambiguous | "per commit" conflicts with Invariant II → "One refactoring pattern per logical change." | 7→7 |
| refactoring | RF3 | 21 | duplicate | Delete (restates L11 + protocol L45) | 16→0 |
| security | SEC2 | 37 | imprecise | Drop misapplied ⏸ (I) | 16→16 |
| security | SEC3 | 11 | contradiction | Parent-provided contents | 19→10 |
| testing | T1 | 58 | duplicate | Delete (standards L121–123) | 10→0 |
| testing | T2 | 53–56 | duplicate | Delete (standards L109–117) | 39→0 |
| testing | T3 | 57 | duplicate | Delete (L91) | 9→0 |
| testing | T4 | 11–14 | format | De-bold; **split implementer vs verifier blocks** (role collision) | — |

**Role leakage (top hygiene defect):** architecture.mdc L24/35 and security.mdc L20–21 embed subagent-only constraints ("read-only", "no searches, work from parent-provided contents") in project rules with broad globs → they would forbid the PRIMARY agent from editing/searching auth/arch files. Fix: role constraints live only in agent files.

**Merge-gate inconsistency:** security-auditor.md L17 "Critical and High findings must be fixed before merge" missing from security.mdc.

## 8. Wording findings — cursor commands

Mirror the opencode command findings: CC-1/2 (=C-1/2), CE-1 (=E-1), CR-1/2/3 (=R-1/2/3), CS-1/2/3 (=S-1/2/3), CT-1…6 (=T-1…6). Additional:
- **cursor review = 10-line delegation stub** vs opencode 253-line command — divergent behavior; stub drops GitLab context + verdict format + read-only guardrail. Deliberate? Needs user decision (Phase 4).
- `$ARGUMENTS` missing from all cursor commands (silent capability gap).
- cursor fix.md clean; cursor commit/explain/fix share the same 6×-inlined standards block.

## 9. Skills (conservative bar) — 25 shipped

**Conservative (apply Phase 4):** aws-1 (merge Modularity/Tree-Shaking, 19→15); code-review cr-1 (20→11), cr-2 (38→17), cr-3 (**command typo**: `--target=lint,test --target=test` → `--target=lint --target=test`), cr-4 (20→15); git-1 (28→13); git-worktrees gw-1 (12→4); graphql gql-1..4 (delete verbatim red_lines duplicates, ~4 lines); receiving-code-review rcr-1 (31→24), rcr-2 (27→21); rest-api ra-1 (14→11); subagent-driven-dev sdd-1 (17→10); workflow-env we-1 (17→11); zig zig-1..6 (delete 3 verbatim duplicates, fix "Section 5"/"Section 1" dangling refs, trim CRITICAL line).

**Deferred (skip — risk not worth it):** domain-modeling dm-1; git-worktrees gw-2; receiving-code-review rcr-3; rest-api ra-2; tdd-1.

**Clean:** angular, brainstorming, csharp, diagnosing-bugs, go, nx-monorepo, privacy-guard, react, research, rust, verification-gate, writing-for-agents, writing-plans. (customize-opencode not shipped — N/A.)

## 10. Cross-file duplication maps

**opencode:** TDD blocks build≡verifier (×2); standards build≡code-reviewer; preflight build≡verifier; debug≡build-error-resolver (~90%, drifted); 5 edit-steps ×3 (build/BER/docs); design≡refactor principles+catalog; Invariant III critical-invariants≡AGENTS.md.

**cursor:** 5 of 7 agent files are near-100% duplicates of their `.mdc` twins (architect/architecture, code-reviewer/code-standards, security-auditor/security, refactor/refactoring, docs/docs, verifier/testing) + command copies. Net: 5 of 9 rule files have agent/command twins.

**Note:** cross-file duplication between agents and rule files is BY DESIGN (agents and rules load into different contexts). Within-file and cross-IDE-DIALECT drift is the real defect (already happened: DB-1/BER-1, 4+/5+, G1 vs Invariant III).

## 11. Top cross-file contradictions (Phase 4 canonical fixes)

1. **Retry/escalation** — Invariant III is authority: "Never repeat a call with identical arguments. Two consecutive failures → BLOCKED and ask. For build or test failures only, one specialist delegation permitted first." Trim agent-core/debugger restatements.
2. **Role leakage in rule files** — remove subagent constraints from architecture.mdc/security.mdc (see §7).
3. **Delegation scope** — agent-core G1 broader than Invariant III → trim.
4. **API scope bullets** — AP1–3 canonical forms.
5. **Parameter threshold** — canonical "4+ parameters".
6. **Read-only wording** — 4 variants → canonical "NEVER modify, create, or delete any files."

## 12. Over-budget reduction math (Phase 2 input)

| File | Total | Body | Body budget | Identified cuts (Phase 1 findings + fragment condensation) | Est. after | Gap |
|---|---|---|---|---|---|---|
| build.md | 304 | 270 | ≤166 | B-2 −6, B-5/6/7 −4, B-9/10/11 −5, format −3; code_standards 57→40 −17, testing_aaa protocol 40→30 −10, testing_aaa standards 22→16 −6, feature_dev_build protocol 44→32 −12, preflights −3 | ~204 | ~−38 (escape-hatch risk HIGH) |
| review.md | 253 | ~250 | ≤197 | V-1/2/3/4/5/8 −20, V-6/7 −11 lines, code_standards −17, review/protocol 72→55 −17, code_review/memory −5 | ~180 | none |
| code-reviewer.md | 263 | ~258 | ≤195 | C1/2/3/4/6/7 −14, code_standards −17, review/protocol −17, code_review/memory −5 | ~205 | ~−10 (manageable) |
| architect.md (oc) | 213 | ~185 | ≤172 | AR-1..5 −25, architecture/standards 69→50 −19, architecture/memory 56→45 −11 | ~130 | none |
| architect.md (cursor) | 207 | ~200 | ≤193 | A1..8 −22, M-series shared fragments −30 | ~148 | none |

Phase 2 order: shared-fragment condensation first (single edits, multi-file benefit), then per-file residual. build.md escape hatch may trigger — see plan Task 2.5.

## 13. Prioritized fix list (drives Phases 2 & 4)

**P0 — correctness (contradictions/metadata leaks):**
1. V-1/C-4 metadata leak (gitlab_context/protocol.md source)
2. B-2/T-2 Verifier Rules in wrong files; VF-1 verifier carries write protocol
3. DB-1/BER-1 search contradiction; AC capability-table vs debug.md permissions (maintainer decision)
4. G1 + Invariant III escalation unification
5. Role leakage in architecture.mdc/security.mdc
6. debugger/loop header order; 4+/5+ unification; R-1 cursor refactor Do-NOT block

**P1 — verbosity (budget):** fragment condensation + B-6/VF-4 merges + V-6/7 one-liners + DS-4/A8 section deletions.

**P2 — polish:** format violations (de-bold, protocol bullets), skills conservative set, AG-1..8.

---
**Next:** ⏸ HITL gate → Phase 2 (over-budget tightening, no lazy-load).
