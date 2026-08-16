# VS Code Copilot Configurations Guide

This directory contains the source files for VS Code Copilot Custom Agents, Prompt Files (Slash Commands), and Custom Instructions (Rules).

## Reference Links

- Custom Agents Documentation: <https://code.visualstudio.com/docs/copilot/customization/custom-agents>
- Prompt Files Documentation: <https://code.visualstudio.com/docs/copilot/customization/prompt-files>
- Custom Instructions Documentation: <https://code.visualstudio.com/docs/copilot/customization/custom-instructions>
- Tools Reference: <https://code.visualstudio.com/docs/copilot/reference/copilot-vscode-features#_chat-tools>

---

## 1. File Extension & Path Mapping (AUPC Compiler Target)

Unlike other IDEs that use standard `.md` files, VS Code Copilot strictly requires specific file extensions and locations. When the `agentc` compiler processes this directory, it must output to the following locations in the target workspace (or global user profile):

- **Agents**: Source files in `copilot/agents/` MUST be compiled with the `.agent.md` extension and deployed to `.github/agents/*.agent.md` (or `~/.copilot/agents/`).
- **Commands (Prompts)**: Source files in `copilot/commands/` MUST be compiled with the `.prompt.md` extension and deployed to `.github/prompts/*.prompt.md`.
- **Rules (Instructions)**: Source files in `copilot/rules/` MUST be compiled with the `.instructions.md` extension and deployed to `.github/instructions/*.instructions.md`. A global rule file should be compiled to `.github/copilot-instructions.md`.

---

## 2. Agent Configuration Schema (*.agent.md)

Custom Agents define persistent personas with specific tool restrictions and handoffs. They require YAML frontmatter followed by Markdown instructions.

### Frontmatter Fields

| Field | Type | Required | Description |
| :--- | :--- | :--- | :--- |
| `name` | string | No | The name of the custom agent. Defaults to filename if omitted. |
| `description` | string | No | Brief description shown as placeholder text in the chat input. |
| `argument-hint` | string | No | Hint text shown in the chat input field to guide user interaction. |
| `tools` | array | No | List of available tools or tool sets (e.g., `['web/fetch', 'search']`). |
| `agents` | array | No | Subagents available to this agent. Use `*` for all, or `[]` for none. |
| `model` | string/array | No | e.g., `['Claude Sonnet 5', 'GPT-5.6 Terra']`. Falls back in array order. |
| `user-invocable`| boolean | No | Set to `false` to hide from the chat dropdown (default `true`). |
| `disable-model-invocation`| boolean | No | Set to `true` to prevent being invoked as a subagent (default `false`). |
| `target` | string | No | The target environment (`vscode` or `github-copilot`). |
| `mcp-servers` | array | No | List of Model Context Protocol (MCP) server config JSONs. |
| `handoffs` | array | No | Sequential workflow transitions to other agents. |
| `hooks` | array | No | Hook commands scoped to this agent (Preview feature). |

### Handoffs Schema

Handoffs create guided sequential workflows (e.g., Planning -> Implementation -> Review).

- `label`: Display text on the handoff button.
- `agent`: Target agent identifier.
- `prompt`: Prompt text to send to the target agent.
- `send`: Boolean to auto-submit the prompt (default `false`).
- `model`: Optional target model.

---

## 3. Prompt Files / Commands Schema (*.prompt.md)

Prompt files (slash commands) are used for lightweight, single-task prompts invoked manually via `/`.

### Frontmatter Fields

| Field | Type | Required | Description |
| :--- | :--- | :--- | :--- |
| `name` | string | No | The slash command name (used after typing `/`). Defaults to filename. |
| `description` | string | No | Short description of the prompt. |
| `argument-hint` | string | No | Hint text shown in the chat input field. |
| `agent` | string | No | Agent to run the prompt (`ask`, `agent`, `plan`, or custom agent name). |
| `model` | string | No | Language model to use. |
| `tools` | array | No | List of tools available for this specific prompt. |

### Body Mechanics & User Input

- **User Input Variables**: Use `${input:variableName}` or `${input:variableName:placeholder}` to explicitly prompt the user for additional information at runtime.

---

## 4. Custom Instructions Schema (*.instructions.md)

Custom instructions automatically influence how AI generates code based on context. In the AUPC architecture, these map to our domain standards.

### Global vs. File-Based

- **Always-on Instructions**: A single file named `copilot-instructions.md` placed in the `.github/` folder. It applies to ALL chat requests.
- **File-based Instructions**: Files named `*.instructions.md` that apply conditionally based on glob patterns.

### Frontmatter Fields (File-Based Instructions only)

| Field | Required | Description |
| :--- | :--- | :--- |
| `name` | No | Display name shown in the UI. Defaults to the file name. |
| `description` | No | Short description shown on hover in the Chat view. |
| `applyTo` | No | Glob pattern defining which files this applies to automatically (e.g., `**/*.ts,**/*.tsx`). Use `**` for all files. |

---

## 5. Tool & File References

### Inline Syntax

