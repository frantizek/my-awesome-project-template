# 📝 Conventional Commits Reference

This project follows the [Conventional Commits](https://www.conventionalcommits.org/) standard.

## Format

    <type>(<optional scope>): <description>

## All Commit Types

| Type     | Meaning                                                     | Example                                           |
| -------- | ----------------------------------------------------------- | ------------------------------------------------- |
| feat     | A new feature for the user                                  | feat: add dark mode toggle                        |
| fix      | A bug fix                                                   | fix: resolve crash on empty input                 |
| docs     | Documentation only changes                                  | docs: update API reference                        |
| style    | Code style (formatting, semicolons, etc.) — no logic change | style: fix indentation in utils.py                |
| refactor | Code change that neither fixes a bug nor adds a feature     | refactor: extract validation into helper function |
| perf     | Performance improvement                                     | perf: cache database query results                |
| test     | Adding or updating tests                                    | test: add unit tests for login flow               |
| build    | Changes to build system or dependencies                     | build: upgrade ruff to 0.11                       |
| ci       | Changes to CI/CD configuration                              | ci: add bandit step to GitHub Actions             |
| chore    | Maintenance tasks, no production code change                | chore: remove .idea/ from tracking                |
| revert   | Reverts a previous commit                                   | revert: undo feat: add dark mode toggle           |

## Optional: Scope

Add context in parentheses:

    feat(auth): add OAuth2 support
    fix(database): handle connection timeout
    docs(readme): add installation steps

## Optional: Breaking Change

Add ! after the type:

    feat!: remove Python 3.9 support
    refactor(api)!: change response format from XML to JSON

## Quick Reference

    feat:     ✨ New feature
    fix:      🐛 Bug fix
    docs:     📝 Documentation
    style:    💄 Formatting (no logic change)
    refactor: ♻️  Code restructuring
    perf:     ⚡ Performance
    test:     ✅ Tests
    build:    📦 Dependencies / build system
    ci:       👷 CI/CD pipeline
    chore:    🔧 Maintenance
    revert:   ⏪ Undo previous commit
