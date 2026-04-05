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

- **Agents**: Source files in `vscode/agents/` MUST be compiled with the `.agent.md` extension and deployed to `.github/agents/*.agent.md` (or `~/.copilot/agents/`).
- **Commands (Prompts)**: Source files in `vscode/commands/` MUST be compiled with the `.prompt.md` extension and deployed to `.github/prompts/*.prompt.md`.
- **Rules (Instructions)**: Source files in `vscode/rules/` MUST be compiled with the `.instructions.md` extension and deployed to `.github/instructions/*.instructions.md`. A global rule file should be compiled to `.github/copilot-instructions.md`.

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
| `model` | string/array | No | e.g., `['Claude Opus 4.5', 'GPT-5.2']`. Falls back in array order. |
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
