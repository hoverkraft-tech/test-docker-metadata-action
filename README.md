# test-docker-metadata-action

Test repository to reproduce [docker/metadata-action issue #552](https://github.com/docker/metadata-action/issues/552): **"Action fails: Cannot find detached HEAD ref in 'HEAD'"**

## Issue Description

The `docker/metadata-action` fails when used with `context: git` and the repository is in a detached HEAD state (e.g., when checking out a commit SHA instead of a branch or tag).

**Error message:**
```
Error: Cannot find detached HEAD ref in "HEAD"
```

## Problem Context

When a workflow:
1. Checks out a specific commit SHA (not a branch or tag)
2. Uses `docker/metadata-action` with `context: git`

The action fails because Git is in a detached HEAD state, and the action cannot determine the ref name.

## Repository Contents

- **Dockerfile** - Simple Alpine-based test image
- **`.github/workflows/reproduce-issue-552.yml`** - Workflow that reproduces the issue
- **`.github/workflows/docker-metadata-test.yml`** - General metadata testing workflow

## How to Reproduce Issue #552

### Method 1: Manual Workflow Dispatch (Recommended)

1. Go to the **Actions** tab
2. Select **"Reproduce Issue #552 - Detached HEAD"** workflow
3. Click **"Run workflow"**
4. In the "Git ref to checkout" field, enter a **commit SHA** (e.g., the first 7-40 characters of any commit hash)
5. Click **"Run workflow"**

**Expected result:** The workflow will fail at the "Docker metadata" step with the error:
```
Error: Cannot find detached HEAD ref in "HEAD"
```

### Method 2: Get a Commit SHA

To find a commit SHA to test with:

```bash
# Clone the repository
git clone https://github.com/hoverkraft-tech/test-docker-metadata-action.git
cd test-docker-metadata-action

# Get the SHA of the latest commit
git rev-parse HEAD

# Or get short SHA
git rev-parse --short HEAD
```

Then use this SHA in the workflow dispatch.

### Method 3: Using Different Refs

The workflow also works with branches and tags for comparison:

- **Branch:** Enter `main` or `feature/test` → Should work ✅
- **Tag:** Enter `v1.0.0` (if exists) → Should work ✅
- **SHA:** Enter a commit hash → Will fail ❌ (reproduces issue #552)

## Workflow Behavior

The `reproduce-issue-552.yml` workflow:

1. ✅ Checks out the repository at the specified ref
2. ✅ Detects whether the checkout resulted in a detached HEAD state
3. ✅ Determines the ref type (branch, tag, or SHA)
4. ❌ **Attempts to extract metadata with `context: git`** ← This is where it fails for SHAs
5. 📊 Displays results in the workflow summary

## Expected vs Actual Behavior

### Expected Behavior

The `docker/metadata-action` should handle detached HEAD state gracefully, similar to how it handles branches and tags.

### Actual Behavior

When a commit SHA is checked out:
- Git enters detached HEAD state
- `docker/metadata-action` with `context: git` fails with "Cannot find detached HEAD ref in 'HEAD'"

## Workaround

Until this issue is fixed, potential workarounds include:

1. **Avoid using commit SHAs directly** - Always use branch names or tags
2. **Use `context: github` instead of `context: git`** (if applicable)
3. **Create a temporary branch/tag** before running metadata-action

## Additional Testing

The repository also includes `docker-metadata-test.yml` for general testing of the metadata-action with various trigger types:

- Push to branches (main, feature/*)
- Push tags (v*.*.*)
- Pull requests
- Manual dispatch

## Links

- 🐛 [Issue #552 on docker/metadata-action](https://github.com/docker/metadata-action/issues/552)
- 📦 [docker/metadata-action repository](https://github.com/docker/metadata-action)
- 🔗 [Related closed issue #362](https://github.com/docker/metadata-action/issues/362)
