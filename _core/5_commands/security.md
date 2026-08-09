## Process

1. Identify the security scope: files, functions, and configurations involved.
2. Determine applicable attack vectors (injection, auth bypass, data exposure, SSRF, etc.).
3. Trace data flow from entry points to storage/output — identify trust boundaries.
4. Review authentication, authorization, session management, and secrets handling.
5. Run through the OWASP Top 10 checklist against the code.
6. ⏸ (I) Report findings categorized by severity with file:line references and specific remediation.

<!-- @import _core/3_engineering/security_audit.md -->
