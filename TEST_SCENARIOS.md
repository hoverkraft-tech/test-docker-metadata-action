# Test Scenarios for docker/metadata-action

This document describes specific test scenarios you can run to validate docker/metadata-action behavior.

## Scenario 1: Branch Push

Test basic branch metadata extraction.

**Steps:**
1. Create a new branch
2. Make a commit
3. Push to GitHub

**Commands:**
```bash
git checkout -b feature/test-metadata
echo "test" > test.txt
git add test.txt
git commit -m "Add test file"
git push origin feature/test-metadata
```

**Expected Output:**
- Tags: `feature-test-metadata`, `sha-<commit-hash>`
- Workflow should complete successfully

## Scenario 2: Semantic Version Tag

Test semantic versioning metadata extraction.

**Steps:**
1. Create and push a semver tag

**Commands:**
```bash
git checkout main
git pull
git tag v1.0.0
git push origin v1.0.0
```

**Expected Output:**
- Tags: `1.0.0`, `1.0`, `1`, `latest`, `sha-<commit-hash>`
- All semantic version patterns should be generated
- Image should be pushed to GHCR

## Scenario 3: Multiple Version Tags

Test multiple version tags to verify metadata handling.

**Commands:**
```bash
# Create minor version update
git tag v1.1.0
git push origin v1.1.0

# Later, create patch version
git tag v1.1.1
git push origin v1.1.1
```

**Expected Output:**
- v1.1.0: `1.1.0`, `1.1`, `1`, `latest`, `sha-<hash>`
- v1.1.1: `1.1.1`, `1.1`, `1`, `latest`, `sha-<hash>`
- Note: `1.1` and `1` tags will be overwritten

## Scenario 4: Pull Request

Test PR-specific metadata.

**Steps:**
1. Create a feature branch
2. Open a pull request to main

**Expected Output:**
- Tags: `pr-<number>`, `sha-<commit-hash>`
- Image build but not pushed (PR mode)

## Scenario 5: Pre-release Tags

Test pre-release versioning.

**Commands:**
```bash
git tag v2.0.0-beta.1
git push origin v2.0.0-beta.1
```

**Expected Output:**
- Tags: `2.0.0-beta.1`, `sha-<commit-hash>`
- Should not generate major/minor tags for pre-release

## Scenario 6: Manual Workflow Dispatch

Test manual workflow triggering.

**Steps:**
1. Go to Actions tab
2. Select "Docker Metadata Action Test" workflow
3. Click "Run workflow"
4. Select branch and run

**Expected Output:**
- Workflow runs with branch-specific metadata

## Checking Results

After each scenario:

1. Navigate to **Actions** tab
2. Click on the workflow run
3. Check the **Display metadata** step to see:
   - Generated tags
   - Applied labels  
   - Complete JSON output
4. Verify the image in GitHub Packages

## Common Issues to Check

- Are all expected tags generated?
- Are labels correctly applied to all tags?
- Does the JSON output contain all expected fields?
- Are semantic version patterns working correctly?
- Is the `latest` tag only applied to the default branch?

## Issue #552 Specific Tests

[Add specific test cases here once issue #552 details are known]

The workflow output will show exactly what metadata is generated, allowing you to compare expected vs actual behavior.
