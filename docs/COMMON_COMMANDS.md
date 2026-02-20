# 📌 Common Commands Reference

A quick reference for all CLI commands used in this project.

## UV (Package Manager)

### Environment

| Command                              | Description                           |
| ------------------------------------ | ------------------------------------- |
| uv venv                              | Create virtual environment            |
| uv pip install -e ".[dev]"           | Install all dev dependencies          |
| uv pip install package-name          | Install a production dependency       |
| uv pip install --upgrade -e ".[dev]" | Upgrade all dev dependencies          |
| uv pip list                          | List installed packages               |
| uv pip freeze                        | Show installed packages with versions |
| uv lock                              | Update the lock file                  |

### Running

| Command                           | Description     |
| --------------------------------- | --------------- |
| uv run python main.py             | Run the project |
| uv run python -m module_name      | Run a module    |
| uv run python -c "print('hello')" | Run inline code |

## Ruff (Linter + Formatter)

### Linting

| Command                           | Description               |
| --------------------------------- | ------------------------- |
| uv run ruff check .               | Run linter on all files   |
| uv run ruff check . --fix         | Run linter with auto-fix  |
| uv run ruff check path/to/file.py | Lint a specific file      |
| uv run ruff check . --select E,W  | Check only specific rules |
| uv run ruff check . --ignore E501 | Ignore specific rules     |
| uv run ruff check . --statistics  | Show error count by rule  |

### Formatting

| Command                            | Description                      |
| ---------------------------------- | -------------------------------- |
| uv run ruff format .               | Format all files                 |
| uv run ruff format --check .       | Check formatting without changes |
| uv run ruff format --diff .        | Show what would change           |
| uv run ruff format path/to/file.py | Format a specific file           |

### Info

| Command               | Description                |
| --------------------- | -------------------------- |
| uv run ruff version   | Show ruff version          |
| uv run ruff rule E501 | Explain a specific rule    |
| uv run ruff linter    | List all available linters |

## Mypy (Type Checker)

| Command                             | Description                |
| ----------------------------------- | -------------------------- |
| uv run mypy .                       | Type check all files       |
| uv run mypy path/to/file.py         | Type check a specific file |
| uv run mypy . --strict              | Run with strict mode       |
| uv run mypy . --show-error-context  | Show context for errors    |
| uv run mypy . --html-report report/ | Generate HTML report       |
| uv run mypy --version               | Show mypy version          |

## Bandit (Security Scanner)

| Command                                         | Description                |
| ----------------------------------------------- | -------------------------- |
| uv run bandit -r src/                           | Scan src/ directory        |
| uv run bandit -r src/ main.py -c pyproject.toml | Scan with config file      |
| uv run bandit -r src/ -ll                       | Show only medium+ severity |
| uv run bandit -r src/ -lll                      | Show only high severity    |
| uv run bandit -r src/ -f json                   | Output as JSON             |
| uv run bandit --version                         | Show bandit version        |

## Pytest (Testing)

### Running Tests

| Command                          | Description                   |
| -------------------------------- | ----------------------------- |
| uv run pytest                    | Run all tests                 |
| uv run pytest -v                 | Verbose output                |
| uv run pytest -v --tb=short      | Verbose with short traceback  |
| uv run pytest tests/test_main.py | Run a specific test file      |
| uv run pytest -k "test_name"     | Run tests matching a pattern  |
| uv run pytest -x                 | Stop on first failure         |
| uv run pytest --lf               | Re-run only last failed tests |

### Coverage

| Command                                           | Description                   |
| ------------------------------------------------- | ----------------------------- |
| uv run pytest --cov=src                           | Run with coverage             |
| uv run pytest --cov=src --cov-report=term-missing | Show missing lines            |
| uv run pytest --cov=src --cov-report=html         | Generate HTML coverage report |

## Pre-commit (Git Hooks)

### Setup

| Command                                   | Description                  |
| ----------------------------------------- | ---------------------------- |
| pre-commit install                        | Install commit hooks         |
| pre-commit install --hook-type commit-msg | Install commit message hooks |
| pre-commit uninstall                      | Remove hooks                 |

### Running

| Command                           | Description                |
| --------------------------------- | -------------------------- |
| pre-commit run --all-files        | Run all hooks on all files |
| pre-commit run ruff --all-files   | Run only ruff hook         |
| pre-commit run mypy --all-files   | Run only mypy hook         |
| pre-commit run bandit --all-files | Run only bandit hook       |

### Maintenance

| Command               | Description                         |
| --------------------- | ----------------------------------- |
| pre-commit autoupdate | Update all hooks to latest versions |
| pre-commit clean      | Clear cached hook environments      |
| pre-commit gc         | Garbage collect unused environments |

## Git

### Daily Workflow

| Command                       | Description                      |
| ----------------------------- | -------------------------------- |
| git add .                     | Stage all changes                |
| git add path/to/file          | Stage a specific file            |
| git commit -m "type: message" | Commit with conventional message |
| git push                      | Push to remote                   |
| git pull                      | Pull latest changes              |
| git status                    | Check working tree status        |
| git diff                      | Show unstaged changes            |
| git log --oneline -10         | Show last 10 commits             |

### Branching

| Command                            | Description                 |
| ---------------------------------- | --------------------------- |
| git branch                         | List branches               |
| git branch feature/my-feature      | Create a branch             |
| git checkout feature/my-feature    | Switch to a branch          |
| git checkout -b feature/my-feature | Create and switch           |
| git merge feature/my-feature       | Merge a branch into current |
| git branch -d feature/my-feature   | Delete a branch             |

### Tags and Releases

| Command                               | Description          |
| ------------------------------------- | -------------------- |
| git tag                               | List all tags        |
| git tag -a v0.1.0 -m "Release v0.1.0" | Create annotated tag |
| git push origin v0.1.0                | Push a tag           |
| git push --tags                       | Push all tags        |

### Bypassing Hooks (Use Sparingly!)

| Command                             | Description           |
| ----------------------------------- | --------------------- |
| git commit --no-verify -m "message" | Skip pre-commit hooks |
| git push --no-verify                | Skip pre-push hooks   |

Warning: Only use --no-verify when absolutely necessary. CI will still catch issues.

## GitHub CLI (gh)

### Issues

| Command            | Description                   |
| ------------------ | ----------------------------- |
| gh issue create    | Create an issue interactively |
| gh issue list      | List open issues              |
| gh issue view 123  | View issue #123               |
| gh issue close 123 | Close issue #123              |

### Pull Requests

| Command            | Description               |
| ------------------ | ------------------------- |
| gh pr create       | Create a PR interactively |
| gh pr list         | List open PRs             |
| gh pr view 123     | View PR #123              |
| gh pr merge 123    | Merge PR #123             |
| gh pr checkout 123 | Checkout PR #123 locally  |

### Releases

| Command                                   | Description      |
| ----------------------------------------- | ---------------- |
| gh release create v0.1.0 --generate-notes | Create a release |
| gh release list                           | List releases    |
| gh release view v0.1.0                    | View a release   |

### Labels

| Command                              | Description     |
| ------------------------------------ | --------------- |
| gh label create "name" --color "hex" | Create a label  |
| gh label list                        | List all labels |
| gh label delete "name" --yes         | Delete a label  |

### Repository

| Command                 | Description          |
| ----------------------- | -------------------- |
| gh repo view            | View repo info       |
| gh repo clone user/repo | Clone a repo         |
| gh repo view --web      | Open repo in browser |
