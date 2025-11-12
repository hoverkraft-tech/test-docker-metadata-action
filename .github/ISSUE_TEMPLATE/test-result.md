---
name: Issue #552 Test Results
about: Report test results for reproducing docker/metadata-action issue #552
title: '[#552] Test Results - '
labels: ['issue-552']
assignees: ''
---

## Test Information

**Date:** <!-- Date of test -->
**Workflow:** Reproduce Issue #552 - Detached HEAD
**Input ref:** <!-- The ref you used (branch, tag, or SHA) -->
**Ref type:** <!-- branch / tag / sha -->

## Issue Being Tested

**Issue #552:** "Action fails: Cannot find detached HEAD ref in 'HEAD'"
**Link:** https://github.com/docker/metadata-action/issues/552

## Test Setup

**Repository checkout:**
- [ ] Checked out a specific commit SHA (detached HEAD)
- [ ] Checked out a branch name
- [ ] Checked out a tag name

**Metadata-action configuration:**
- Context used: `git`
- Version: `v5` (or specify: ________)

## Expected Behavior

<!-- What did you expect to happen? -->

For commit SHA checkout:
- Metadata-action should handle detached HEAD state
- Should extract metadata from the commit
- Should generate appropriate tags

## Actual Behavior

<!-- What actually happened? -->

- [ ] ✅ Workflow succeeded
- [ ] ❌ Workflow failed at metadata step
- [ ] ⚠️ Other behavior (describe below)

**Error message (if failed):**
```
<!-- Paste error message here -->
```

## Workflow Run Details

**Workflow run URL:** <!-- Link to the Actions run -->

**Git status output:**
```
<!-- Paste "Get Git information" step output here -->
```

**Detached HEAD state:**
- [ ] Yes, in detached HEAD state
- [ ] No, on a named ref (branch/tag)

## Metadata Output

### Tags Generated
```
<!-- Paste tags output if successful, or "N/A" if failed -->
```

### Labels Generated
```
<!-- Paste labels output if successful, or "N/A" if failed -->
```

### Full Error Output
```
<!-- If the metadata step failed, paste the full error here -->
```

## Reproduction Confirmed?

- [ ] ✅ Successfully reproduced issue #552 (SHA checkout failed)
- [ ] ❌ Could not reproduce (SHA checkout worked)
- [ ] ℹ️ Different behavior observed (explain below)

## Additional Observations

<!-- Any other relevant information -->

- metadata-action version: 
- Runner OS: ubuntu-latest (or other: ______)
- Git version: <!-- From workflow output -->

## Comparison Tests

Did you test with different ref types?

| Ref Type | Input Value | Result |
|----------|-------------|--------|
| Branch   | `main`      | <!-- ✅ / ❌ --> |
| Tag      |             | <!-- ✅ / ❌ --> |
| SHA      |             | <!-- ✅ / ❌ --> |

## Screenshots

<!-- If applicable, attach screenshots of the workflow run, especially the error message -->

## Workarounds Tested

Did you try any workarounds?

- [ ] Using `context: github` instead of `context: git`
- [ ] Creating a temporary branch before metadata-action
- [ ] Using branch name instead of SHA
- [ ] Other (describe): _______________

**Workaround result:** <!-- Did it work? -->

## Related Information

- Is this related to the original issue report? <!-- Yes/No -->
- Does your use case match the original issue description? <!-- Yes/No -->
- Any differences from the original issue? <!-- Describe -->

## Next Steps

<!-- What should be done next? File upstream issue? Test fix? -->
