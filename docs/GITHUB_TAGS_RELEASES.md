# 🔖 GitHub Tags & Releases Guide

This project follows Semantic Versioning (SemVer) for tags and releases.

## Semantic Versioning

    MAJOR.MINOR.PATCH

    v1.0.0
    │ │ │
    │ │ └── PATCH: Bug fixes (backwards compatible)
    │ └──── MINOR: New features (backwards compatible)
    └────── MAJOR: Breaking changes (not backwards compatible)

### Examples

| Version | When To Use                          |
| ------- | ------------------------------------ |
| v0.1.0  | Initial development                  |
| v0.1.1  | Bug fix during development           |
| v0.2.0  | New feature added during development |
| v1.0.0  | First stable release                 |
| v1.0.1  | Patch fix after stable release       |
| v1.1.0  | New feature after stable release     |
| v2.0.0  | Breaking change                      |

### Pre-release Versions

| Version      | Meaning                   |
| ------------ | ------------------------- |
| v1.0.0-alpha | Early testing, unstable   |
| v1.0.0-beta  | Feature complete, testing |
| v1.0.0-rc.1  | Release candidate 1       |
| v1.0.0-rc.2  | Release candidate 2       |

## Creating Tags

### Lightweight Tag (simple marker)

    git tag v0.1.0

### Annotated Tag (recommended — includes message)

    git tag -a v0.1.0 -m "Release v0.1.0: initial project template"

### Push Tags to GitHub

    # Push a single tag
    git push origin v0.1.0

    # Push all tags
    git push --tags

### List Existing Tags

    git tag
    git tag -l "v1.*"

### Delete a Tag

    # Delete locally
    git tag -d v0.1.0

    # Delete on remote
    git push origin --delete v0.1.0

## Creating Releases on GitHub

### Option 1: GitHub Web UI

1. Go to your repository on GitHub
2. Click "Releases" in the right sidebar
3. Click "Draft a new release"
4. Choose or create a tag (e.g., v0.1.0)
5. Set the release title (e.g., "v0.1.0 - Initial Template")
6. Write release notes (or click "Generate release notes")
7. Mark as pre-release if applicable
8. Click "Publish release"

### Option 2: GitHub CLI

    # Create a release from an existing tag
    gh release create v0.1.0 --title "v0.1.0 - Initial Template" --notes "First release"

    # Create with auto-generated notes
    gh release create v0.1.0 --generate-notes

    # Create a pre-release
    gh release create v0.1.0-beta --prerelease --generate-notes

    # Create a draft release
    gh release create v0.1.0 --draft --generate-notes

### Option 3: GitHub Actions (Automated)

Add this workflow to auto-create releases when you push a tag:

Create the file .github/workflows/release.yaml with a workflow that triggers on tag pushes matching v*, checks out the code, and uses softprops/action-gh-release to create a release with auto-generated notes.

## Release Notes Best Practices

Structure your release notes like this:

    ## What's New
    - feat: add dark mode toggle (#12)
    - feat: add export to PDF (#15)

    ## Bug Fixes
    - fix: resolve crash on empty input (#18)
    - fix: handle null response from API (#20)

    ## Breaking Changes
    - feat!: remove Python 3.9 support (#22)

    ## Maintenance
    - chore: update dependencies (#25)
    - ci: add bandit security scan (#27)

## Workflow: From Development to Release

    1. Develop features on feature branches
    2. Merge to develop via PR
    3. When ready for release, merge develop to main
    4. Create an annotated tag on main
    5. Push the tag
    6. Create a GitHub release
    7. Celebrate 🎉

    Example:

    git checkout main
    git pull
    git tag -a v0.2.0 -m "Release v0.2.0: added CI pipeline and docs"
    git push origin v0.2.0
    gh release create v0.2.0 --generate-notes

## Updating pyproject.toml Version

Remember to update the version in pyproject.toml before tagging:

    [project]
    version = "0.2.0"

Then commit, tag, and release:

    git add pyproject.toml
    git commit -m "build: bump version to 0.2.0"
    git tag -a v0.2.0 -m "Release v0.2.0"
    git push && git push --tags
    gh release create v0.2.0 --generate-notes
