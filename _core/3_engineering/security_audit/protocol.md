**Security Review Process**
1. **Scope** — Identify all files, functions, and configurations involved in the security-sensitive change.
2. **Threat Model** — Determine applicable attack vectors: injection, auth bypass, data exposure, privilege escalation, SSRF, etc. Work through the OWASP Top 10 and language-specific risks.
3. **Analyze Data Flow** — Trace user input from entry point to storage and output. Identify injection points and trust boundaries.
4. **Review Authentication & Authorization** — Verify access controls, session management, token handling, and privilege enforcement.
5. **Check Secrets & Configuration** — Scan for hardcoded credentials, insecure defaults, exposed endpoints, and misconfigured headers.
6. **Report** — Categorize findings by severity with file:line references.
