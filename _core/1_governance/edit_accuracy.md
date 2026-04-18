## Edit Accuracy

1. **Read Before Every Edit** — Always read the target file immediately before editing. Use verbatim content from the read to construct replacements.
2. **Use Exact Content** — Copy strings verbatim from file content. Include 3-5 surrounding lines to guarantee a unique match. Preserve exact indentation.
3. **One Edit Per Concern** — Make one logical change per edit. Multiple changes = multiple edits.
4. **Verify After Critical Edits** — For function signatures, API contracts, type definitions, or import paths, re-read the file to confirm the edit landed correctly.

## Token Efficiency

- Prefer Edit over Write for existing files — smaller diffs, less context consumed.