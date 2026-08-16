# Format-Consistency Pass — APPLIED (rev. 2)

**Date:** 2026-08-12
**Status:** **APPLIED + VERIFIED** (2026-08-12). Principle: user-directed — "all format symbols should be inside the `_core` imported files. In shell files, we should just import these files." `zig build test` EXIT 0; `./agentc-cli build` SUCCESS 104 files; dist read-back confirms thin shells + unified format.

## Principle (user-directed)

- **`_core` fragments own ALL content + format symbols** (bullets, checkboxes, numbered steps, bold labels).
- **Shells are thin import containers**: frontmatter + XML skeleton + `<!-- @import -->` lines + minimal IDE glue (agent names, `$ARGUMENTS` parsing, cursor `/`-interlocks, IDE-specific rules that reference IDE-specific agents).
- **No format symbols in shells** — no `- [ ]`, no `- ` bullets, no `1.` lists as shell-own content. If a shell needs rule content, it imports a `_core` fragment.

## Canonical Format Spec (applies to `_core` fragments)

| Section | Format |
|---|---|
| `redlines.md` | bold subsection labels + plain bullets `- `; strong verbs (NEVER/Do NOT/No/Always); **NO numbered lists** |
| `protocol.md` | bold subsection labels; numbered steps `1.` restarting per subsection |
| `standards.md` | bold subsection labels + bullets/tables |
| `memory.md` | bold subsection labels + bullets/templates |
| `preflight.md` | `- [ ]` checkboxes (with optional prose intro) |

## Part 1 — Normalize format in `_core` fragments

1. `_core/1_governance/anti_loop/preflight.md` — bullet → `- [ ]`
2. `_core/2_workflows/feature_dev_build/preflight.md` — 6 bullets → `- [ ]`
3. `_core/5_commands/review/preflight.md` — bullet → `- [ ]`
4. Sweep ALL `_core` redlines fragments — convert any numbered lists to bullets (none known; verify)
5. Sweep ALL `_core` protocol fragments — numbered steps restart per subsection (verify)

## Part 2 — Extract shell-own content into `_core` (shells become thin)

**Merge shell-own content into the matching concept fragments (single source of truth):**

| Shell | Content to extract → target fragment |
|---|---|
| `opencode/agents/build.md` | red_lines (7) → `feature_dev_build/redlines.md`; protocol steps (8) + report template → `feature_dev_build/protocol.md` + `feature_dev_build/memory.md` (new); preflight bullet → `feature_dev_build/preflight.md`; delegation bullets → neutralize agent names ("the code review agent", "the security review agent") and keep in `feature_dev_build/protocol.md`; shell keeps only frontmatter + intro + skeleton + imports |
| `opencode/agents/debug.md` | Constraints (4) → `error_triage/redlines.md`; 7-phase process → `error_triage/protocol.md` (merge); Retrieval & Tools → `error_triage/memory.md` (new); grep/glob references are opencode-specific → keep as shell glue |
| `opencode/agents/verifier.md` | Rules (4) + Process (5) + Output/Context → `testing_aaa/` fragments (merge) |
| `opencode/agents/security-reviewer.md` | Do NOT (4) + Context → `security_audit/` fragments (merge) |
| `opencode/agents/architect.md` | Do NOT (4) + API Design (3) → `architecture/` fragments (merge) |
| `opencode/agents/refactor.md` | Do NOT (4) + Context → `refactor_persona/` fragments (merge) |
| `opencode/agents/code-reviewer.md` | subagent note + Security Delegation + Context → `code_review/` fragments (merge) |
| `opencode/agents/docs.md` | Access note → `documentation/` fragments (merge) |
| `opencode/agents/build-error-resolver.md` | Do NOT + Rules + Process + Output → `error_triage/` fragments (merge) |
| `opencode/agents/explore.md` | Rules (9) + Process + Output → NEW `_core/2_workflows/explore/` concept (retrieval agent is IDE-neutral: search/read/verify) |
| `opencode/agents/evolver.md` | Constraints + Architecture Context + Workflow → NEW `_core/2_workflows/evolver/` concept |
| `opencode/agents/design.md` | Core Rule + Rules + Process + Output → `feature_dev_design/` fragments (merge) |
| `opencode/AGENTS.md` | orchestration table + delegation format → NEW `_core/1_governance/orchestration/` concept (IDE-neutral: delegation rules) |
| `opencode/rules/agent-constraints.md` | → NEW `_core/1_governance/agent_constraints/` concept (capability model is IDE-neutral) |
| `cursor/agents/*` (6) | IDE-specific content (references `/verifier` etc.) → **stays in shells as glue** (cursor-specific) |
| `cursor/rules/*.mdc` (8) | Interlocks + shell bullets → **stay in shells** (cursor-specific `/`-syntax); format normalized to spec |
| `cursor/commands/*` + `opencode/commands/*` | already thin (imports + glue) — verify |

### IDE-specific content stays in shells (documented exceptions)
- Cursor agent/rules content referencing `/verifier`, `/code-reviewer`, `/security-auditor`, `/debugger`, `/architect`, `/refactor` — cursor-specific routing, cannot live in `_core`
- OpenCode `$ARGUMENTS` / `@$1` parsing, `grep`/`glob` tool references (opencode-only permissions)
- Agent-name references in delegation bullets (neutralized in `_core`; shells supply names)

## Part 3 — Dedup + anomalies (from audit)

- Security commands ×2: remove `security_audit/protocol.md` import (command's own Process covers it)
- Review shells ×2: remove `code_review/protocol.md` import (Axis 1 delegates to the skill)
- `evolver.md` section order → canonical (red_lines → execution_protocol → standards)
- `security-auditor.md` duplicate `**Rules**` merge

## Line-Count Note (unchanged, deferred)

3 shells over 200 lines (build 287, review 274, cursor code-reviewer 282) — lazy-load recommendation documented; user chose to defer to a future session.

## Verification (after application)

1. `zig build test` → EXIT 0
2. `./agentc-cli build` → SUCCESS
3. dist read-back: shells contain ONLY frontmatter + skeleton + imports + glue (no shell-own bullets/checkboxes); all format symbols come from `_core` fragments; format spec enforced
4. Zero-loss: content moved, not removed; parity per concept re-verified