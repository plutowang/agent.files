# The AUPC Architecture: Comprehensive System Whitepaper

**Project:** `agent.files`
**Core Concept:** AUPC (Agentic Unified Prompt Compiler)

This document serves as the definitive architectural blueprint for the `agent.files` repository. It details the underlying logic, structural decisions, and engineering philosophies that power this system. It is designed for long-term preservation, onboarding senior engineers, and providing context to advanced AI models tasked with maintaining the repository.

---

## 1. What is AUPC?

**AUPC** stands for **Agentic Unified Prompt Compiler**.

Before AUPC, AI agent configurations (such as Cursor's `AGENTS.md` or OpenCode's `agents/*.md` files) were typically maintained as monolithic, isolated text files. Developers mixed high-level software engineering philosophies (e.g., "Use Test-Driven Development") with low-level IDE mechanics (e.g., "Use the `glob` tool", "Add `globs: *.ts` to YAML").

This monolithic approach led to severe issues:

- **Vendor Lock-in:** Migrating prompts from one IDE to another required a complete rewrite.
- **Context Window Bloat:** Agents were loaded with massive system prompts containing rules irrelevant to their specific task.
- **Shadow Redundancy:** Updating a coding standard required manually finding and editing dozens of isolated agent configuration files.

**The AUPC Solution:**
AUPC treats AI prompts as Infrastructure as Code (IaC). It enforces a strict **Separation of Concerns**, decoupling the universal human philosophies from the machine-specific execution mechanics. It maintains a Single Source of Truth and uses a custom macro compiler to inject these philosophies into IDE-specific templates.

---

## 2. Core Architecture: Separation of Soul and Body

The repository is divided into two distinct logical zones:

### A. The Universal Source (`_core/` - The Soul)

This directory contains pure, platform-agnostic Markdown files. It dictates *what* good code looks like and *how* an agent should behave logically. It knows absolutely nothing about the IDE it will eventually run inside.

To prevent the `_core/` directory from becoming an unmanageable flat list of rules, it is rigorously divided into a **4-Dimensional Semantic Structure**:

1. **`1_governance/` (The Iron Laws)**: Supreme directives that override all other logic. Includes Human-in-the-Loop (HITL) approval gates, execution safety (Docker sandboxing, Git destruct prevention), and anti-looping rules for read-only commands.
2. **`2_workflows/` (Standard Operating Procedures)**: How development processes flow over time. Includes feature development loops, error triage escalation chains, Git branch strategies, and communication formats.
3. **`3_engineering/` (Code Quality & Architecture)**: Hard standards for software production. Includes API contract design, defensive coding standards, security audit rules, and AAA testing patterns.
4. **`4_refactoring/` (Technical Debt Management)**: Rules specific to cleaning up existing code, including code smell detection and safe extraction patterns.
5. **`5_commands/` & `skills/`**: Cross-platform slash command logic and atomic tool capabilities (e.g., AWS, Go, Privacy Guard) that are completely portable.

### B. The Lexical Ban (Purity Enforcement)

To guarantee the cross-platform nature of `_core/`, the system enforces a strict **Lexical Ban**. Files in `_core/` (excluding specific `skills/`) MUST NEVER contain words tied to a specific IDE's execution engine or metadata format.

- *Forbidden Terms*: `glob`, `grep`, `Task tool`, `build subagent`, `YAML frontmatter`, `.mdc`, `@Codebase`.
- *Built-in Subagent Awareness*: Cursor natively provides `Explore`, `Bash`, and `Browser` subagents with automatic routing. Rules MUST NOT manually micromanage their invocation (e.g., "Delegate to the explore subagent"). Instead, state the goal (e.g., "Thoroughly analyze the codebase") and trust the IDE's routing engine.
- *Rule Formulation*: Write goal-oriented instructions. Instead of "Use the explore subagent to search", write "Thoroughly research the existing architecture in the codebase before modifying files." Instead of "Run git status using the bash tool", write "Run git status."

### C. The Host Shells (`opencode/`, `cursor/` - The Body)

These directories contain the physical templates required by specific AI IDEs. They contain the YAML frontmatter, JSON configurations, and explicit routing mechanics unique to that platform.

