---
name: test
description: "Generate unit tests for a file using the AAA pattern"
agent: agent
tools: ['read', 'search', 'edit', 'execute']
---
Generate unit tests for ${input:file:Which file needs tests?} using the AAA pattern.

<red_lines>
<!-- @import _core/3_engineering/testing_aaa/redlines.md -->
</red_lines>

<execution_protocol>
<!-- @import _core/5_commands/test/protocol.md -->
<!-- @import _core/3_engineering/testing_aaa/protocol.md -->
</execution_protocol>

<standards>
<!-- @import _core/3_engineering/testing_aaa/standards.md -->
</standards>

<pre_flight_check>
<!-- @import _core/3_engineering/testing_aaa/preflight.md -->
</pre_flight_check>
