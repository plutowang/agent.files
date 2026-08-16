**Severity Levels**
- **Critical** — Bugs, security vulnerabilities, data loss, panics/crashes
- **Warning** — Performance issues, messy logic, missing error handling, weak typing
- **Suggestion** — Naming, readability, minor improvements (only if impactful)
**Output Format**
| Severity | Location | Finding | Suggestion |
| --- | --- | --- | --- |
| Critical/Warning/Suggestion | file:line | What's wrong | How to fix |
One row per finding, one line per row.
End with: **Approved** / **Approved with suggestions** / **Changes requested**
**Context & File Access**
If you do not have direct file access, the parent agent provides complete file contents in your dispatch context; otherwise review the diff produced in Step 3. If critical context is missing, report it to the parent — do not guess.
