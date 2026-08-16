---
name: security
description: "Perform a security audit on a file or component"
agent: agent
tools: ['read', 'search']
---
Perform a security audit on ${input:target:Which file or component should be audited?}.

<red_lines>
<!-- @import _core/3_engineering/security_audit/redlines.md -->
</red_lines>

<execution_protocol>
<!-- @import _core/3_engineering/security_audit/protocol.md -->
</execution_protocol>

<standards>
<!-- @import _core/3_engineering/security_audit/standards.md -->
</standards>

<formatting_and_memory>
<!-- @import _core/3_engineering/security_audit/memory.md -->
</formatting_and_memory>

<pre_flight_check>
<!-- @import _core/3_engineering/security_audit/preflight.md -->
</pre_flight_check>
