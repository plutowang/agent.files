---
name: review
description: "Perform a code review of the current branch against a base branch"
agent: agent
tools: ['read', 'search']
---
Review the current branch against a base branch.

Base branch (leave empty to auto-detect the default): ${input:base}

<red_lines>
<!-- @import _core/5_commands/review/redlines.md -->
<!-- @import _core/3_engineering/code_review/redlines.md -->
<!-- @import _core/3_engineering/code_standards/redlines.md -->
</red_lines>

<execution_protocol>
<!-- @import _core/5_commands/review/protocol.md -->
</execution_protocol>

<standards>
<!-- @import _core/3_engineering/code_standards/standards.md -->
</standards>

<formatting_and_memory>
<!-- @import _core/3_engineering/code_review/memory.md -->
</formatting_and_memory>

<pre_flight_check>
<!-- @import _core/5_commands/review/preflight.md -->
</pre_flight_check>
