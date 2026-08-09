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

| Claim | Evidence |
| ----- | -------- |
| Tests pass | Full command + output, all green |
| Build succeeds | Full command + output, zero errors |
| Lint clean | Full command + output, no issues |
| Manual verification | What was checked, how, and the result |
| Refactor safe | Before/after test runs, both green |
| Subagent done | Independent re-run of its commands |

## Rationalization Prevention

| Excuse | Reality |
| ------ | ------- |
| "The change was small" | Small changes break builds. Verify it. |
| "I already ran that" | Run it again, right now, and show the output. |
| "Tests passed earlier" | Memory is not evidence. Fresh output only. |
| "Close enough" | Full pass or it isn't done. |
| "Only one line changed" | One line can break a contract. Verify it. |
| "The subagent said it passed" | Their claim is not your evidence. Verify independently. |
| "Output is too long to check" | Read it all — partial output hides failures. |

Violating the spirit of verification is violating the rule. Creative reinterpretation to skip evidence is a red flag.

## Delegation Verification

When a subagent claims completion, do not pass the claim through:

1. Ask for its verification output (commands + results).
2. Re-run the critical commands yourself in this session.
3. Only then relay the claim with your own evidence attached.

## When Verification Fails

Do not claim completion. Fix the issue, re-verify, then claim. Never proceed to the next task with a verification failure.
