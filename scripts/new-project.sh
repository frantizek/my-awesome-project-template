#!/usr/bin/env bash
# ──────────────────────────────────────────────────
# New Python Project Setup Script
# Creates a new project using the template configuration
#
# Usage:
#   bash scripts/new-project.sh my-project-name
#   bash scripts/new-project.sh my-project-name /path/to/parent/dir
#
# Requires: uv, git, gh (GitHub CLI), pre-commit
# ──────────────────────────────────────────────────

set -e

# ──────────────── Colors ────────────────
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# ──────────────── Helper Functions ────────────────
info() { echo -e "${BLUE}ℹ️  $1${NC}"; }
success() { echo -e "${GREEN}✅ $1${NC}"; }
warn() { echo -e "${YELLOW}⚠️  $1${NC}"; }
error() { echo -e "${RED}❌ $1${NC}"; exit 1; }
step() { echo -e "\n${CYAN}──────────── $1 ────────────${NC}"; }

# ──────────────── Validate Input ────────────────
if [ -z "\$1" ]; then
    error "Usage: bash scripts/new-project.sh <project-name> [parent-directory]"
fi

PROJECT_NAME="\$1"
PARENT_DIR="${2:-.}"
PROJECT_PATH="$PARENT_DIR/$PROJECT_NAME"
TEMPLATE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

# Convert project name to Python module name (hyphens to underscores)
MODULE_NAME="${PROJECT_NAME//-/_}"

echo ""
echo -e "${CYAN}🚀 Creating new Python project: ${GREEN}$PROJECT_NAME${NC}"
echo -e "${CYAN}   Template source: ${GREEN}$TEMPLATE_DIR${NC}"
echo -e "${CYAN}   Project path:    ${GREEN}$PROJECT_PATH${NC}"
echo -e "${CYAN}   Module name:     ${GREEN}$MODULE_NAME${NC}"
echo ""

# ──────────────── Check Prerequisites ────────────────
step "Checking Prerequisites"

if ! command -v uv &> /dev/null; then
    error "UV is not installed. Install it: https://docs.astral.sh/uv/getting-started/installation/"
fi
success "UV found: $(uv --version)"

if ! command -v git &> /dev/null; then
    error "Git is not installed. Install it: https://git-scm.com/downloads"
fi
success "Git found: $(git --version)"

if ! command -v gh &> /dev/null; then
    warn "GitHub CLI (gh) not found. Skipping GitHub repo creation."
    warn "Install it later: https://cli.github.com/"
    HAS_GH=false
else
    success "GitHub CLI found: $(gh --version | head -1)"
    HAS_GH=true
fi

if ! command -v pre-commit &> /dev/null; then
    warn "pre-commit not found globally. Will install via dev dependencies."
    HAS_PRECOMMIT=false
else
    success "pre-commit found: $(pre-commit --version)"
    HAS_PRECOMMIT=true
fi

# Check if project already exists
if [ -d "$PROJECT_PATH" ]; then
    error "Directory $PROJECT_PATH already exists!"
fi

# ──────────────── Step 1: Initialize with UV ────────────────
step "Step 1: Initializing project with UV"

cd "$PARENT_DIR"
uv init "$PROJECT_NAME"
cd "$PROJECT_NAME"
success "Project initialized with UV"

# ──────────────── Step 2: Copy Template Files ────────────────
step "Step 2: Copying template files"

# Core config files
cp "$TEMPLATE_DIR/.editorconfig" . 2>/dev/null && success "Copied .editorconfig" || warn "No .editorconfig found"
cp "$TEMPLATE_DIR/.gitattributes" . 2>/dev/null && success "Copied .gitattributes" || warn "No .gitattributes found"
cp "$TEMPLATE_DIR/.pre-commit-config.yaml" . 2>/dev/null && success "Copied .pre-commit-config.yaml" || warn "No .pre-commit-config.yaml found"

