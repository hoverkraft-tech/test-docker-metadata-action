# test-docker-metadata-action

Test repository to validate docker/metadata-action behavior and reproduce issue [#552](https://github.com/docker/metadata-action/issues/552).

## Overview

This repository contains a minimal setup to test the `docker/metadata-action` GitHub Action. It includes:

- A simple Dockerfile for building test images
- A GitHub workflow that demonstrates various metadata extraction scenarios
- Automated testing for different Git events (branches, tags, PRs)

## Repository Structure

```
.
├── Dockerfile                          # Simple Alpine-based test image
├── .github/
│   └── workflows/
│       └── docker-metadata-test.yml   # Main workflow file
└── README.md                          # This file
```

## Workflow Configuration

The workflow (`docker-metadata-test.yml`) is triggered by:

- **Push events** on `main` and `feature/**` branches
- **Tag pushes** matching `v*.*.*` pattern (e.g., v1.0.0)
- **Pull requests** to `main` branch
- **Manual dispatch** via GitHub UI

### Metadata Tags Generated

The workflow is configured to generate the following Docker image tags:

- `type=ref,event=branch` - Branch name for branch pushes
- `type=ref,event=pr` - PR number for pull requests
- `type=semver,pattern={{version}}` - Full semantic version (e.g., 1.0.0)
- `type=semver,pattern={{major}}.{{minor}}` - Major.minor version (e.g., 1.0)
- `type=semver,pattern={{major}}` - Major version only (e.g., 1)
- `type=sha,prefix=sha-` - Git SHA with prefix
- `type=raw,value=latest` - Latest tag (only on default branch)

### Image Location

Images are pushed to GitHub Container Registry (GHCR) at:
```
ghcr.io/hoverkraft-tech/test-docker-metadata-action
```

## Testing Scenarios

### Test Branch Pushes

```bash
git checkout -b feature/test-branch
git commit --allow-empty -m "Test commit"
git push origin feature/test-branch
```

Expected tags: `feature-test-branch`, `sha-<commit-hash>`

### Test Semantic Version Tags

```bash
git tag v1.0.0
git push origin v1.0.0
```

Expected tags: `1.0.0`, `1.0`, `1`, `latest`, `sha-<commit-hash>`

### Test Pull Requests

Create a PR to the `main` branch through GitHub UI or CLI.

Expected tags: `pr-<number>`, `sha-<commit-hash>`

## Reproducing Issue #552

This repository is set up to reproduce the behavior described in docker/metadata-action issue #552. 

To reproduce:
1. Follow the testing scenarios above
2. Check the workflow run output in the "Actions" tab
3. Review the "Display metadata" step for generated tags and labels
4. Compare actual behavior with expected behavior

## Viewing Results

After each workflow run:

1. Navigate to the **Actions** tab in this repository
2. Click on the latest workflow run
3. Expand the **Display metadata** step to see:
   - Generated tags
   - Applied labels
   - Complete JSON metadata output

## Manual Testing

You can manually trigger the workflow:

1. Go to the **Actions** tab
2. Select "Docker Metadata Action Test"
3. Click "Run workflow"
4. Choose a branch and click "Run workflow"

## Links

- [docker/metadata-action repository](https://github.com/docker/metadata-action)
- [docker/metadata-action issue #552](https://github.com/docker/metadata-action/issues/552)
- [Docker Build Push Action](https://github.com/docker/build-push-action)
- [GitHub Container Registry](https://docs.github.com/en/packages/working-with-a-github-packages-registry/working-with-the-container-registry)
