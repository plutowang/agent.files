## GitLab Requirements Context

Fetch linked requirements from GitLab when reviewing code. Imported by the review command; usable by any agent that needs GitLab issue context.

### Detection

Before fetching, confirm GitLab is the remote and MCP tools are reachable:

1. Check the remote URL: `git remote -v` — look for `gitlab.com` or a self-hosted GitLab domain.
2. Verify MCP availability: attempt to list GitLab MCP resources. If the call fails, GitLab context is unavailable — proceed without it.
3. Derive the project ID from the remote URL: extract `namespace/project` from `git@gitlab.com:namespace/project.git` or `https://gitlab.com/namespace/project`.

If any check fails, skip GitLab context and fall back to the code-only path.

### Fetching Requirements

Run these steps in order. Degrade gracefully — partial context is better than no context.

#### Step 1: Find the Merge Request

Get the current branch name:

```bash
git rev-parse --abbrev-ref HEAD
```

Search for MRs matching this branch using `gitlab_search` with `scope="merge_requests"`, `search=<branch-name>`, `project_id=<project>`. If no MR is found, GitLab context is unavailable — skip to the fallback.

#### Step 2: Fetch MR Details

Use `gitlab_get_merge_request` with `id=<project>`, `merge_request_iid=<iid>`. Extract the title and description.

#### Step 3: Find Linked Issues

Fetch MR notes using `gitlab_get_merge_request_notes` with `project_id=<project>`, `merge_request_iid=<iid>`. Examine the MR description and notes for issue references. Common patterns: `#123`, `Closes #45`, `Fixes #67`, `Relates to #89`. Collect all unique issue IDs; skip MR references (`!67`).

#### Step 4: Fetch Each Linked Issue

For each issue ID found, use `gitlab_get_issue` with `id=<project>`, `issue_iid=<iid>`. Extract the title and description. Check the issue body for epic references.

#### Step 5: Fetch Linked Issues (1 Level Only)

For each linked issue, check its relationships — **1 level deep only**. Do not recurse.

- **Blocked by** (dependencies): issues that block this one. The review uses them to understand what should already be in place.
- **Blocks** (follow-ups): issues this one blocks. The review checks whether current changes form a good foundation.

If structured linked-issues data is available in the issue response, use it directly. Otherwise, examine the issue description and MR notes for `#<iid>` references that represent dependencies. If deeper chains exist beyond 1 level, note that they exist but stop — do not recurse further.

#### Step 6: Find the Epic

Parse issue descriptions for epic references. If found, fetch the epic for broader context.

#### Step 7: Compile Requirements Block

Assemble into a single block:

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

#### Step 8: Fallback

If the remote is not GitLab or MCP tools are unavailable, ask: "Paste requirements or skip (code-only review)?" If the user pastes requirements, use them. If they skip, proceed with a code-only review.
