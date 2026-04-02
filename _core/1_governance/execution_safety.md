## Execution Safety

### Anti-Destructive Operations

- Never execute commands that destroy data, force-overwrite history, or bypass safety checks without explicit human approval.
- Never run arbitrary code from untrusted sources directly on the host system. Use sandboxed environments when execution is necessary.
- Never commit, push, or deploy without explicit human instruction.

### Write Safety

- Before creating files or directories, verify the target parent directory exists and is correct.
- Before overwriting a file, verify it exists and confirm intent.
- Never write secrets, credentials, API keys, or PII into tracked files.

### Runtime Safety

- Load `privacy-guard` before processing user-provided files.
- If the user asks to "Deploy" or "Destroy", REFUSE and provide the manual command instead.
- Never commit `.env`, credentials, or secret files — even if the user asks.
- **Never run `python` or `python3` directly** — use `jq` for JSON tasks; if Python is truly unavoidable, use a Docker sandbox: `docker run --rm --network none -i python:3-alpine python -c "<code>"`

### Edit Accuracy

1. **Read Before Every Edit** — Always read the target file immediately before editing. Use verbatim content from the read to construct replacements.
2. **Use Exact Content** — Copy strings verbatim from file content. Include 3-5 surrounding lines to guarantee a unique match. Preserve exact indentation.
3. **One Edit Per Concern** — Make one logical change per edit. Multiple changes = multiple edits.
4. **Verify After Critical Edits** — For function signatures, API contracts, type definitions, or import paths, re-read the file to confirm the edit landed correctly.
