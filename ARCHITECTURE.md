# The AUPC Architecture: Comprehensive System Whitepaper

**Project:** `agent.files`
**Core Concept:** AUPC (Agentic Unified Prompt Compiler)

This document serves as the definitive architectural blueprint for the `agent.files` repository. It details the underlying logic, structural decisions, and engineering philosophies that power this system. It is designed for long-term preservation, onboarding senior engineers, and providing context to advanced AI models tasked with maintaining the repository.

---

## 1. What is AUPC?

**AUPC** stands for **Agentic Unified Prompt Compiler**.

Before AUPC, AI agent configurations (such as Cursor's rules or OpenCode's agent files) were typically maintained as monolithic, isolated text files. Developers mixed high-level software engineering philosophies (e.g., "Use Test-Driven Development") with low-level IDE mechanics (e.g., "Use the glob tool", "Add globs to YAML").

This monolithic approach led to severe issues:
- **Vendor Lock-in:** Migrating prompts from one IDE to another required a complete rewrite.
- **Context Window Bloat:** Agents were loaded with massive system prompts containing rules irrelevant to their specific task.
- **Shadow Redundancy:** Updating a coding standard required manually finding and editing dozens of isolated configuration files.

**The AUPC Solution:**
AUPC treats AI prompts as Infrastructure as Code (IaC). It enforces a strict **Separation of Concerns**, decoupling the universal human philosophies from the machine-specific execution mechanics. It maintains a Single Source of Truth and uses a custom macro compiler to inject these philosophies into IDE-specific templates.

---

## 2. Core Architecture: Separation of Soul and Body

The repository is divided into logical zones, strictly separating universal logic from IDE-specific adapters.

### A. The Universal Source (`_core/` - The Soul)

This directory contains pure, platform-agnostic Markdown files. It dictates *what* good code looks like and *how* an agent should behave logically. It knows absolutely nothing about the IDE it will eventually run inside. It is rigorously divided into a **4-Dimensional Semantic Structure**:

1. **`1_governance/`**: Supreme laws (Human-in-the-Loop gates, execution safety, anti-looping rules).
2. **`2_workflows/`**: Process flows (feature development loops, error triage escalation chains, Git strategies).
3. **`3_engineering/`**: Hard standards for software production (architecture, testing, security audits).
4. **`4_refactoring/`**: Technical debt management and code smell resolution.
5. **`5_commands/` & `skills/`**: Cross-platform slash command logic and atomic tool capabilities (e.g., AWS, Go).

### B. The Goal-Oriented Philosophy & Lexical Ban

To guarantee the cross-platform nature of `_core/`, the system enforces a strict **Lexical Ban** and a **Goal-Oriented Philosophy**. 

Core macros must dictate **what** to do, never **how** to do it. Files in `_core/` MUST NEVER contain words tied to a specific IDE's execution engine or metadata format.
- **Forbidden Terms**: `glob`, `grep`, `Task tool`, `build subagent`, `YAML frontmatter`, `.mdc`, `@Codebase`.
- **Goal-Oriented Formulation**: 
  - *DO NOT WRITE:* "Use the bash tool to run git status."
  - *WRITE:* "Run git status."
  - *DO NOT WRITE:* "Use the explore subagent to search."
  - *WRITE:* "Thoroughly research the existing architecture before modifying files."

### C. The Host Shells (`opencode/`, `cursor/` - The Body)

These directories contain the physical templates required by specific AI IDEs. They contain the YAML frontmatter, JSON configurations, and explicit routing mechanics unique to that platform.

