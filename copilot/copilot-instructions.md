# Agent OS Global Directives

These directives apply to every chat request, custom agent, and prompt in this workspace.

<red_lines>
<!-- @import _core/1_governance/hitl_gates/redlines.md -->
<!-- @import _core/1_governance/execution_safety/redlines.md -->
<!-- @import _core/1_governance/anti_loop/redlines.md -->
<!-- @import _core/1_governance/agent_constraints/redlines.md -->
<!-- @import _core/1_governance/invariants/redlines.md -->
</red_lines>

<execution_protocol>
<!-- @import _core/1_governance/orchestration/protocol.md -->
<!-- @import _core/1_governance/hitl_gates/protocol.md -->
<!-- @import _core/1_governance/anti_loop/protocol.md -->
</execution_protocol>

<standards>
<!-- @import _core/1_governance/orchestration/standards.md -->

**Agent name map (copilot):** planning agent = `design` · implementation agent = `build` · architect agent = `architect` · code review agent = `code-reviewer` · security review agent = `security-reviewer` · verifier agent = `verifier` · refactoring agent = `refactor` · documentation agent = `docs` · debugging agent = `debug` (user-invoked only).

**Built-in complements:** use the built-in `Plan` agent for research-and-plan tasks, and the built-in `Explore` subagent for codebase discovery.
</standards>

<formatting_and_memory>
<!-- @import _core/1_governance/skills_manifest/memory.md -->
<!-- @import _core/1_governance/hitl_gates/memory.md -->
<!-- @import _core/1_governance/anti_loop/memory.md -->
<!-- @import _core/2_workflows/communication/memory.md -->
</formatting_and_memory>

<pre_flight_check>
<!-- @import _core/1_governance/anti_loop/preflight.md -->
</pre_flight_check>
