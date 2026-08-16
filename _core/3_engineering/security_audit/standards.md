**Input Validation**
- **All user input is untrusted.** Validate and sanitize at every system boundary.
- Use parameterized queries for all database operations — never concatenate user input into queries.
- Validate file uploads: check type, size, and content — not just the extension.

**Secrets Management**
- **Never hardcode** secrets, API keys, passwords, or tokens in source code.
- Never log sensitive data: passwords, tokens, PII, session identifiers.
- Use environment variables or a secrets manager for all credentials.
- Never commit `.env` files, private keys, or certificates to version control.

**Authentication & Authorization**
- Every protected endpoint must have both **authentication** (who are you?) and **authorization** (are you allowed?).
- Apply **least-privilege** access: grant the minimum permissions needed.
- Use established standards (OAuth 2.0, JWT with proper rotation) — never roll custom crypto.

**Data Protection**
- Encrypt sensitive data at rest and in transit.
- Error messages must not leak internal details (stack traces, file paths, database schemas).
- Configure security headers: CORS, CSP, HSTS, X-Frame-Options.

**OWASP Top 10 Awareness**

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

**Dependency Security**
- Pin dependency versions explicitly.
- Audit dependencies for known CVEs regularly.
- Minimize the dependency surface — fewer dependencies mean fewer attack vectors.

**Download-and-Execute Pattern Set** — when auditing, scan for these patterns (case-insensitive) and flag any hit that instructs fetching and executing remote code:
- `curl`/`wget` piped to any shell or interpreter (`| bash/sh/zsh/python/node/ruby/perl/php/go run`)
- `eval "$(curl …)"` / `source <(curl …)` / `python3 <(curl …)`
- PowerShell: `Invoke-Expression`, `IEX`, `DownloadString`, `irm`, `iex`
- Installer scripts: `install.sh`, `get-pip.py`, `rustup-init`, `nvm`, `oh-my-zsh`, `curl -fsSL`
- Remote-fetch runners: `pip install <url/git+>`, `pipx run`, `uvx`, `go run <url>`, `npx`, `pnpm dlx` — flag; official pinned tools = MEDIUM
- `git clone` followed by execution in the same instruction block
- Docker/image pulls executed by prompts (network-isolated sandbox = LOW, document)
- Remote URLs ending in script extensions (`.sh`, `.ps1`, `.py`, `.rb`) or `raw.githubusercontent.com`
- Toolchain installers: `rustup`, `pyenv`, `asdf`, `mise`, `fnm`
- Global installers: `pip install`, `npm i -g`, `pnpm add -g`, `cargo install`, `go install`, `gem install`, `brew install`, `apt install` — flag; container-install = LOW, document
- Accepted exceptions: `pnpm dlx cdk` (aws skill), `go run github.com/99designs/gqlgen generate` (graphql skill)