# VS Code settings
if [ -d "$TEMPLATE_DIR/.vscode" ]; then
    cp -r "$TEMPLATE_DIR/.vscode" .
    success "Copied .vscode/"
else
    warn "No .vscode/ found in template"
fi

# GitHub workflows
if [ -d "$TEMPLATE_DIR/.github" ]; then
    cp -r "$TEMPLATE_DIR/.github" .
    success "Copied .github/"
else
    warn "No .github/ found in template"
fi

# Scripts
if [ -d "$TEMPLATE_DIR/scripts" ]; then
    cp -r "$TEMPLATE_DIR/scripts" .
    success "Copied scripts/"
else
    warn "No scripts/ found in template"
fi

# Docs
if [ -d "$TEMPLATE_DIR/docs" ]; then
    cp -r "$TEMPLATE_DIR/docs" .
    success "Copied docs/"
else
    warn "No docs/ found in template"
fi

# ──────────────── Step 3: Update .gitignore ────────────────
step "Step 3: Setting up .gitignore"

curl -sL -o .gitignore https://raw.githubusercontent.com/github/gitignore/main/Python.gitignore
cat >> .gitignore << 'EOF'

# IDE
.idea/

# OS
.DS_Store
Thumbs.db
EOF
success "Downloaded and updated .gitignore"

# ──────────────── Step 4: Update pyproject.toml ────────────────
step "Step 4: Updating pyproject.toml"

cat > pyproject.toml << EOF
[project]
name = "$PROJECT_NAME"
version = "0.1.0"
description = "Add your description here"
readme = "README.md"
requires-python = ">=3.11"
dependencies = []

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

# ──────────────── RUFF ────────────────
[tool.ruff]
line-length = 120
target-version = "py311"

[tool.ruff.lint]
select = [
    "E",
    "W",
    "F",
    "I",
    "N",
    "UP",
    "B",
    "SIM",
    "C4",
    "A",
    "PL",
    "PTH",
    "TID",
    "S",
    "DTZ",
    "RUF",
]
ignore = []
exclude = [".git", "__pycache__", "build", "dist", ".venv"]
fixable = ["ALL"]

[tool.ruff.lint.per-file-ignores]
"__init__.py" = ["F401"]
"tests/**/*.py" = ["S101"]

[tool.ruff.lint.isort]
known-first-party = ["$MODULE_NAME"]

[tool.ruff.format]
quote-style = "double"
indent-style = "space"
skip-magic-trailing-comma = false

# ──────────────── MYPY ────────────────
[tool.mypy]
python_version = "3.11"
warn_return_any = true
warn_unused_configs = true
warn_unused_ignores = true
disallow_untyped_defs = true
no_implicit_optional = true
strict_optional = true
show_error_codes = true
pretty = true
explicit_package_bases = true
exclude = ["venv/", "build/", "dist/", ".venv/"]

[[tool.mypy.overrides]]
module = "requests.*"
ignore_missing_imports = true

# ──────────────── PYTEST ────────────────
[tool.pytest.ini_options]
pythonpath = ["src"]
testpaths = ["tests"]
addopts = "-v --tb=short --cov=src --cov-report=term-missing"

# ──────────────── BANDIT ────────────────
[tool.bandit]
exclude_dirs = [".venv", "build", "dist"]
skips = ["B101"]
EOF
success "Updated pyproject.toml with $MODULE_NAME as first-party module"

# ──────────────── Step 5: Create Project Structure ────────────────
step "Step 5: Creating project structure"

mkdir -p src tests
touch src/__init__.py
touch tests/__init__.py

cat > tests/test_main.py << 'EOF'
from main import main


def test_main() -> None:
    main()
EOF
success "Created src/ and tests/ directories"

# ──────────────── Step 6: Install Dependencies ────────────────
step "Step 6: Installing dependencies"

uv pip install -e ".[dev]"
success "Dev dependencies installed"

