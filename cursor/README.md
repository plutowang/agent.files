# Cursor Configurations Guide

This directory contains the source files for Cursor-specific agent behaviors, MDC rules, subagents, and custom commands.

## Reference Links

- MDC Rules Schema: <https://cursor.com/docs/rules>
- Subagents Architecture: <https://cursor.com/docs/subagents>
- Commands: <https://cursor.com/docs/reference/plugins#commands-format>

---

## 1. MDC Rules Schema (.mdc)

Cursor uses `.mdc` files with frontmatter to specify description and globs for more control over when rules are applied.

### Rule Anatomy

Each rule is a markdown file with frontmatter metadata and content. Control how rules are applied by configuring the following frontmatter properties: `description`, `globs`, and `alwaysApply`.

### Rule Types & Application Logic

| Rule Type | Description | Trigger Mechanism |
| :--- | :--- | :--- |
| **Always Apply** | Apply to every chat session | Set `alwaysApply: true` in frontmatter. |
| **Apply Intelligently** | When Agent decides it's relevant | Agent reads the `description` field to decide. |
| **Apply to Specific Files** | When file matches a specified pattern | Agent checks if the current file matches `globs`. |
| **Apply Manually** | When explicitly mentioned in chat | User types `@rule-name` in the Composer/Chat. |

---

## 2. Subagent Configuration Schema

When creating or modifying Cursor subagents, you MUST use the following YAML frontmatter schema:

### Configuration Fields

| Field | Type | Required | Default | Description |
| :--- | :--- | :--- | :--- | :--- |
| `name` | string | No | Derived from filename | Display name and identifier. Use lowercase letters and hyphens. |
| `description` | string | No | — | Short description shown in Task tool hints. Agent reads this to decide delegation. |
| `model` | string | No | `inherit` | Model to use (`inherit`, `fast`, or specific ID like `claude-3.5-sonnet`). |
| `readonly` | boolean | No | `false` | If true, runs with restricted write permissions (no file edits, no state-changing commands). |
| `is_background` | boolean | No | `false` | If true, runs in the background without blocking the parent. |

---

## 3. Command Configuration Schema

Cursor allows defining custom slash commands (e.g., `/refactor`) to quickly trigger specific workflows.

### Command Frontmatter Fields

When creating a command file, you MUST use the following YAML frontmatter:

| Field | Type | Description |
| :--- | :--- | :--- |
| `name` | string | Command identifier (lowercase, kebab-case). |
| `description` | string | Brief description of what the command does. |

---

## 4. Integration with _core (Dependency Injection)

Whether building an MDC rule, a subagent, or a command, remember to append `<!-- @import _core/[filename].md -->` at the bottom of host shells to inherit universal philosophies (like testing standards, security sandboxing, or human-in-the-loop workflows).

Do NOT redefine universal software engineering philosophies in this directory. Only define Cursor-specific execution mechanics and metadata here.