- **Tools**: To reference a tool explicitly in the markdown body, use the `#tool:<tool-name>` syntax (e.g., `#tool:web/fetch`).
- **Files**: Use standard Markdown links to reference other files in the workspace.

### Available Built-in Tools

You can restrict agents and prompts using either broad **Tool Sets** or specific **Individual Tools** in the `tools` frontmatter array.

**Tool Sets (Grants access to grouped capabilities):**

- `agent`, `browser`, `edit`, `execute`, `read`, `search`, `web`

**Individual Tools:**

- **Agent**: `agent/runSubagent`
- **Edit**: `edit/createDirectory`, `edit/createFile`, `edit/editFiles`, `edit/editNotebook`
- **Execute**: `execute/createAndRunTask`, `execute/getTerminalOutput`, `execute/runInTerminal`, `execute/runNotebookCell`, `execute/testFailure`
- **Read**: `read/getNotebookSummary`, `read/problems`, `read/readFile`, `read/readNotebookCellOutput`, `read/terminalLastCommand`, `read/terminalSelection`
- **Search**: `search/changes`, `search/codebase`, `search/fileSearch`, `search/listDirectory`, `search/textSearch`, `search/usages`
- **Web**: `web/fetch`
- **Standalone**: `newWorkspace`, `selection`, `todos`, `vscode/askQuestions`, `vscode/extensions`, `vscode/getProjectSetupInfo`, `vscode/installExtension`, `vscode/runCommand`, `vscode/VSCodeAPI`

**Third-Party Tools:**

- **MCP Servers**: Use `<server-name>/*` to grant access to all tools from a specific Model Context Protocol server.

---

## 6. Integration with _core (Dependency Injection)

Whether building an agent, a prompt file, or custom instructions, append `<!-- @import _core/[filename].md -->` at the bottom of the host shells to inherit universal philosophies without violating the Lexical Ban.

Do NOT redefine universal software engineering philosophies in this directory. Rely entirely on the macro compiler to inject the rules from `_core/`.

---

## 7. Conflict Avoidance (Reserved Names)

Do NOT create custom artifacts with these names — they collide with VS Code Copilot built-ins:

- **Agent names:** `Agent`, `Plan`, `Explore`, `ask` (built-in roles/subagents; names are case-sensitive).
- **Slash commands:** `/explain`, `/fix`, `/tests`, `/setupTests`, `/plan`, `/doc`, `/debug`, `/troubleshoot`, `/new`, `/init`, `/search`, `/clear`, `/compact`, `/fork`, `/agents`, `/hooks`, `/instructions`, `/prompts`, `/skills`, `/create-*`, `/yolo`, `/autoApprove`, `/fixTestFailure`.
- This expansion therefore names its commands `explain-code` and `fix-issue` (instead of `explain`/`fix`). `commit`, `refactor`, `review`, `security`, and `test` are verified safe in the default Local harness.
- Custom agents appear in the Agents dropdown, not the `@` participant list (`@github`, `@terminal`, `@vscode`).

## 8. Global Instructions: Choose One File Only

Ship **only** `.github/copilot-instructions.md` as the always-on global shell. VS Code loads both `copilot-instructions.md` and `AGENTS.md` on every request (combined, no guaranteed order), and the official in-repo reference explicitly says: "Use **only one**—not both." Keep the global file lean — GitHub's guidance: instructions no longer than 2 pages.

## 9. Deployment

1. `./agentc-cli build` compiles to `dist/copilot/`.
2. Per-project (workspace): copy
   - `dist/copilot/agents/` → `<project>/.github/agents/`
   - `dist/copilot/commands/` → `<project>/.github/prompts/`
   - `dist/copilot/rules/` → `<project>/.github/instructions/` (nested subdirectories are supported)
   - `dist/copilot/copilot-instructions.md` → `<project>/.github/copilot-instructions.md`
   - `dist/copilot/mcp.json` → `<project>/.github/mcp.json`
3. User-level (optional): `./agentc-cli link copilot` symlinks `dist/copilot/agents/` → `~/.copilot/agents/`.
4. Prompt files work with local agents only; for Agent Host sessions, migrate them to skills (SKILL.md).

## 10. Model Names

Model arrays fall back in order (`['Claude Sonnet 5', 'GPT-5.6 Terra']` = try Sonnet first). Arrays are the defensive pattern: plan-gated or retired models are skipped, not errors.

- **Deep reasoning (this expansion):** `['Claude Sonnet 5', 'GPT-5.6 Terra', 'GPT-5.4']`
- **Fast/utility (this expansion):** `['GPT-5.6 Luna', 'Claude Haiku 4.5', 'GPT-5 mini']`

**Copilot Pro note (verified 2026-08-16):** `Claude Opus 4.5/4.6` are Business/Enterprise-only and retire 2026-09-01; no Opus 4.7+/5 or GPT-5.5/5.6 Sol on Pro. There is no model named `GPT-5.6` alone — use `GPT-5.6 Luna`/`Sol`/`Terra`. The authoritative per-plan list: <https://docs.github.com/en/copilot/reference/ai-models/supported-models>.
