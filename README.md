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
