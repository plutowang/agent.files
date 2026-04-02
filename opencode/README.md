# OpenCode Configurations Guide

This directory contains the source files for OpenCode's multi-agent system, including roles, commands, and rules.

## Reference Links

- Agents Protocol: <https://opencode.ai/docs/agents/>
- Custom Instructions: <https://opencode.ai/docs/rules/>
- Custom commands: <https://opencode.ai/docs/commands/>

---

## 1. Agent Configuration Schema (`agents/*.md`)

OpenCode agents are defined using YAML frontmatter followed by Markdown instructions. When modifying or creating agents, use the following schema:

### Frontmatter Fields

| Field | Type | Description |
| :--- | :--- | :--- |
| `description` | string | Defines the agent's purpose. Critical for routing. |
| `temperature` | float | `0.0-0.2`: Focused/deterministic (analysis/planning).`0.3-0.5`: Balanced.`0.6-1.0`: Creative (brainstorming). |
| `steps` | integer | Max agentic iterations before forced text response (cost control). |
| `model` | string | The specific LLM ID to route to (e.g., `openrouter/google/gemini-3.1-pro-preview`). |
| `mode` | string | `primary`, `subagent`, or `all` (default). |
| `hidden` | boolean | `true` hides it from the `@` menu. Useful for internal background agents. |
| `color` | string | Hex code (`#FF5733`) or theme (`primary`, `error`, `success`, `warning`, `info`). |

### Nested Permission Objects

Permissions control what tools the agent can execute autonomously. Values can be: `"ask"`, `"allow"`, or `"deny"`.

- **`permission`**: Controls basic tools.
  - `edit`: File modification.
  - `webfetch`: Internet access.
  - `bash`: Terminal access. Can use glob patterns (e.g., `"rm*": deny`, `"git diff": allow`).
- **`permission.task`**: Controls which *other subagents* this agent can invoke. Uses glob patterns. Setting to `deny` removes that subagent from this agent's visibility.

### CRITICAL: The Timestamp Workaround
OpenCode has a strict security mechanism for the `edit` and `write` tools. 
If an agent requires the ability to modify files, it **MUST** also have `read: true` in its tools list. Furthermore, the prompt MUST explicitly instruct the agent to **call `read` on a file immediately before modifying it**. Subagent reads (e.g., from `explore`) do NOT satisfy this timestamp check.

---

## 2. Rules Configuration Schema (`rules/*.md`)

Rules are pure markdown files. However, they rely heavily on OpenCode's **Lazy Loading** architecture via the `@` symbol.

**Critical Behavior for AI Agents:**
When writing rules, if you reference another file (e.g., `@docs/api.md`), you MUST instruct the executing agent to use its `read` tool to load that file *only when needed*. Do not expect OpenCode to preemptively inject the content of `@` referenced files into the context window automatically.

---

## 3. Command Configuration Schema (`commands/*.md`)

Slash commands (e.g., `/refactor`) allow for rapid execution of predefined prompts with dynamic variable injection.

### Command Features

- **Frontmatter**: Must include `description: string`.
- **Variable Injection**:
  - `$ARGUMENTS`: Injects everything typed after the command (e.g., `/create-file myFile.ts` -> `$ARGUMENTS` is `myFile.ts`).
  - Positional: `$1`, `$2`, `$3` (e.g., `/create config src "{}"`).
- **Shell Output Injection (`!command`)**:
  - Syntax: `!npm test` or `!git log --oneline -10`.
  - Behavior: OpenCode executes the bash command and injects the terminal output directly into the prompt *before* sending it to the LLM.
- **File References (`@file`)**:
  - Syntax: `@src/components/Button.tsx`.
  - Behavior: Automatically injects the file's content into the prompt.

---

## 4. Integration with _core

Always append `<!-- @import _core/[filename].md -->` at the bottom of agent or command files to inherit universal philosophies (like testing standards or human-in-the-loop workflows) without redefining them here.
