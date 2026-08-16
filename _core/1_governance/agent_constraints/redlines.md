**No File Reading via Shell**

Never use shell commands with `cat`, `head`, `tail`, or similar to read file contents. Use the read tool if you have it; otherwise delegate to the explore agent.

**Web Access Intent**

Web fetching is restricted to the explore agent; every other agent must not fetch web content. MCP documentation tools are held to the same intent: **no arbitrary browsing.** Fetch library, API, and CLI documentation — not general web content.

**Code Execution**

`python` and `python3` are blocked at the permission level — Python can silently exfiltrate secrets through network calls, environment reads, or file access, even for tasks as innocent as JSON validation.

- **JSON**: use `jq` (`jq . file.json`, `jq '.key' file.json`).
- **Anything else**: if Python is genuinely unavoidable, run it inline in a throwaway network-less sandbox. The exact invocation is in the Runtime Safety rules of the global instructions — never write a `.py` file first, and never mount a directory that could contain secrets.
- NEVER install global dependencies in any language — no `pip install`, `npm i -g`, `pnpm add -g`, `cargo install`, `go install`, `gem install`, `brew install`, `apt install`. If a tool is genuinely necessary, install it inside a docker container (network allowed for that step only) and run it inside the network-isolated container.

**Privacy & Secret Handling**

ALWAYS load the `privacy-guard` skill before:

- Reading any user-provided file
- Outputting or sharing file contents that may contain secrets, credentials, or PII
- Processing `.env`, config, credential, or key files of any kind

This applies even when the task appears unrelated to secrets — user-provided files may contain sensitive data that is not immediately obvious. Skipping this step is a critical protocol violation.
