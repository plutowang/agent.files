**GitLab Requirements Pipeline**
Fetch linked requirements from GitLab when reviewing code. Available to any agent that needs GitLab issue context.
**Detection**
Before fetching, confirm GitLab is the remote and MCP tools are reachable:

1. Check the remote URL: `git remote -v` — look for `gitlab.com` or a self-hosted GitLab domain.
2. Verify MCP availability: attempt to list GitLab MCP resources; if the call fails, GitLab context is unavailable — proceed without it.
3. Derive the project ID from the remote URL: extract `namespace/project` from `git@gitlab.com:namespace/project.git` or `https://gitlab.com/namespace/project`.
If any check fails, skip GitLab context — fall back to the code-only path.
**Fetching Requirements**
Run these steps in order. Degrade gracefully — partial context is better than no context.
**A. Find the Merge Request** — Get the branch name (`git rev-parse --abbrev-ref HEAD`); search MRs via `gitlab_search` with `scope="merge_requests"`, `search=<branch-name>`, `project_id=<project>`. If no MR is found, GitLab context is unavailable — skip to the fallback.
**B. Fetch MR Details** — Use `gitlab_get_merge_request` with `id=<project>`, `merge_request_iid=<iid>`; extract the title and description.
**C. Find Linked Issues** — Fetch MR notes via `gitlab_get_merge_request_notes` (`project_id=<project>`, `merge_request_iid=<iid>`); examine the description and notes for issue references — common patterns: `#123`, `Closes #45`, `Fixes #67`, `Relates to #89`. Collect all unique issue IDs; skip MR references (`!67`).
**D. Fetch Each Linked Issue** — For each issue ID, use `gitlab_get_issue` with `id=<project>`, `issue_iid=<iid>`; extract title and description; check the body for epic references.
**E. Linked Issues (1 Level Only)** — For each linked issue, check its relationships — **1 level deep only**, do not recurse. **Blocked by** (dependencies): what should already be in place. **Blocks** (follow-ups): will current changes form a good foundation. If structured linked-issues data is available in the response, use it directly; otherwise examine descriptions and MR notes for `#<iid>` dependency references. If deeper chains exist, note that they exist but stop.
**F. Find the Epic** — Parse issue descriptions for epic references; if found, fetch the epic for broader context.
**G. Compile Requirements Block** — Assemble into a single block:

```markdown
## Requirements (from GitLab)

**MR:** {title}
{description}

**Issue:** #{iid} {title}
{description}

**Epic:** {title}
{description}

**Dependencies (must already exist):**
- #{iid} {title} — {summary}

**Follow-ups (this must support):**
- #{iid} {title} — {summary}
```
