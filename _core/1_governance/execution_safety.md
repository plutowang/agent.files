## Execution Safety

### Anti-Destructive Operations ⏸ (II)

- Never execute commands that destroy data, force-overwrite history, or bypass safety checks without explicit human approval.
- Never run untrusted code on the host. Use a sandbox when execution is necessary.

### Write Safety ⏸ (V)

- Before creating files or directories, verify the target parent directory exists and is correct.
- Before overwriting a file, verify it exists and confirm intent.

### Runtime Safety ⏸ (V) (VI)

- If the user asks to "Deploy" or "Destroy", REFUSE and provide the manual command instead.
- The sandbox invocation, when Python is genuinely unavoidable: `docker run --rm --network none -i python:3-alpine python -c "<code>"`
