# agent.files (AUPC)

> **A Write-Once, Compile-Anywhere configuration vault for AI Coding Agents.**
>
> This repository acts as the Single Source of Truth for agentic workflows. It uses a custom macro compiler to inject abstract human software engineering philosophies into the specific prompt dialects of diverse AI IDEs (e.g., OpenCode, Cursor).

---

## ATTENTION AI AGENTS (CRITICAL INSTRUCTION)

If you are an AI assistant tasked with reading, modifying, or auditing this repository, **DO NOT PROCEED** using your default assumptions about system prompts.

You **MUST** immediately invoke the `agent-architect` skill located in `.agents/skills/agent-architect/SKILL.md` to load the structural mapping, the Lexical Ban rules, and the macro-compilation logic of this specific repository.

Failure to load the `agent-architect` skill before making modifications will result in broken compilation pipelines and severe context pollution.

---

## Project Architecture at a Glance

This repository strictly separates **Human Philosophy** from **Machine Execution**.

- **`_core/` (The Soul)**: Platform-agnostic software engineering rules, workflows, and shared skills. *Never contains IDE-specific mechanics.*
- **`opencode/` & `cursor/` (The Host Shells)**: IDE-specific bodies containing YAML permissions, `.mdc` globs, and tool routing. They assemble their prompts via `<!-- @import _core/... -->` macros.
- **`dist/` (The Output)**: Ephemeral compiled configurations ready for IDE consumption.
- **`agentc/`**: The blazingly fast Zig compiler that stitches it all together.

---

## The Subcommand Arsenal (Built-in Skills)

This repository comes with its own "Cyber-Immune System" implemented via powerful AI Skills and Commands:

- **`/aupc-auditor`**: Runs a holistic static analysis to find logic conflicts, context bloat, and redundancy across the prompts.
- **`/ide-bootstrapper`**: Automatically generates the full suite of Host Shell templates for a brand new AI IDE target.
- **`/ingest`**: Safely assimilates third-party prompts or new configuration folders, splitting them cleanly into the `_core/` architecture without introducing conflicts.

---

## Quick Start (For Humans)

1. **Make your changes**: Edit the universal rules in `_core/` or tweak the specific routing shells in `opencode/` / `cursor/`.
2. **Compile the Prompts**:

   ```bash
   ./agentc-cli build
   ```

3. **Deploy (Symlink to your global config)**:

   ```bash
   ./agentc-cli link opencode
   ./agentc-cli link cursor
   ```

Enjoy a frictionless, universally synchronized AI coding experience!

---

## Cursor Shell Architecture (Dual-Engine)

The Cursor host shell uses a **Dual-Engine Architecture** consisting of two interlocking systems:

### Engine 1: Contextual Rules (`.cursor/rules/*.mdc`)

File-scoped engineering standards applied via `globs`. When a matching file is open, the rule injects into the main agent's context.

```
---
description: "Short, keyword-rich description for Cursor's intelligent routing"
globs: "**/*.test.*, **/*.spec.*"   # File patterns that trigger this rule
alwaysApply: false                   # false = glob-triggered or AI-routed
---
# Rule Title

Brief shell content (TL;DR of the standard).

**Interlock**: When [specific condition], you MUST delegate to `/subagent-name` to [action].

<!-- @import _core/path/to/standard.md -->
```

- **`globs: ""`** with `alwaysApply: false` = "Apply Intelligently" — Cursor uses the `description` field to decide when to apply. Optimize descriptions with domain keywords.
- **Interlock directives** tell the main agent WHEN to delegate to subagents. They are contextual (file-scoped), not generic.

### Engine 2: Isolated Subagents (`.cursor/agents/*.md`)

Specialized AI assistants with clean context windows, triggered proactively or via `/commands`.

```yaml
---
name: subagent-name
description: "Use proactively when [trigger condition]."
model: fast | inherit        # fast = high-volume; inherit = deep reasoning
readonly: true | false       # true for auditors/reviewers
is_background: false
---
```

- Subagents start with a **clean context** — they must gather their own context.
- Use `model: fast` for verification/search tasks; `model: inherit` for design/security analysis.
- Include "Use proactively when..." in descriptions to enable automatic delegation.

### The Interlock Pattern

Rules and subagents connect via Interlocks:
1. User opens auth file → `security.mdc` activates via globs
2. Rule's Interlock tells main agent: "invoke `/security-auditor`"
3. `/security-auditor` subagent launches with clean context, audits changes
4. Subagent reports findings back to main agent

### Anti-Patterns
- Never import the same `_core/` module in both `AGENTS.md` and a `.mdc` rule (double-injection).
- `AGENTS.md` stays lean: persona + delegation table + governance imports only. No engineering standards.
