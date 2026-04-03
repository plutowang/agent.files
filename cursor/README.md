# Cursor Configurations Guide

This directory contains the source files for Cursor-specific agent behaviors, MDC rules, subagents, and custom commands.

## Reference Links

- MDC Rules Schema: <https://cursor.com/docs/rules>
- Subagents Architecture: <https://cursor.com/docs/subagents>
- Commands: <https://cursor.com/docs/reference/plugins#commands-format>

---

## 1. Subagent Configuration Schema (`cursor/agents/*.md`)

Custom subagents live in `.cursor/agents/` and run in isolated context windows. Use them for long-running, parallel, or specialized tasks to prevent bloating the main conversation.

**Note:** Cursor already has built-in subagents for `Explore` (codebase search), `Bash`, and `Browser`. Do not reinvent these unless you need highly specialized behavior.

### YAML Frontmatter Fields

| Field           | Type    | Default   | Description                                                                                            |
| :-------------- | :------ | :-------- | :----------------------------------------------------------------------------------------------------- |
| `name`          | string  | Filename  | Display name and identifier (lowercase, hyphens). You can invoke it via `/name`.                       |
| `description`   | string  | —         | **CRITICAL for Routing:** The parent agent reads this to decide delegation.                            |
| `model`         | string  | `inherit` | `inherit` (parent's model), `fast` (cheaper/faster model), or specific ID (e.g., `claude-3.5-sonnet`). |
| `readonly`      | boolean | `false`   | If `true`, blocks file edits and state-changing shell commands.                                        |
| `is_background` | boolean | `false`   | If `true`, runs asynchronously without blocking the parent agent.                                      |

### Pro-Tips for AI Agents (From Official Docs)

- **Delegation Hacking**: To force the parent agent to use your subagent automatically, inject aggressive phrases into the `description` field like: *"Use proactively when..."* or *"Always use for..."*.
- **Model Selection**: Always use `model: fast` for verifiers, test runners, or searchers to save tokens and speed up parallel execution.
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

## 3. Command Configuration Schema (`cursor/commands/*.md`)

For quick, repeatable actions.

| Field         | Type   | Description                            |
| :------------ | :----- | :------------------------------------- |
| `name`        | string | Command identifier (e.g., `refactor`). |
| `description` | string | Description shown in the UI palette.   |

---

## Integration with _core

Remember to append `<!-- @import _core/1_governance/hitl_gates.md -->` (or similar) at the bottom of host shells to inherit universal philosophies (like testing standards, security sandboxing, or human-in-the-loop workflows).