- **OpenCode (Multi-Agent System)**: Host shells here (e.g., `agents/build.md`) explicitly define tool `permission` objects (e.g., `bash: deny`, `edit: allow`). They also contain IDE-specific workarounds, such as the explicit instruction to "call the `read` tool before editing" to bypass OpenCode's internal timestamp security checks.
- **Cursor (Dual-Engine System)**: Cursor's architecture consists of two interlocking engines:
  1. **Contextual Rules** (`.cursor/rules/*.mdc`): File-scoped, declarative engineering standards applied via `globs`. When a user opens a file matching the glob pattern, the rule's content is injected into the main agent's context. Each rule contains a brief TL;DR shell plus `<!-- @import -->` macros for full standards. Rules also contain **Interlock directives** — contextual instructions telling the main agent WHEN to proactively invoke a subagent (e.g., "When modifying auth flows, you MUST delegate to `/security-auditor`").
  2. **Isolated Subagents** (`.cursor/agents/*.md`): Specialized, parallel-executing AI assistants with their own clean context windows. Each has YAML frontmatter specifying `name`, `description` (with "Use proactively when..." phrasing for automatic delegation), `model` (`fast` for high-volume tasks, `inherit` for deep reasoning), `readonly`, and `is_background`. Subagents gather their own context from scratch — they do not inherit the main agent's conversation.
  
  The **AGENTS.md** remains lean: persona, principles, subagent delegation table, post-build triggers, and governance imports only. The **Interlock Pattern** connects the two engines: `.mdc` rules fire when relevant files are open and instruct the main agent to delegate to subagents using the explicit SLASH (`/`) syntax (e.g., `/verifier`), creating a file-aware delegation chain. Invoking rules via globs or `@` context mounting is strictly separated from invoking Subagents via `/commands`.

### Cursor Built-in Subagents (The Context Isolators)

Cursor natively provides three built-in subagents that handle token-heavy, noisy I/O operations using fast models with strict context isolation:

- **Explore**: Codebase search and file discovery
- **Bash**: Shell command execution
- **Browser**: Web access and documentation retrieval

These subagents are invoked automatically by Cursor's routing engine — no explicit configuration or delegation instructions are needed. AUPC rules should lean into this by encouraging broad research and testing goals using natural language (e.g., "Thoroughly analyze the codebase"), trusting the IDE to route to the appropriate built-in subagent. Explicitly micromanaging invocation (e.g., "Use the explore subagent to search") is counterproductive and interferes with the routing engine.

---

## 3. The Compilation Engine (`agentc`)

To assemble the modular architecture, AUPC utilizes a custom compiler written in **Zig**, located in the `agentc/` directory.

### The Macro System

Host Shells inject the universal philosophies using an HTML-comment macro syntax:
`<!-- @import _core/1_governance/execution_safety.md -->`

### Compiler Mechanics

1. **Recursive Resolution**: The compiler scans Host Shells for the `@import` tag, reads the target file, and replaces the macro with the raw markdown text. It supports infinite nesting (core files importing other core files).
2. **Circular Dependency Guard**: The compiler maintains a traversal map. If File A imports File B, and File B attempts to import File A, the compiler throws a fatal error to prevent infinite recursion and memory exhaustion.
3. **Execution Speed**: Built in Zig, the compilation process relies on native memory slicing rather than heavy regex engines, completing full repository assemblies in milliseconds.

### CLI Subcommands

- `build`: Parses all Host Shells, resolves macros, copies shared skills, and outputs the finalized configurations into the ephemeral `dist/` directory.
- `link <target>`: Creates absolute symbolic links from `dist/<target>/` to the user's actual IDE configuration directories (e.g., `~/.config/opencode/` or `~/.cursor/`), enabling instant updates across the operating system without manual copying.

---

## 4. The Cyber-Immune System (Meta-Skills)

Because AUPC relies on strict structural integrity, allowing an LLM to blindly edit the repository's configuration files would quickly result in broken compilers or leaked IDE dialects into the `_core/` directory.

To solve this, AUPC is equipped with a suite of "Meta-Skills" that teach the AI how to safely maintain and evolve the repository itself.

1. **`agent-architect` (The Blueprint)**: This skill forces the AI to internalize the Directory Paradigm, the Lexical Ban, and the Macro Compilation system. It must be loaded before the AI is allowed to propose any changes to the repository structure.
2. **`aupc-auditor` (The Static Analyzer)**: A holistic audit skill. It instructs the AI to scan the repository for:
   - *Shadow Redundancy*: Host Shells manually stating rules already covered by their imported macros.
   - *Logic Conflicts*: YAML permissions contradicting injected markdown instructions.
   - *Context Bloat*: Read-only agents importing massive, irrelevant architectural macros.
   - *Purity Breaches*: Violations of the Lexical Ban in the `_core/` directory.
3. **`agent-ingestor` (The Assimilator)**: Allows the safe ingestion of third-party prompts. It analyzes new snippets, strips them of IDE-specific dialects, splits the concepts into the `_core/` 4D structure, and wires up the `<!-- @import -->` macros in the corresponding Host Shells, checking for contradictions with existing supreme laws.
4. **`ide-bootstrapper` (The Colonizer)**: Facilitates horizontal expansion. When a new AI IDE is introduced, this skill reads the new IDE's `README.md` and `.examples/`, mapping capability parity. It then automatically generates a complete suite of Host Shells translated into the new IDE's dialect, instantly porting the entire AUPC engineering philosophy to the new platform.

---

## 5. Conclusion

The AUPC architecture represents the evolution from unstructured "Prompt Engineering" to rigorous **Prompt Infrastructure**. By treating AI instructions with the same discipline as microservices—utilizing dependency injection, static analysis, separation of concerns, and continuous integration—this repository guarantees an AI development environment that is infinitely scalable, thoroughly vendor-agnostic, and highly optimized for context window efficiency.
