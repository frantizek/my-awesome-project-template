# 🔧 Setup Guide

A detailed walkthrough for creating a new Python project using this template.

## Prerequisites

Before starting, ensure you have:

| Tool            | Installation                                            |
| --------------- | ------------------------------------------------------- |
| Python 3.11+    | https://www.python.org/downloads/                       |
| UV              | https://docs.astral.sh/uv/getting-started/installation/ |
| Git             | https://git-scm.com/downloads                           |
| GitHub CLI (gh) | https://cli.github.com/                                 |

Verify installations:

    python --version
    uv --version
    git --version
    gh --version

## Phase 1: Project Initialization

### Step 1: Create Project with UV

    uv init my-project

This creates:

    my-project/
    ├── .python-version
    ├── .venv/
    ├── main.py
    └── pyproject.toml

### Step 2: Enter Project Directory

    cd my-project

### Step 3: Initialize Git

    git init

### Step 4: Add .gitignore

Download the Python-specific .gitignore:

    curl -o .gitignore https://raw.githubusercontent.com/github/gitignore/main/Python.gitignore

Then add these additional entries at the end:

    # IDE
    .idea/

    # OS
    .DS_Store
    Thumbs.db

### Step 5: Copy Template Files

If you cloned this template repository:

    cp -r /path/to/my-awesome-project-template/.vscode .
    cp -r /path/to/my-awesome-project-template/.github .
    cp /path/to/my-awesome-project-template/.editorconfig .
    cp /path/to/my-awesome-project-template/.pre-commit-config.yaml .
    cp /path/to/my-awesome-project-template/.gitattributes .

### Step 6: Connect to GitHub

Create an empty repository on GitHub, then:

    git add .
    git commit -m "feat: initial project structure with uv init"
    git remote add origin https://github.com/<your-username>/my-project.git
    git branch -M main
    git push -u origin main

## Phase 2: Dependencies and Tools

### Step 7: Configure pyproject.toml

Update the [project] section with your project details:

    [project]
    name = "my-project"
    version = "0.1.0"
    description = "Your project description"
    readme = "README.md"
    requires-python = ">=3.11"
    dependencies = []

Add dev dependencies:

    [project.optional-dependencies]
    dev = [
        "ruff>=0.11",
        "mypy>=1.16",
        "pre-commit>=4.2",
        "pytest>=8.3",
        "pytest-cov>=6.1",
        "bandit[toml]>=1.8",
        "types-paramiko>=3.5",
        "types-PyYAML>=6.0",
    ]

Add tool configurations for Ruff, Mypy, Pytest, and Bandit. See pyproject.toml in this template for the full configuration.

### Step 8: Install Dependencies

    uv pip install -e ".[dev]"

### Step 9: Install Pre-commit Hooks

    pre-commit install
    pre-commit install --hook-type commit-msg

Verify hooks work:

    pre-commit run --all-files

## Phase 3: Project Structure

### Step 10: Create Source and Test Directories

    mkdir -p src tests
    touch src/__init__.py
    touch tests/__init__.py
    touch tests/test_main.py

### Step 11: Add a Basic Test

In tests/test_main.py:

    from main import main


    def test_main(capsys: object) -> None:
        main()

## Phase 4: Setup Labels

### Step 12: Create GitHub Labels

If you copied the scripts/ folder from the template:

    bash scripts/create-labels.sh

This sets up all project labels automatically. See docs/GITHUB_LABELS.md for details.

## Phase 5: Verification

### Step 13: Run All Checks

    uv run ruff check .
    uv run ruff format --check .
    uv run mypy .
    uv run bandit -r src/ main.py -c pyproject.toml
    uv run pytest

### Step 14: Make a Test Commit

    git add .
    git commit -m "feat: complete project setup with tooling"
    git push

If all pre-commit hooks pass and CI is green, your project is ready.

## Quick Setup Summary

For those who want the short version:

    uv init my-project
    cd my-project
    git init
    curl -o .gitignore https://raw.githubusercontent.com/github/gitignore/main/Python.gitignore
    cp -r /path/to/template/.vscode .
    cp -r /path/to/template/.github .
    cp /path/to/template/.editorconfig .
    cp /path/to/template/.pre-commit-config.yaml .
    cp /path/to/template/.gitattributes .
    uv pip install -e ".[dev]"
    pre-commit install
    pre-commit install --hook-type commit-msg
    mkdir -p src tests
    touch src/__init__.py tests/__init__.py tests/test_main.py
    git add .
    git commit -m "feat: initial project setup"
    git remote add origin https://github.com/<user>/my-project.git
    git branch -M main
    git push -u origin main
