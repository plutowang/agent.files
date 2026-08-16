Before completing a security review, verify:

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
