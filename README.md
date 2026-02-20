# 🚀 Python Project Template (UV + Ruff + Mypy)

A modern Python project template using **UV** for package management, **Ruff** for linting/formatting, **Mypy** for type checking, and **Pre-commit** for automated quality gates.

## 📋 Table of Contents

- [🚀 Python Project Template (UV + Ruff + Mypy)](#-python-project-template-uv--ruff--mypy)
  - [📋 Table of Contents](#-table-of-contents)
  - [📁 Project Structure](#-project-structure)
  - [⚡ Quick Start](#-quick-start)
  - [🔧 Setup Guide](#-setup-guide)
    - [Phase 1: Project Initialization](#phase-1-project-initialization)
    - [Phase 2: Quality Tools](#phase-2-quality-tools)
    - [Phase 3: Automation](#phase-3-automation)
  - [🖥️ IDE Support](#️-ide-support)
    - [VS Code](#vs-code)
    - [PyCharm](#pycharm)
    - [Other IDEs](#other-ides)
  - [📌 Common Commands](#-common-commands)
  - [📜 License](#-license)

## 📁 Project Structure

The project follows this layout:

    my-awesome-project-template/
    ├── .github/workflows/lint.yaml    CI/CD pipeline
    ├── .vscode/settings.json          VS Code workspace settings
    ├── .vscode/extensions.json        Recommended extensions
    ├── .vscode/launch.json            Debug configurations
    ├── src/__init__.py                Source package
    ├── tests/__init__.py
    ├── tests/test_main.py             Test files
    ├── .editorconfig                  Cross-IDE formatting rules
    ├── .gitignore                     Git ignore rules
    ├── .pre-commit-config.yaml        Pre-commit hook definitions
    ├── .python-version                Python version (read by UV and CI)
    ├── main.py                        Entry point
    ├── pyproject.toml                 Project config and tool settings
    ├── uv.lock                        UV dependency lock file
    └── README.md

## ⚡ Quick Start

1. Clone the template
2. Run uv venv to create virtual environment
3. Run uv pip install -e ".[dev]" to install dependencies
4. Run pre-commit install to set up hooks
5. Run pre-commit install --hook-type commit-msg for commit message linting
6. Run uv run python main.py to verify

## 🔧 Setup Guide

### Phase 1: Project Initialization

1. **Initialize with UV** — Run uv init my-project. This creates the directory, pyproject.toml, .venv, .python-version, and main.py.

2. **Enter project directory** — Run cd my-project.

3. **Initialize Git** — Run git init. Add a Python-specific .gitignore from github.com/github/gitignore. Also add IDE-specific ignores for .idea/ and cache directories.

4. **Connect to GitHub** — Create an empty remote repo, then run git add, commit, remote add origin, branch -M main, and push.

5. **Configure dependencies** — Edit pyproject.toml to add production dependencies and dev tools (Ruff, Mypy, Pytest, Bandit, pre-commit, pytest-cov).

6. **Install dev dependencies** — Run uv pip install -e ".[dev]"

### Phase 2: Quality Tools

All tool configuration lives in **pyproject.toml** — no separate config files needed.

7. **Ruff** (Linter + Formatter — replaces Black, Flake8, isort) — Configure line-length, target-version, lint rules, format settings, and per-file ignores in the [tool.ruff] sections of pyproject.toml.

8. **Mypy** (Type Checker) — Configure python_version, strict settings, and import overrides in [tool.mypy] section of pyproject.toml.

9. **Pytest** (Testing) — Configure pythonpath, testpaths, and addopts in [tool.pytest.ini_options] section of pyproject.toml.

10. **EditorConfig** (Cross-IDE consistency) — The `.editorconfig` file ensures consistent formatting across VS Code, PyCharm, and other IDEs.

    It defines indent style, charset, line endings, and per-filetype overrides.

    ```ini
    root = true

    [*]
    indent_style = space
    indent_size = 4
    end_of_line = lf
    charset = utf-8
    trim_trailing_whitespace = true
    insert_final_newline = true

    [*.py]
    max_line_length = 120

    [*.{yml,yaml,json,jsonc,toml}]
    indent_size = 2

    [*.md]
    trim_trailing_whitespace = false
    ```

### Phase 3: Automation

11. **Pre-commit hooks** — The `.pre-commit-config.yaml` runs these checks on every commit:

    | Hook             | Purpose                                           |
    | ---------------- | ------------------------------------------------- |
    | pre-commit-hooks | Trailing whitespace, merge conflicts, large files |
    | ruff             | Lint + auto-fix                                   |
    | ruff-format      | Code formatting                                   |
    | mypy             | Type checking                                     |
    | bandit           | Security scanning                                 |
    | gitlint          | Commit message format                             |
    | gitleaks         | Secret detection                                  |

    Install hooks:

    ```bash
    pre-commit install
    pre-commit install --hook-type commit-msg
    ```

    Run manually on all files:

    ```bash
    pre-commit run --all-files
    ```

12. **CI/CD Pipeline**

    `.github/workflows/lint.yaml` runs on every push/PR to main and develop:

      ✅ Ruff linting

      ✅ Ruff format check

      ✅ Mypy type checking

      ✅ Bandit security scan

      ✅ Pytest tests




## 🖥️ IDE Support

### VS Code

The `.vscode/` folder provides:

| File            | Purpose                                              |
| --------------- | ---------------------------------------------------- |
| settings.json   | Auto-format on save, Ruff integration, pytest config |
| extensions.json | Recommended extensions for collaborators             |
| launch.json     | Debug configurations (current file, main.py, pytest) |

**Recommended Extensions:**
+ Python + Pylance
+ Ruff,
+ Python Debugger,
+ Mypy Type Checker,
+ GitHub Copilot Chat

### PyCharm

- Install the **Ruff plugin** from the marketplace
- PyCharm natively reads pyproject.toml for tool configuration
- .editorconfig is supported out of the box

### Other IDEs

- .editorconfig provides universal formatting rules
- All tool configs in pyproject.toml work with CLI tools regardless of IDE

## 📌 Common Commands

```bash

──────────────── Environment ────────────────
uv venv # Create virtual environment
uv pip install -e ".[dev]" # Install all dev dependencies
uv run python main.py # Run the project

──────────────── Linting & Formatting ────────────────
uv run ruff check . # Run linter
uv run ruff check . --fix # Run linter with auto-fix
uv run ruff format . # Format code
uv run ruff format --check . # Check formatting (no changes)

──────────────── Type Checking ────────────────
uv run mypy . # Run type checker

──────────────── Security ────────────────
uv run bandit -r src/ # Run security scanner

──────────────── Testing ────────────────
uv run pytest # Run tests
uv run pytest --cov=src # Run tests with coverage
uv run pytest -v --tb=short # Verbose with short traceback

──────────────── Pre-commit ────────────────
pre-commit install # Install hooks
pre-commit install --hook-type commit-msg # Install commit-msg hook
pre-commit run --all-files # Run all hooks manually
pre-commit autoupdate # Update hook versions

──────────────── Git ────────────────
git add .
git commit -m "feat: your message" # Triggers pre-commit hooks
git push


```
Pipeline steps:

```mermaid
graph LR
A[Push/PR] --> B[Install UV]
B --> C[Setup Python]
C --> D[Install Deps]
D --> E[Ruff Lint]
E --> F[Ruff Format]
F --> G[Mypy]
G --> H[Bandit]
H --> I[Pytest]
I --> J[✅ All Passed]
```

## 📜 License

Add your license here.
