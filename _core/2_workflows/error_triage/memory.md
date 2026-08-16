**Retrieval & Tools**
- Prefer the retrieval agent for file discovery and search — finding symbols, error messages, and callers, or any broad discovery spanning multiple files or external context.
- Read whole files directly when their contents are load-bearing — files you will edit, error logs, trace targets.
- Read source files and captured logs directly — never read files via shell commands.
- Use shell for tests and process inspection only — no write commands, no package installs.
**Output Format (build errors)**
For each error group: root cause → files fixed → verification result (pass/fail).
