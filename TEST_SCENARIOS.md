# Reproduction Steps for Issue #552

This document provides detailed steps to reproduce docker/metadata-action issue #552: **"Cannot find detached HEAD ref in 'HEAD'"**

## Issue Summary

- **Problem:** docker/metadata-action fails when Git is in a detached HEAD state (checking out a commit SHA)
- **Error:** `Error: Cannot find detached HEAD ref in "HEAD"`
- **Context:** Using `context: git` with the metadata-action
- **Original Issue:** https://github.com/docker/metadata-action/issues/552

## Prerequisites

- Access to this repository's Actions tab
- A commit SHA to test with (see instructions below)

## Scenario 1: Reproduce the Issue (Detached HEAD with SHA)

This is the main scenario that demonstrates the bug.

### Steps

1. **Get a commit SHA:**
   ```bash
   # Navigate to the repository
   cd test-docker-metadata-action
   
   # Get the latest commit SHA
   git rev-parse HEAD
   # Example output: 08443d1a1b2c3d4e5f6789abcdef0123456789ab
   
   # Or get short SHA (7 characters)
   git rev-parse --short HEAD
   # Example output: 08443d1
   ```

2. **Trigger the workflow:**
   - Go to **Actions** tab
   - Select **"Reproduce Issue #552 - Detached HEAD"**
   - Click **"Run workflow"**
   - In "Git ref to checkout" field, paste the commit SHA from step 1
   - Click **"Run workflow"**

3. **Observe the failure:**
   - Wait for the workflow to run
   - The workflow will fail at the **"Docker metadata (with git context - REPRODUCES ISSUE)"** step
   - Error message: `Error: Cannot find detached HEAD ref in "HEAD"`

### Expected Behavior

The metadata-action should handle detached HEAD state gracefully and extract metadata from the commit.

### Actual Behavior

❌ The action fails with an error because it cannot find a ref name for the detached HEAD.

### Workflow Output

The workflow will show:
- ✅ Checkout succeeds
- ✅ Git information shows detached HEAD state
- ✅ Ref type detected as "sha"
- ❌ **Metadata extraction fails** ← This is the bug

## Scenario 2: Success Case with Branch Name

This scenario shows that the workflow works correctly with branch names.

### Steps

1. **Trigger the workflow:**
   - Go to **Actions** tab
   - Select **"Reproduce Issue #552 - Detached HEAD"**
   - Click **"Run workflow"**
   - In "Git ref to checkout" field, enter: `main`
   - Click **"Run workflow"**

2. **Observe success:**
   - The workflow completes successfully
   - Metadata is extracted without errors
   - Docker image is built and pushed

### Result

✅ Metadata-action works correctly when on a branch (not detached HEAD).

## Scenario 3: Success Case with Tag

This scenario shows that the workflow works correctly with tag names.

### Steps

1. **Create a tag (if needed):**
   ```bash
   git tag v1.0.0-test
   git push origin v1.0.0-test
   ```

2. **Trigger the workflow:**
   - Go to **Actions** tab
   - Select **"Reproduce Issue #552 - Detached HEAD"**
   - Click **"Run workflow"**
   - In "Git ref to checkout" field, enter: `v1.0.0-test`
   - Click **"Run workflow"**

3. **Observe success:**
   - The workflow completes successfully
   - Metadata is extracted without errors

### Result

✅ Metadata-action works correctly when on a tag (not detached HEAD).

## Scenario 4: Comparison Matrix

Test all three ref types to see the difference in behavior:

| Ref Type | Input Example | Detached HEAD? | Metadata-action Result |
|----------|---------------|----------------|----------------------|
| Branch   | `main`        | No            | ✅ Success          |
| Tag      | `v1.0.0-test` | No            | ✅ Success          |
| SHA      | `08443d1`     | Yes           | ❌ Fails (Issue #552) |

## Analyzing the Results

After running the workflows, check the workflow summary for each run:

1. **Git Status Information:**
   - Shows whether in detached HEAD state
   - Shows the ref type (branch/tag/sha)

2. **Metadata Step:**
   - For branches/tags: Shows extracted tags and labels
   - For SHAs: Shows error message about detached HEAD

3. **Step-by-step outcome:**
   - Compare successful runs (branch/tag) with failed run (SHA)
   - Identify exactly where the SHA checkout causes the failure

## Understanding Detached HEAD

When you checkout a commit SHA:

```bash
git checkout 08443d1
```

Git responds with:
```
Note: switching to '08443d1'.

You are in 'detached HEAD' state...
```

In this state:
- `HEAD` points directly to a commit, not a branch
- `git symbolic-ref HEAD` fails
- This is what causes metadata-action to fail

## Workarounds

Until the issue is fixed, you can:

1. **Use branch names instead of SHAs:**
   - Instead of checking out `08443d1`
   - Create/use a branch pointing to that commit

2. **Create a temporary branch:**
   ```bash
   git checkout -b temp-branch 08443d1
   ```

3. **Use different context:**
   - Try `context: github` instead of `context: git` (if applicable to your use case)

## Validation Checklist

After running the scenarios, verify:

- [ ] SHA checkout results in detached HEAD state (confirmed in Git status)
- [ ] Metadata-action fails with "Cannot find detached HEAD ref" error
- [ ] Branch checkout works successfully
- [ ] Tag checkout works successfully
- [ ] Error only occurs with `context: git` in detached HEAD state

## Related Information

- **Original workflow example:** See the issue description in [#552](https://github.com/docker/metadata-action/issues/552)
- **Related issue:** [#362](https://github.com/docker/metadata-action/issues/362) (closed but similar)
- **Action version tested:** v5.8.0 (as mentioned in original issue)

## Reporting Results

If you find variations in behavior or additional details:

1. Note the commit SHA used
2. Note the metadata-action version
3. Capture the full error message
4. Document any differences from expected behavior

This information helps track the issue and potential fixes.
