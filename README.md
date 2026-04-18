# Agentic Unified Prompt Compiler (AUPC)

> **Infrastructure as Code (IaC) for AI Agent Prompts.**

AUPC is a centralized, compiler-driven framework for managing, scaling, and deploying AI agent instructions across multiple IDEs and agentic platforms.

## ATTENTION AI AGENTS (CRITICAL INSTRUCTION)

If you are an AI assistant tasked with reading, modifying, or auditing this repository, **DO NOT PROCEED** using your default assumptions about system prompts.

You **MUST** immediately invoke the `agent-architect` skill located in `.agents/skills/agent-architect/SKILL.md` to load the structural mapping, the Lexical Ban rules, and the macro-compilation logic of this specific repository. Failure to do so will result in broken compilation pipelines and severe context pollution.

---

## The Problem: Prompt Monoliths & Vendor Lock-in

As AI-assisted development evolves, maintaining prompts across different environments (OpenCode, Cursor, GitHub Copilot) becomes a nightmare.

* **Vendor Lock-in:** Writing rules specific to one IDE's toolset makes migrating impossible.
* **Context Bloat:** Monolithic system prompts consume valuable token windows with irrelevant instructions.
* **Redundant Maintenance:** Fixing a core engineering standard requires updating dozens of isolated files across multiple tools.

## The Solution: A Single Source of Truth

AUPC solves this by treating agent instructions like source code. We maintain a **Single Source of Truth** in the `_core/` directory, containing abstract, platform-agnostic software engineering philosophies.

Using our custom Zig compiler (`agentc`), these core macros are injected via `<!-- @import _core/... -->` tags into **Host Shells** - minimalist, IDE-specific adapter files that handle the unique routing, YAML frontmatter, and tool permissions for each target platform.

Write your engineering standards once. Compile them everywhere.

---

## Quick Start

### 1. Build the Prompts

This resolves all macros, performs circular dependency checks, and generates the final IDE-specific files in the `dist/` directory.

```bash
./agentc-cli build
```

### 2. Deploy to Your IDE

Symlink the compiled outputs to your local IDE configuration directories.

```bash
./agentc-cli link opencode
./agentc-cli link cursor
```

Enjoy a frictionless, universally synchronized AI coding experience!

---

## Architecture at a Glance

### The Universal Source (`_core/`)

Platform-agnostic software engineering rules, workflows, and shared skills. *Never contains IDE-specific mechanics.*

### The Host Shells (`opencode/`, `cursor/`, `copilot/`)

The physical bodies. They assemble their prompts via macros and handle platform-specific routing.

#### OpenCode Paradigm (Multi-Agent)

Relies on explicit subagent routing and strict YAML permission blocks to prevent execution deadlocks.

#### Cursor Paradigm (Dual-Engine)

The Cursor host shell uses two interlocking systems:

1. **Engine 1: Contextual Rules (`.cursor/rules/*.mdc`)**
   File-scoped engineering standards applied via `globs`. They contain **Interlock directives** telling the main agent *when* to delegate to subagents.
2. **Engine 2: Isolated Subagents (`.cursor/agents/*.md`)**
   Specialized AI assistants (e.g., `verifier`, `architect`) with clean context windows, triggered proactively or via `/commands`. Uses `model: fast` for high-volume tasks and `model: inherit` for deep reasoning.

**Anti-Patterns to Avoid:**

* Never import the same `_core/` module in both global files and `.mdc` rules (double-injection wastes tokens).
* Never explicitly declare Cursor's built-in subagents (`Explore`, `Bash`, `Browser`), as it interferes with native auto-delegation.

---

## The Subcommand Arsenal (Built-in Skills)

This repository comes with its own "Cyber-Immune System" implemented via powerful AI Skills:

* **`/aupc-auditor`**: Runs a holistic static analysis to find logic conflicts, context bloat, and redundancy.
* **`/ide-bootstrapper`**: Automatically generates Host Shell templates for a brand new AI IDE target.
* **`/agent-ingestor`**: Safely assimilates third-party prompts into the `_core/` architecture without conflicts.
