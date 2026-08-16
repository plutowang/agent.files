**Delegation Rules**

Delegate only to a subagent your own permissions allow. The `Callable by` column is authoritative — a delegation outside it will be refused.

| Trigger | Subagent | Callable by | When |
| --- | --- | --- | --- |
| Discovery | retrieval agent | implementation, planning, documentation, debugging, build-error agents | Any file discovery, pattern search, or documentation retrieval |
| Design decision | architect agent | planning agent | Two or more genuinely different approaches are viable |
| Restructuring | refactoring agent | implementation, planning agents | Duplication or complexity is blocking progress |
| Build failure | build-error agent | implementation agent | Two failed attempts → delegate once; if that also fails, BLOCKED ⏸ (III) |
| Security-sensitive | security review agent | implementation, planning agents | Auth, crypto, secrets, or input validation touched |
| Broad change | code review agent | implementation, planning agents | Changes touching more than 3 files, or critical paths (auth, data, API) |
| Claimed complete | verifier agent | implementation agent | Skeptical validation before declaring done |
| Docs stale | documentation agent | implementation agent | After significant implementation |

**User-initiated only:** the debugging agent.

The phase pipeline: design loads `brainstorming` then `writing-plans`; implementation loads `subagent-driven-dev` then `verification-gate`, with `test-driven-development` active throughout implementation.