# ──────────────── Step 7: Install Pre-commit Hooks ────────────────
step "Step 7: Installing pre-commit hooks"

if [ "$HAS_PRECOMMIT" = true ]; then
    pre-commit install
    pre-commit install --hook-type commit-msg
    success "Pre-commit hooks installed"
else
    uv run pre-commit install
    uv run pre-commit install --hook-type commit-msg
    success "Pre-commit hooks installed (via uv run)"
fi

# ──────────────── Step 8: Initialize Git ────────────────
step "Step 8: Initializing Git"

# Check if git is already initialized (uv init might do this)
if [ ! -d ".git" ]; then
    git init
fi
git add .
git commit -m "feat: initial project setup with tooling" --no-verify
success "Initial commit created"

# ──────────────── Step 9: GitHub Repository (Optional) ────────────────
step "Step 9: GitHub Repository"

if [ "$HAS_GH" = true ]; then
    echo ""
    read -p "Create a GitHub repository? (y/n): " CREATE_REPO
    if [ "$CREATE_REPO" = "y" ] || [ "$CREATE_REPO" = "Y" ]; then
        echo ""
        read -p "Visibility — public or private? (pub/priv): " VISIBILITY
        if [ "$VISIBILITY" = "pub" ]; then
            gh repo create "$PROJECT_NAME" --public --source=. --remote=origin --push
        else
            gh repo create "$PROJECT_NAME" --private --source=. --remote=origin --push
        fi
        success "GitHub repository created and pushed"

        echo ""
        read -p "Create labels? (y/n): " CREATE_LABELS
        if [ "$CREATE_LABELS" = "y" ] || [ "$CREATE_LABELS" = "Y" ]; then
            if [ -f "scripts/create-labels.sh" ]; then
                bash scripts/create-labels.sh
                success "Labels created"
            else
                warn "scripts/create-labels.sh not found"
            fi
        fi
    else
        info "Skipping GitHub repo creation"
        info "You can create it later with:"
        info "  gh repo create $PROJECT_NAME --public --source=. --remote=origin --push"
    fi
else
    info "GitHub CLI not installed. Create repo manually:"
    info "  git remote add origin https://github.com/<user>/$PROJECT_NAME.git"
    info "  git branch -M main"
    info "  git push -u origin main"
fi

# ──────────────── Summary ────────────────
step "Setup Complete!"

echo ""
echo -e "${GREEN}🎉 Project $PROJECT_NAME is ready!${NC}"
echo ""
echo -e "   ${CYAN}Project structure:${NC}"
echo ""
echo "   $PROJECT_NAME/"
echo "   ├── .github/workflows/lint.yaml"
echo "   ├── .vscode/"
echo "   │   ├── settings.json"
echo "   │   ├── extensions.json"
echo "   │   └── launch.json"
echo "   ├── docs/"
echo "   ├── scripts/"
echo "   ├── src/"
echo "   │   └── __init__.py"
echo "   ├── tests/"
echo "   │   ├── __init__.py"
echo "   │   └── test_main.py"
echo "   ├── .editorconfig"
echo "   ├── .gitattributes"
echo "   ├── .gitignore"
echo "   ├── .pre-commit-config.yaml"
echo "   ├── .python-version"
echo "   ├── main.py"
echo "   ├── pyproject.toml"
echo "   └── uv.lock"
echo ""
echo -e "   ${CYAN}Next steps:${NC}"
echo "   1. cd $PROJECT_NAME"
echo "   2. code .                    # Open in VS Code"
echo "   3. Start coding!"
echo ""
echo -e "   ${CYAN}Useful commands:${NC}"
echo "   uv run python main.py       # Run the project"
echo "   uv run pytest               # Run tests"
echo "   uv run ruff check .         # Lint"
echo "   uv run ruff format .        # Format"
echo "   uv run mypy .               # Type check"
echo ""
