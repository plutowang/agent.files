Generate a conventional commit message. This is a READ-ONLY operation — no files are modified.

**IMPORTANT: Do not overthink this. Do not deliberate. Follow these steps immediately:**

1. Run `git status` using the bash tool
2. Run `git diff --cached` using the bash tool (if nothing is staged, run `git diff` instead)
3. Analyze the output
4. Output a conventional commit message: `<type>(<scope>): <description>`

**Rules:**

- The bash tool is available to you. `git status` and `git diff` are read-only commands. USE THEM DIRECTLY.
- Do NOT load any skills. Do NOT plan. Do NOT deliberate about whether you are allowed to run these commands. You are.
- Do NOT execute `git add`, `git commit`, or `git push`
- Output ONLY the commit message in a `bash` code block — no explanations, no filler
- If you catch yourself repeating the same reasoning, STOP THINKING and make the first tool call
