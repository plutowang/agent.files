## Security Standards

### Input Validation

- **All user input is untrusted.** Validate and sanitize at every system boundary.
- Use parameterized queries for all database operations — never concatenate user input into queries.
- Validate file uploads: check type, size, and content — not just the extension.

### Secrets Management

- **Never hardcode** secrets, API keys, passwords, or tokens in source code.
- Never log sensitive data: passwords, tokens, PII, session identifiers.
- Use environment variables or a secrets manager for all credentials.
- Never commit `.env` files, private keys, or certificates to version control.

### Authentication & Authorization

- Every protected endpoint must have both **authentication** (who are you?) and **authorization** (are you allowed?).
- Apply **least-privilege** access: grant the minimum permissions needed.
- Use established standards (OAuth 2.0, JWT with proper rotation) — never roll custom crypto.

### Data Protection

- Encrypt sensitive data at rest and in transit.
- Error messages must not leak internal details (stack traces, file paths, database schemas).
- Configure security headers: CORS, CSP, HSTS, X-Frame-Options.

### OWASP Top 10 Awareness

When reviewing or writing code that handles user input, authentication, or data access, verify against:

1. Broken Access Control
2. Cryptographic Failures
3. Injection
4. Insecure Design
5. Security Misconfiguration
6. Vulnerable & Outdated Components
7. Identification & Authentication Failures
8. Software & Data Integrity Failures
9. Security Logging & Monitoring Failures
10. Server-Side Request Forgery (SSRF)

### Dependency Security

- Pin dependency versions explicitly.
- Audit dependencies for known CVEs regularly.
- Minimize the dependency surface — fewer dependencies mean fewer attack vectors.

## Security Review Process

1. **Scope** — Identify all files, functions, and configurations involved in the security-sensitive change.
2. **Threat Model** — Determine applicable attack vectors: injection, auth bypass, data exposure, privilege escalation, SSRF, etc. Work through the OWASP Top 10 and language-specific risks.
3. **Analyze Data Flow** — Trace user input from entry point to storage and output. Identify injection points and trust boundaries.
4. **Review Authentication & Authorization** — Verify access controls, session management, token handling, and privilege enforcement.
5. **Check Secrets & Configuration** — Scan for hardcoded credentials, insecure defaults, exposed endpoints, and misconfigured headers.
6. **Report** — Categorize findings by severity with file:line references.

## Security Checklist

- [ ] Input validation on all external data (user input, API params, file uploads)
- [ ] Output encoding / escaping applied before rendering
- [ ] SQL/NoSQL injection prevention (parameterized queries, no string concatenation)
- [ ] Authentication checks on all protected endpoints
- [ ] Authorization checks — principle of least privilege enforced
- [ ] Secrets not hardcoded — loaded from environment or secret manager
- [ ] Cryptographic primitives are standard (no custom crypto)
- [ ] Sensitive data encrypted at rest and in transit
- [ ] CORS, CSP, and security headers configured properly
- [ ] Rate limiting on authentication and public endpoints
- [ ] File uploads validated (type, size, content)
- [ ] Error messages do not leak internal details (stack traces, DB schema)
- [ ] Dependencies pinned and free of known CVEs
- [ ] Logging does not include sensitive data (passwords, tokens, PII)

## Security Review Output Format

For each finding:

| Field              | Content                               |
| ------------------ | ------------------------------------- |
| **Severity**       | Critical / High / Medium / Low / Info |
| **Location**       | file:line                             |
| **Description**    | What the vulnerability is             |
| **Impact**         | What an attacker could do             |
| **Recommendation** | Specific remediation                  |

## Rules

- Prioritize findings by severity and exploitability.
- Do not report theoretical risks without evidence in the actual code.
- If no issues found, say so clearly — do not invent problems to appear thorough.
- Focus only on security — do not review code style or business logic.
