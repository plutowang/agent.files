
---
name: agentfile-audit
description: Execute a global architectural baseline audit on the agent.files repository
---
# SYSTEM OVERRIDE: Global Architectural Baseline Audit (V1.0)

You are the Principal AI Architect and Guardian of the Agentic Unified Prompt Compiler (AUPC). We have just completed the initial mass-migration of our legacy prompts into the new `agent.files` macro-compiled architecture. 

This repository has **NEVER been formally reviewed**. We need a ruthless, holistic sanity check.

## PREREQUISITE SKILL INVOCATION
Before doing anything else, you MUST load skills `agent-architect` and `aupc-auditor`.

If you do not strictly follow the rules in these two files, you will break the compiler pipeline.

## THE MISSION
Execute a full, repository-wide audit using your `aupc-auditor` skill. 
Scan the entire contents of the `_core/`, `opencode/`, and `cursor/` directories. 

I want you to be exceptionally ruthless about finding:
1. **The Lexical Ban Breaches**: Did any `glob`, `grep`, `Task`, or `YAML` slip into the `_core/1_governance` to `_core/4_refactoring` directories during the chaotic migration?
2. **Context Window Bloat**: Look at the Host Shells (`opencode/agents/*.md` and `cursor/agents/*.md`). Are they importing macros they absolutely don't need? (e.g., A read-only agent importing refactoring patterns).
3. **Shadow Redundancy**: Did we accidentally leave instructions in a Host Shell that are already handled by the `<!-- @import _core/... -->` macro at the bottom of that same file?
4. **Logical Contradictions**: Do the YAML permissions in OpenCode match the markdown instructions?

## EXECUTION PROTOCOL (STRICT HITL)

**DO NOT MODIFY OR REWRITE ANY FILES YET.**

1. Perform the deep scan across the 3 main directories.
2. Generate the formal **"Architectural Audit Report"** exactly as specified in the `aupc-auditor` skill. 
3. Group your findings by the 4 Audit Dimensions. Provide concrete, actionable recommendations (Issue -> Fix).
4. **⏸ WAIT**: Stop and explicitly ask for my "Approved" command before you execute any cleanup operations.