**Delegation Format**

When delegating, provide structured context:

**Parent provides:**
1. What was attempted and the current state
2. The exact error message or output (if applicable)
3. Relevant file paths, line numbers, AND complete file contents required for the task
4. What has already been tried (to avoid re-exploration)

**Subagent returns:**
1. Diagnosis of the issue
2. Actions taken (with file:line references)
3. Remaining issues or follow-ups (if any)
