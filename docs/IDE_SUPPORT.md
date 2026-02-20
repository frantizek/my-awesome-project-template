# 🖥️ IDE Support Guide

This project is configured to work across multiple IDEs. All tool configurations live in pyproject.toml, and .editorconfig ensures consistent formatting everywhere.

## Configuration Layers

| File                    | Purpose                           | VS Code | PyCharm | Antigravity | Other IDEs |
| ----------------------- | --------------------------------- | ------- | ------- | ----------- | ---------- |
| pyproject.toml          | Tool rules (Ruff, Mypy, Pytest)   | ✅       | ✅       | ✅           | ✅          |
| .editorconfig           | Formatting (indent, charset, EOL) | ✅       | ✅       | ✅           | ✅          |
| .pre-commit-config.yaml | Git hooks                         | ✅       | ✅       | ✅           | ✅          |
| .vscode/                | VS Code workspace settings        | ✅       | ❌       | ❌           | ❌          |
| .idea/                  | PyCharm project settings          | ❌       | ✅       | ❌           | ❌          |

## VS Code

### Workspace Settings

The .vscode/ folder contains three files:

**settings.json** — Workspace-specific settings:
- Python interpreter set to .venv
- Ruff as the default formatter
- Auto-format and auto-fix on save
- Import sorting on save
- Pytest as the test runner
- Hidden cache files in explorer and search

**extensions.json** — Recommended extensions for collaborators:
- Python + Pylance
- Ruff
- Python Debugger (debugpy)
- Mypy Type Checker
- GitHub Copilot Chat

Unwanted extensions (Ruff replaces them):
- autopep8
- black-formatter
- isort
- flake8

When a collaborator opens this project, VS Code will prompt them to install the recommended extensions.

**launch.json** — Debug configurations:
- Python: Current File — Debug whatever file is open
- Python: Main — Debug main.py
- Python: Pytest — Debug test runner

### User Settings vs Workspace Settings

    User settings     = Your personal preferences (theme, font, keybindings)
    Workspace settings = Project-specific (formatter, linter, interpreter)

    User:      C:\Users\<you>\AppData\Roaming\Code\User\settings.json
    Workspace: <project>/.vscode/settings.json

    Workspace settings OVERRIDE user settings for that project.

### Recommended User Settings for Python Development

These go in your personal settings.json (Ctrl + Shift + P → Preferences: Open User Settings JSON):

    editor.formatOnSave: true
    editor.bracketPairColorization.enabled: true
    editor.guides.bracketPairs: true
    editor.rulers: [120]
    editor.wordWrap: on
    python.languageServer: Pylance
    python.analysis.typeCheckingMode: standard
    python.analysis.autoImportCompletions: true
    terminal.integrated.defaultProfile.windows: Git Bash

### Keyboard Shortcuts

