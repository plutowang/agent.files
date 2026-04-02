# agent.files

> **A Write-Once, Compile-Anywhere configuration vault for AI Coding Agents.**
> This repository acts as the Single Source of Truth for agentic workflows, compiling abstract human philosophies and shared skills into IDE-specific prompt dialects (OpenCode, Cursor).

---

## ATTENTION AI AGENTS (CRITICAL META-PROMPT)

If you are an AI reading this repository to help the user modify, add, or delete prompt rules, **YOU MUST STRICTLY ADHERE TO THE FOLLOWING ARCHITECTURAL CONSTRAINTS.**
Ignorance of these rules will break the cross-IDE compilation pipeline.

### 1. Source of Truth Directory Structure

Do not guess file locations. Use the following map to understand the project's architecture.
**ALL modifications must be made in the source directories (`_core/`, `opencode/`, `cursor/`), NEVER in the `dist/` directory.**

    agent.files/
    ├── _core/                     [UNIVERSAL ZONE] Shared Assets & Philosophies
    │   ├── 1_governance/          HITL gates, execution safety, anti-loop
    │   ├── 2_workflows/           Feature dev, error triage, git ops, communication
    │   ├── 3_engineering/         Architecture, API, code standards, testing, security
    │   ├── 4_refactoring/         Smell detection, extraction patterns
    │   └── skills/                Shared skills (Compatible schemas)
    │
    ├── cursor/                    [CURSOR ZONE] Host Shells & Rules
    │   ├── .examples/             Reference templates for AI
    │   ├── agents/                Subagent definitions
    │   ├── commands/              Slash command behaviors
    │   ├── rules/                 .mdc files
    │   └── README.md              Directory-specific schema guide
    │
    ├── opencode/                  [OPENCODE ZONE] Host Shells & Rules
    │   ├── .examples/             Reference templates for AI
    │   ├── agents/                Role-driven agent definitions
    │   ├── commands/              Slash command behaviors
    │   ├── rules/                 Task-specific constraints
    │   └── README.md              Directory-specific schema guide
    │
    ├── agentc.go                  The Macro Compiler Script
    ├── .gitignore
    ├── LICENSE
    └── README.md                  This Meta-Prompt file

### 2. The Shared Skills Architecture (`_core/skills/`)

Skills are the ONLY fully cross-compatible assets. They are stored in `_core/skills/` and distributed to both IDEs without modification during compilation.

**The Unified Skill Frontmatter Schema:**
Because OpenCode ignores unknown frontmatter fields, we author all skills using the Cursor superset schema:

- `name` (Required): Skill identifier (lowercase-hyphens).
- `description` (Required): Describes what the skill does. Used by agents for delegation.
- `license` (Optional): License string.
- `compatibility` (Optional): Environment requirements.
- `metadata` (Optional): Key-value mapping.
- `disable-model-invocation` (Optional, Cursor only): If true, agent will not auto-apply it. (OpenCode safely ignores this field).

### 3. The Lexical Ban (`_core/` Markdown Files)

- **Purpose**: Files under `_core/` subdirectories (like `1_governance/hitl_gates.md`) are injected via macros and apply to ALL IDEs.
- **THE LEXICAL BAN**: These files MUST NEVER contain IDE-specific tool names or subagent names.
- *FORBIDDEN WORDS*: `glob`, `grep`, `Task`, `explore agent`, `build agent`, `YAML frontmatter`.

### 4. The Macro System (Dependency Injection)

We use HTML comments to inject core philosophies into the host shells.
**Syntax:** `<!-- @import _core/1_governance/hitl_gates.md -->`

- If you create a new universal rule in `_core/`, you MUST ensure it is imported via this macro at the bottom of the respective host shell files inside `opencode/` and `cursor/`.

### 5. Modifying Assets (Action Guide for AI)

> **CRITICAL PRE-FLIGHT CHECK:**
> Before creating or editing ANY file inside the `opencode/` or `cursor/` directories, you **MUST first read** the corresponding `README.md` and `.examples/example_*.md` files in that target directory.
> These files contain the exact YAML schemas, field definitions, and formatting rules required for that specific IDE. **DO NOT guess the frontmatter schema!**

- **Add a universal safety rule**: Create/edit a file in `_core/` (NOT in `_core/skills/`).
- **Add a new capability/tool**: Create a new Skill markdown file in `_core/skills/`.
- **Add an IDE-specific agent or rule**: Edit the respective `agents/` or `rules/` folder inside `opencode/` or `cursor/`.

---

## How to Compile (For Humans)

This project uses a custom script to compile the Markdown files and distribute the shared skills into IDE-ready configurations.

**Run Compiler:**

    go run agentc.go

**Output Locations:**
Compiled assets are generated into the `dist/` directory:

- `dist/opencode/` (Includes injected agents and copied shared skills)
- `dist/cursor/` (Includes injected rules and copied shared skills)
