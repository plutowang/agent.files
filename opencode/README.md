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

- **`permission`**: Controls tool access. Every key nests under this single block. The valid keys are exactly `read`, `edit`, `glob`, `grep`, `bash`, `task`, `skill`, `lsp`, `question`, `webfetch`, `websearch`, `external_directory`, `doom_loop`.
  - `edit`: File modification — one key covering `edit`, `write`, and `apply_patch`.
  - `read` / `glob` / `grep`: File and codebase access.
  - `webfetch` / `websearch`: Internet access.
  - `bash`: Terminal access. Accepts patterns (e.g., `"rm*": deny`, `"git diff": allow`).
  - `task`: Controls which *other subagents* this agent can invoke, keyed by subagent name. `deny` removes that subagent from this agent's visibility entirely.
  - `skill` / `question` / `lsp`: Skill loading, asking the user, and language-server queries.
  - `external_directory` / `doom_loop`: Safety guards — touching paths outside the project, and the same call repeating 3× with identical input.

Three rules that decide whether a permission block actually works:

1. **Unspecified keys default to `allow`.** An absent key is a *grant*, not a restriction.
2. **The last matching pattern wins.** Always write the broad pattern first: `{"*": "deny", "explore": "allow"}` allows only `explore`, whereas the reverse order allows everything.
3. **An unrecognised key is a silent no-op, not an error.** A line like `list: deny` reads as a restriction and enforces nothing. Check every key against the valid set above.

### CRITICAL: The Timestamp Workaround

OpenCode has a strict security mechanism for the `edit` and `write` tools.
If an agent requires the ability to modify files, it **MUST** also have `read: allow` in its permission block. Furthermore, the prompt MUST explicitly instruct the agent to **call `read` on a file immediately before modifying it**. Subagent reads (e.g., from `explore`) do NOT satisfy this timestamp check.

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

Always append `<!-- @import _core/1_governance/hitl_gates/protocol.md -->` (or similar) at the bottom of agent or command files to inherit universal philosophies (like testing standards or human-in-the-loop workflows) without redefining them here. `_core` concepts are organized as folders of section fragments (`redlines.md`, `protocol.md`, `memory.md`, `preflight.md`) — import the fragments your shell needs.