| Shortcut          | Action                |
| ----------------- | --------------------- |
| Ctrl + Shift + P  | Command palette       |
| Ctrl + `          | Toggle terminal       |
| F5                | Start debugging       |
| Ctrl + Shift + F5 | Restart debugging     |
| Shift + F5        | Stop debugging        |
| Ctrl + Shift + U  | Toggle output panel   |
| Ctrl + Shift + M  | Toggle problems panel |
| Ctrl + Shift + T  | Reopen closed editor  |
| Ctrl + K, S       | Save all files        |
| Ctrl + Shift + X  | Extensions panel      |

### Troubleshooting

**Ruff not formatting on save:**
1. Check that Ruff extension is installed
2. Verify .vscode/settings.json has editor.formatOnSave: true
3. Verify [python] section has editor.defaultFormatter: charliermarsh.ruff
4. Reload window: Ctrl + Shift + P → Developer: Reload Window

**Python interpreter not detected:**
1. Check .venv exists in project root
2. Ctrl + Shift + P → Python: Select Interpreter
3. Choose the one from .venv/Scripts/python.exe

**Pre-commit not running on commit:**
1. Verify hooks are installed: pre-commit install
2. Check .git/hooks/pre-commit exists
3. Re-install if needed: pre-commit install --force

## PyCharm

### Initial Setup

1. Open the project folder in PyCharm
2. PyCharm will auto-detect .venv and set the interpreter
3. PyCharm will read .editorconfig automatically

### Install Ruff Plugin

1. Go to Settings → Plugins
2. Search for "Ruff"
3. Install the Ruff plugin by JetBrains
4. Restart PyCharm

### Configure Ruff

1. Go to Settings → Tools → Ruff
2. Enable "Use ruff format as formatter"
3. Enable "Run ruff on save"
4. The plugin reads configuration from pyproject.toml automatically

### Configure Mypy

Option 1: Use the Mypy plugin
1. Go to Settings → Plugins
2. Search for "Mypy"
3. Install and configure

Option 2: Use as external tool
1. Go to Settings → Tools → External Tools
2. Add new tool:
    - Name: Mypy
    - Program: $PyInterpreterDirectory$/mypy
    - Arguments: .
    - Working directory: $ProjectFileDir$

### Configure Pytest

1. Go to Settings → Tools → Python Integrated Tools
2. Set Default test runner to "pytest"
3. PyCharm reads [tool.pytest.ini_options] from pyproject.toml

### PyCharm Keyboard Shortcuts

| Shortcut           | Action                                     |
| ------------------ | ------------------------------------------ |
| Shift + Shift      | Search everywhere                          |
| Ctrl + Shift + A   | Find action (like VS Code command palette) |
| Alt + Enter        | Quick fix / suggestions                    |
| Ctrl + Alt + L     | Reformat code                              |
| Shift + F10        | Run current configuration                  |
| Shift + F9         | Debug current configuration                |
| Ctrl + Shift + F10 | Run current file                           |
| Alt + 1            | Toggle project panel                       |
| Alt + F12          | Toggle terminal                            |

### Important: .idea/ in .gitignore

The .idea/ folder contains personal PyCharm settings and should NEVER be committed. It is already in the .gitignore file.

## Antigravity

### Initial Setup

1. Open the project folder in Antigravity
2. The IDE should detect .venv automatically
3. .editorconfig will be read for formatting rules

### Ruff Integration

If Antigravity supports external formatters or plugins:
1. Check for a Ruff plugin in the marketplace
2. Or configure Ruff as an external formatter pointing to .venv/Scripts/ruff

### Tool Configuration

Since all tool configs are in pyproject.toml, any IDE that runs the CLI tools will get the same results:

    ruff check .
    ruff format .
    mypy .
    bandit -r src/ -c pyproject.toml
    pytest

This is the advantage of keeping configuration in pyproject.toml rather than IDE-specific files.

## Cross-IDE Consistency

### What .editorconfig Handles

| Setting                        | Value                     |
| ------------------------------ | ------------------------- |
| Indent style                   | Spaces                    |
| Indent size (Python)           | 4                         |
| Indent size (YAML, JSON, TOML) | 2                         |
| Line endings                   | LF                        |
| Charset                        | UTF-8                     |
| Trailing whitespace            | Trimmed (except Markdown) |
| Final newline                  | Always added              |

### What pyproject.toml Handles

| Tool   | Configuration                                    |
| ------ | ------------------------------------------------ |
| Ruff   | Line length, rules, format style, import sorting |
| Mypy   | Python version, strict settings, overrides       |
| Pytest | Test paths, arguments, coverage                  |
| Bandit | Excluded dirs, skipped rules                     |

### The Golden Rule

    IDE-specific settings  → Only in IDE-specific folders (.vscode/, .idea/)
    Shared tool settings   → Always in pyproject.toml
    Shared format settings → Always in .editorconfig

This ensures every team member gets the same results regardless of their IDE choice.
