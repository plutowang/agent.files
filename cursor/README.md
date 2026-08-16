# Cursor Configurations Guide

This directory contains the source files for Cursor-specific agent behaviors, MDC rules, subagents, and custom commands.

## Reference Links

- MDC Rules Schema: <https://cursor.com/docs/rules>
- Subagents Architecture: <https://cursor.com/docs/subagents>
- Skills: <https://cursor.com/docs/skills>
- Permissions: <https://cursor.com/docs/reference/permissions>
- Sandbox: <https://cursor.com/docs/reference/sandbox>

---

## 1. Subagent Configuration Schema (`cursor/agents/*.md`)

Custom subagents live in `.cursor/agents/` and run in isolated context windows. Use them for long-running, parallel, or specialized tasks to prevent bloating the main conversation.

**Note:** Cursor already has built-in subagents for `Explore` (codebase search), `Bash`, and `Browser`. Do not reinvent these unless you need highly specialized behavior.

### YAML Frontmatter Fields

| Field           | Type    | Default   | Description                                                                                            |
| :-------------- | :------ | :-------- | :----------------------------------------------------------------------------------------------------- |
| `name`          | string  | Filename  | Display name and identifier (lowercase, hyphens). You can invoke it via `/name`.                       |
| `description`   | string  | —         | **CRITICAL for Routing:** The parent agent reads this to decide delegation.                            |
| `model`         | string  | `inherit` | `inherit` (parent's model) or a specific model ID. Bracket params: `composer-2.5[fast=false]`, `grok-4.6[effort=high]`. Note: `model: fast` is no longer valid. **Project directive: pin only `composer-2.5` (utility/fast) or `grok-4.6` (thinking) — no third-party models.** |
| `readonly`      | boolean | `false`   | If `true`, blocks file edits and state-changing shell commands.                                        |
| `is_background` | boolean | `false`   | If `true`, runs asynchronously without blocking the parent agent.                                      |

### Pro-Tips for AI Agents (From Official Docs)

- **Delegation Hacking**: To force the parent agent to use your subagent automatically, inject aggressive phrases into the `description` field like: *"Use proactively when..."* or *"Always use for..."*.
- **Model Selection**: Pin utility subagents (verifier, docs) to `composer-2.5` (fast tier is the default) and thinking subagents to `grok-4.6` (fast default on Pro+). Both are Cursor Models pool — no third-party models, no `model: fast` (removed by Cursor).
- **Subagent vs. Skill**: If a task is a quick, single-shot action (like formatting or generating a changelog) without needing context isolation, create a Slash Command or Skill instead.

---

## 2. MDC Rules Schema (`cursor/rules/*.mdc`)

MDC files provide context-aware rules based on the active file or explicit invocation.

### Frontmatter Fields

| Field         | Type    | Description                                                                |
| :------------ | :------ | :------------------------------------------------------------------------- |
| `description` | string  | Used by the Agent to apply intelligently.                                  |
| `globs`       | string  | Apply rule when the active file matches (e.g., `*.ts`, `backend/**/*.go`). |
| `alwaysApply` | boolean | Apply to every single chat session.                                        |

---

## 3. Skills Schema (`cursor/skills/*/SKILL.md`)

Skills are the current slash-workflow format. Each skill is a folder containing a `SKILL.md` file; the folder name **must match** the frontmatter `name` (lowercase-hyphens).

| Field                     | Type    | Description                                                                                                      |
| :------------------------ | :------ | :--------------------------------------------------------------------------------------------------------------- |
| `name`                    | string  | Skill identifier. Lowercase letters, numbers, hyphens. **Must match the parent folder name.**                    |
| `description`             | string  | Describes **what the skill does and when to use it**.                                                             |
| `paths`                   | string  | Optional globs scoping the skill to matching files. Unset = available regardless of open files.                  |
| `disable-model-invocation` | boolean | `true` = traditional slash-command behavior: only included when explicitly invoked via `/skill-name`.            |

Commands are legacy — Cursor 2.4+ migrates them to skills (`/migrate-to-skills`). This repo ships 7 skills: `commit`, `explain-code`, `fix-bug`, `review-code`, `refactor-code`, `security-audit`, `generate-tests`.

---

## Integration with _core

Remember to append `<!-- @import _core/1_governance/hitl_gates/protocol.md -->` (or similar) at the bottom of host shells to inherit universal philosophies (like testing standards, security sandboxing, or human-in-the-loop workflows). `_core` concepts are organized as folders of section fragments (`redlines.md`, `protocol.md`, `memory.md`, `preflight.md`) — import the fragments your shell needs.

---

## Conflict Avoidance (Reserved Names)

Do NOT create agents/skills/commands with these names — they collide with Cursor built-ins:

- **Built-in subagents:** `explore`, `bash`, `browser`.
- **Built-in skills (slash):** `review`, `review-security`, `review-bugbot`, `create-rule`, `create-skill`, `create-subagent`, `create-hook`, `migrate-to-skills`, `automate`, `babysit`, `canvas`, `cursor-blame`, `loop`, `sdk`, `shell`, `split-to-prs`, `statusline`, `update-cli-config`, `update-cursor-settings`.
- **CLI slash commands:** `plan`, `ask`, `debug`, `model`, `clear`, `fork`, `summarize`, `rewind`, `shell`, `help`, `mcp`, `config`, `sandbox`, … — never name a custom artifact after these.
- This repo therefore names its review skill `review-code` (not `review`) and its refactor skill `refactor-code` (the `/refactor` slash stays with the refactor **agent**).

## 2026 Notes

- **Skills supersede commands** — commands are legacy; new slash workflows are skills.
- **Run Modes:** Cursor 3.5 deprecated "Ask Every Time" and folded "Run in Sandbox" into Allowlist; 3.6 made **Auto-review** the recommended default.
- **`permissions.json`** (`autoRun` steering) is best-effort — **not a security boundary** — and is consulted **only in Auto-review mode** (inert under `approvalMode: "allowlist"`; activates if you switch the IDE Run Mode to Auto-review). `terminalAllowlist`/`mcpAllowlist` in that file **override** your in-app allowlists — this repo deliberately ships `autoRun` only.
- **`sandbox.json`** governs agent sandboxing (workspace read/write paths, network policy).
- **`~/.cursor/cli-config.json`** schema is versioned (`version: 1`).

## Deployment

1. `./agentc-cli build` compiles to `dist/cursor/` (macros expanded; native skills + `_core` skills merged into one `skills/` dir).
2. `./agentc-cli link cursor` symlinks: `~/.cursor/{agents,rules,skills,mcp.json,sandbox.json,cli-config.json,permissions.json}` + settings/extensions into `~/Library/Application Support/Cursor/User/`.
3. Project-scoped configs: copy from `dist/cursor/` into the project's `.cursor/` (e.g., `.cursor/agents/`, `.cursor/skills/`, `.cursor/mcp.json`, `.cursor/sandbox.json`).
