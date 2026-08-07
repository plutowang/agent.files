---
name: verification-gate
description: Load before claiming any task or feature is complete. No completion claims without fresh verification evidence.
---

# Verification Gate: Prove Before Claiming

Announce at the start: "I'm using the verification-gate skill to verify this before claiming it works."

## Iron Law

**No completion claims without fresh verification evidence.**

Do not trust memory. Do not assume tests still pass. Run them again, right now, and show the output.

## Gate Function

For every task marked complete:

1. **Identify** — What was claimed to be completed?
2. **Run** — Execute the relevant test suite or verification command fresh
3. **Read** — Examine the output completely — don't skip warnings or partial failures
4. **Verify** — Confirm the output matches expected success criteria
5. **Claim** — Only now declare the task complete, with evidence attached

## Evidence Required

- Test output showing all tests pass (include the command and result)
- Build/compile output showing no errors
- Lint output showing no issues
- Manual verification notes if automated tests don't exist

## Red Flags

- Claiming completion from memory ("tests passed earlier")
- Skipping verification because "the change was small"
- Reporting partial output that hides failures or warnings
- Accepting "close enough" instead of full pass
- "I already ran that" — run it again, show the output

## When Verification Fails

Do not claim completion. Fix the issue, re-verify, then claim. Never proceed to the next task with a verification failure.