- **OpenCode Paradigm (Multi-Agent System)**: Host shells here explicitly define JSON-like tool `permission` objects (e.g., `bash: deny`, `edit: allow`). They also contain IDE-specific workarounds, such as isolating the `edit_accuracy.md` macro strictly to write-enabled agents to prevent execution deadlocks in read-only agents.
- **Cursor Paradigm (Dual-Engine System)**: Cursor operates on a dual-engine system requiring distinct shell types:
  1. **Contextual Rules (`.cursor/rules/*.mdc`)**: File-scoped, declarative engineering standards applied via `globs`. Each rule contains a brief TL;DR shell plus `<!-- @import -->` macros. Rules also contain **Interlock directives** - contextual instructions telling the main agent WHEN to proactively invoke a subagent using slash syntax (e.g., "When modifying auth flows, you MUST delegate to `/security-auditor`").
  2. **Isolated Subagents (`.cursor/agents/*.md`)**: Specialized, parallel-executing AI assistants with their own clean context windows. Each has YAML frontmatter specifying `name`, `description`, `model` (`fast` for high-volume tasks, `inherit` for deep reasoning), and `readonly`. Subagents gather their own context from scratch.

**Cursor Built-in Subagents (The Context Isolators)**: Cursor natively provides three built-in subagents (`Explore`, `Bash`, `Browser`) that handle token-heavy I/O operations using fast models. These are invoked automatically by Cursor's routing engine. AUPC rules must *never* micromanage their invocation, but instead rely on natural language goals, trusting the IDE's native routing.

### D. Future Scalability (The Extensibility Protocol)

Adding a new IDE target (e.g., GitHub Copilot) is a standardized process:
1. Create a new shell directory (e.g., `copilot/`).
2. Map the IDE's specific format (e.g., `.github/copilot-instructions.md` or `mcp.json`).
3. Write minimalist shells that import the relevant `_core/` macros.
4. Update the `agentc` compiler to build and link the new directory.

---

## 3. The Compilation Engine (`agentc/`)

To assemble the modular architecture, AUPC utilizes a custom compiler written in **Zig**, located in the `agentc/` directory.

### Mechanics

1. **Macro Injection**: The compiler scans Host Shells for `<!-- @import path/to/file.md -->` tags and recursively injects the raw markdown text. It supports infinite nesting.
2. **Circular Dependency Guard**: The compiler maintains a traversal map. If File A imports File B, and File B attempts to import File A, the compiler throws a fatal error to prevent infinite recursion.
3. **Execution Speed**: Built in Zig, the process relies on native memory slicing, completing full repository assemblies in milliseconds.

### CLI Subcommands

- `build`: Parses all Host Shells, resolves macros, copies shared skills, and outputs the finalized configurations into the ephemeral `dist/` directory.
- `link <target>`: Creates absolute symbolic links from `dist/<target>/` to the user's actual IDE configuration directories, enabling instant updates.

---

## 4. The Cyber-Immune System (Meta-Skills)

Because AUPC relies on strict structural integrity, allowing an LLM to blindly edit the configuration files would result in broken compilers or leaked IDE dialects into the `_core/` directory. AUPC is equipped with a suite of "Meta-Skills" that teach the AI how to safely maintain the repository:

1. **`agent-architect` (The Blueprint)**: Forces the AI to internalize the Directory Paradigm, the Lexical Ban, and the Macro Compilation system before proposing structural changes.
2. **`aupc-auditor` (The Static Analyzer)**: Instructs the AI to scan for logic conflicts, context bloat, double-injections, and violations of the Lexical Ban.
3. **`agent-ingestor` (The Assimilator)**: Safely ingests third-party prompts. It strips IDE-specific dialects, splits concepts into the 4D core structure, and wires up macros in the corresponding Host Shells.
4. **`ide-bootstrapper` (The Colonizer)**: Facilitates horizontal expansion. When a new AI IDE is introduced, it maps capability parity and automatically generates a complete suite of Host Shells translated into the new IDE's dialect.

---

## 5. Conclusion

The AUPC architecture represents the evolution from unstructured Prompt Engineering to rigorous **Prompt Infrastructure**. By treating AI instructions with the same discipline as microservices - utilizing dependency injection, static analysis, separation of concerns, and continuous integration - this repository guarantees an AI development environment that is infinitely scalable, thoroughly vendor-agnostic, and highly optimized for context window efficiency.