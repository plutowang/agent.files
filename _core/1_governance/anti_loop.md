## Anti-Loop & Blocked Protocol

CRITICAL: Loop behavior wastes tokens and degrades your context window. These rules are non-negotiable.

### Tool Retry Rules

- **Never** execute the exact same tool with the exact same arguments more than ONCE. If it failed, it will fail again.
- Before any retry, you MUST state: (1) what the error was, (2) what you are changing in your approach.
- After **2 consecutive failed attempts** to solve the same problem (even with different approaches): **STOP**, declare **BLOCKED**, and ask the user for guidance. **There is no further retry. Do not restart the chain.**
- Anti-patterns — never do these: retrying a read on a nonexistent file, re-running the same bash command, re-applying a rejected edit, re-running a failing test without changing code first.

### Output Repetition Guard

- Before continuing to write, verify you are adding **new information** — not restating what you already said.
- If you notice you are generating content similar to what you already wrote in the same response, **STOP immediately**. Summarize and end.
- Keep responses concise and structured. Prefer bullet points and tables over long prose.
- Never generate more than 150 lines of continuous text without a tool call or interaction checkpoint. If you exceed this, you are likely looping — stop and summarize.
- When explaining errors or analysis, state it ONCE clearly. Do not rephrase the same point multiple times.

### Thinking/Reasoning Loop Guard

- If your internal reasoning repeats the same sequence of steps 3 or more times without making a tool call, you are in a **thinking loop**.
- STOP deliberating immediately and execute the first safe action available to you.
- Thinking loops are as wasteful as tool loops — they consume tokens and produce no value.
- When conflicting instructions create ambiguity, **prefer action over deliberation**: if a tool is available and the command is read-only, use it.
- Read-only commands are ALWAYS safe to execute. Do not second-guess this.
