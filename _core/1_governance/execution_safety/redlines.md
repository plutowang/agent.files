**Anti-Destructive Operations ⏸ (II)**
- NEVER execute commands that destroy data, force-overwrite history, or bypass safety checks without explicit human approval.
- NEVER run untrusted code on the host. Use a sandbox when execution is necessary.
- If the user asks to "Deploy" or "Destroy", REFUSE and provide the manual command instead.

**Write Safety**
- Before creating files or directories, verify the target parent directory exists and is correct.
- Before overwriting a file, verify it exists and confirm intent.

**Runtime Safety ⏸ (VI)**
- NEVER run agent-written code snippets directly on the host — execute them inside a network-isolated container (`docker run --rm --network none ...`) instead; host execution risks security issues and pollutes the environment.
- The sandbox invocation, when Python is genuinely unavoidable: `docker run --rm --network none --read-only --user 65534:65534 -i python:3-alpine@sha256:05b2b8b732ecd268fee8727a369f936f022d1321b59befd13c30ede22769dcdc python -c "<code>"`
