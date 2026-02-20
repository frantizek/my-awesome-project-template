# 🔧 Maintenance Guide

How to keep your project tools updated, aligned, and healthy.

## The Three Layers

This project enforces code quality in three places:

| Layer         | File                        | When It Runs      |
| ------------- | --------------------------- | ----------------- |
| Configuration | pyproject.toml              | Defines the rules |
| Local Gate    | .pre-commit-config.yaml     | On every commit   |
| CI Gate       | .github/workflows/lint.yaml | On every push/PR  |

Both gates read their configuration from pyproject.toml (single source of truth).

## Monthly Maintenance Checklist

### Step 1: Update Pre-commit Hooks

    pre-commit autoupdate

This updates the rev versions in .pre-commit-config.yaml to the latest releases.

### Step 2: Update Dev Dependencies

    uv pip install --upgrade -e ".[dev]"

### Step 3: Verify Tool Versions

    uv run ruff version
    uv run mypy --version
    uv run bandit --version
    uv run pytest --version
    pre-commit --version

### Step 4: Run Full Check

    pre-commit run --all-files

### Step 5: Run Tests

    uv run pytest

### Step 6: Commit Updates

    git add .
    git commit -m "build: update tool versions"
    git push

### Step 7: Verify CI Passes

Check the GitHub Actions tab to confirm all checks pass.

## Version Alignment

### Where Versions Are Defined

| Tool             | pyproject.toml    | .pre-commit-config.yaml |
| ---------------- | ----------------- | ----------------------- |
| Ruff             | ruff>=0.11        | rev: v0.11.13           |
| Mypy             | mypy>=1.16        | rev: v1.16.0            |
| Bandit           | bandit[toml]>=1.8 | rev: 1.8.3              |
| Pytest           | pytest>=8.3       | Not in pre-commit       |
| Pre-commit hooks | N/A               | rev: v5.0.0             |
| Gitlint          | N/A               | rev: v0.19.1            |
| Gitleaks         | N/A               | rev: v8.27.2            |

### How They Relate

    pyproject.toml     → Minimum version (>=0.11 means 0.11 or higher)
    .pre-commit-config → Exact version (v0.11.13)
    CI                 → Installs whatever pyproject.toml resolves

### Potential Drift

    pre-commit autoupdate bumps .pre-commit-config.yaml to v0.12.0
    BUT pyproject.toml still says >=0.11
    CI installs 0.11.x from cache

    Result: Local and CI may use different versions

### How To Prevent Drift

After running pre-commit autoupdate, check if major versions changed:

1. Look at what autoupdate changed in .pre-commit-config.yaml
2. Update the minimum versions in pyproject.toml if needed
3. Run uv pip install --upgrade -e ".[dev]" to match
4. Run pre-commit run --all-files to verify
5. Commit everything together

## Updating Python Version

### Step 1: Update .python-version

Change the version in .python-version:

    3.12

### Step 2: Update pyproject.toml

Update requires-python:

    requires-python = ">=3.12"

Update tool target versions:

    [tool.ruff]
    target-version = "py312"

    [tool.mypy]
    python_version = "3.12"

### Step 3: Recreate Virtual Environment

    rm -rf .venv
    uv venv
    uv pip install -e ".[dev]"

### Step 4: Run All Checks

    pre-commit run --all-files
    uv run pytest

### Step 5: Commit

    git add .
    git commit -m "build: upgrade to Python 3.12"
    git push

## Adding a New Tool

### Step 1: Add to pyproject.toml

Add the package to dev dependencies:

    [project.optional-dependencies]
    dev = [
        ...existing tools...
        "new-tool>=1.0",
    ]

Add tool configuration if needed:

    [tool.new-tool]
    setting = "value"

### Step 2: Install

    uv pip install -e ".[dev]"

### Step 3: Add to Pre-commit (if applicable)

Add a new hook entry in .pre-commit-config.yaml.

### Step 4: Add to CI (if applicable)

Add a new step in .github/workflows/lint.yaml.

### Step 5: Document

Update docs/COMMON_COMMANDS.md with the new tool commands.

### Step 6: Commit

    git add .
    git commit -m "build: add new-tool for <purpose>"
    git push

## Removing a Tool

### Step 1: Remove from pyproject.toml

Remove from dev dependencies and delete the [tool.x] section.

### Step 2: Remove from Pre-commit

Remove the hook entry from .pre-commit-config.yaml.

### Step 3: Remove from CI

Remove the step from .github/workflows/lint.yaml.

### Step 4: Uninstall

    uv pip install -e ".[dev]"

### Step 5: Clean Pre-commit Cache

    pre-commit clean

### Step 6: Document

Update docs/COMMON_COMMANDS.md to remove the tool commands.

### Step 7: Commit

    git add .
    git commit -m "build: remove old-tool"
    git push

## Troubleshooting

### Pre-commit Fails But CI Passes

Likely cause: Version mismatch between local hooks and CI.

Fix:

    pre-commit autoupdate
    pre-commit clean
    pre-commit run --all-files

### CI Fails But Local Passes

Likely cause: Different Python or tool version in CI.

Fix:
1. Check .python-version matches CI
2. Check pyproject.toml versions match .pre-commit-config.yaml
3. Clear CI cache if needed

### Mypy Reports Different Errors Locally vs CI

Likely cause: Missing type stubs or different mypy version.

Fix:
1. Verify types-paramiko and types-PyYAML are in dev dependencies
2. Verify additional_dependencies in .pre-commit-config.yaml matches
3. Run uv pip install --upgrade -e ".[dev]"

### Pre-commit Hook Times Out

Likely cause: Mypy or bandit running on too many files.

Fix:
1. Check exclude patterns in pyproject.toml
2. Ensure .venv and build directories are excluded
3. Consider adding pass_filenames: false to slow hooks

### Everything Is Broken

Nuclear option — start fresh:

    rm -rf .venv
    pre-commit clean
    uv venv
    uv pip install -e ".[dev]"
    pre-commit install
    pre-commit install --hook-type commit-msg
    pre-commit run --all-files
