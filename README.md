## Revised Process Flow: Setting Up a Python Project with UV & Linters (Starting with uv init)

graph TD
    A[Start: New Project Creation] --> B[Run 'uv init <project-name>'];
    B --> C[Change Directory into Project];
    C --> D[Initialize Git Repository];
    D --> E[Create GitHub Repository & Connect Local Git];
    E --> F[Define Dev Dependencies in pyproject.toml];
    F --> G[Install Dev Dependencies (Linters/Formatters) with UV];
    G --> H[Configure Linters & Formatters];
    H --> I[Integrate Pre-commit Hooks];
    I --> J[Configure CI/CD Pipeline];
    J --> K[Document Setup & Usage];
    K --> L[End: Ready for Development];

    G --> G1[Example Linters: Ruff (Linter/Formatter), Mypy (Type Checker)];
    H --> H1[Configuration Files: pyproject.toml, .mypy.ini];
    I --> I1[Pre-commit: .pre-commit-config.yaml];
    J --> J1[CI/CD: GitHub Actions, GitLab CI];


---

## Revised Checklist/Steps for a Project Template (UV + Linters)

This checklist reflects your preferred uv init first, followed by GitHub repo creation.

### Phase 1: Project Initialization & Foundation

1.  Initialize Project with UV:
    *   uv init my-awesome-project-template
        *   *What this does:*
            *   Creates the my-awesome-project-template directory.
            *   Creates a pyproject.toml file with basic project metadata.
            *   Creates and activates a .venv virtual environment within the directory.
            *   You'll see output like: Initialized project my-awesome-project-template at C:\dev\my-awesome-project-template

2.  Change into Project Directory:
    *   cd my-awesome-project-template
    *   *Note:* Your virtual environment created by uv init is likely already activated. If you open a new terminal, remember to activate it: source .venv/bin/activate (Linux/macOS) or .\.venv\Scripts\Activate.ps1 (Windows PowerShell).

3.  Initialize Git Repository Locally:
    *   git init
    *   Create an initial .gitignore file. A good starting point is github/gitignore/Python.gitignore (you can copy its content into .gitignore).

4.  Create GitHub Repository & Connect Local Git:
    *   Go to GitHub (or your preferred Git hosting service) and create a new empty repository with the same name (my-awesome-project-template).
    *   Do NOT initialize with a README or license on GitHub yet, as uv init already set up your local project structure.
    *   Follow the instructions provided by GitHub for "push an existing repository from the command line":
        *   Make an initial commit:
            
            git add .
            git commit -m "feat: Initial project structure with uv init"
            
        *   Connect to remote:
            
            git remote add origin https://github.com/<your-username>/my-awesome-project-template.git
            git branch -M main # Renames your default branch to 'main'
            git push -u origin main
            
    *   *Rationale:* This sets up version control and remote collaboration early.

5.  Define Project Dependencies (Application & Development):
    *   Open the pyproject.toml file that uv init created.
    *   Core Application Dependencies: If you have any initial production dependencies, add them under [project.dependencies].
        
        # pyproject.toml
        [project]
        name = "my_awesome_project"
        version = "0.1.0"
        dependencies = [
            # Example production dependencies
            "requests~=2.31",
            "fastapi~=0.104",
        ]
        
    *   Development Dependencies: Add a [project.optional-dependencies.dev] section for linters, formatters, and testing frameworks.
        
        # pyproject.toml (continued)
        [project.optional-dependencies]
        dev = [
            "ruff~=0.1",          # Linter and Formatter
            "mypy~=1.7",          # Type Checker
            "pre-commit~=3.6",    # Git Hooks
            "pytest~=7.4",        # Testing Framework
        ]
        
    *   Install Development Dependencies:
        *   uv pip install -e ".[dev]" (This installs your current project in editable mode and all packages listed under dev optional dependencies).
    *   *Rationale:* pyproject.toml is the modern single source of truth for dependencies. UV efficiently installs these defined groups.

### Phase 2: Linter & Formatter Configuration

6.  Configure Ruff (Linter & Formatter):
    *   Add [tool.ruff] section to your pyproject.toml.
    *   Minimum Recommended Configuration: (As in previous response, feel free to copy)
        
        # pyproject.toml (continued)
        [tool.ruff]
        line-length = 88
        target-version = "py310" # Set to your project's target Python version

        [tool.ruff.lint]
        select = ["E", "F", "I", "N", "W", "B", "C4", "A", "UP", "PL", "SIM", "PTH", "TID"]
        ignore = [] # Add rules to ignore project-wide if necessary

        exclude = [".git", "__pycache__", "build", "dist", ".venv"]
        fixable = ["ALL"]

        [tool.ruff.lint.per-file-ignores]
        "__init__.py" = ["F401"]
        "tests/Ⓑ/*.py" = ["S101"]

        [tool.ruff.format]
        quote-style = "double"
        indent-style = "space"
        skip-magic-trailing-comma = false
        
    *   *Rationale:* Ruff is a single, fast tool for both linting and formatting.

7.  Configure Mypy (Type Checker):
    *   Add [tool.mypy] section to your pyproject.toml.
    *   Minimum Recommended Configuration: (As in previous response, feel free to copy)
        
        # pyproject.toml (continued)
        [tool.mypy]
        python_version = "3.10" # Match your project's target Python version
        warn_return_any = true
        warn_unused_configs = true
        warn_unused_ignores = true
        disallow_untyped_defs = true
        no_implicit_optional = true
        strict_optional = true
        show_error_codes = true
        pretty = true

        exclude = ["venv/", "build/", "dist/", ".venv/"]

        [[tool.mypy.overrides]]
        module = "requests.*" # Example: if requests stubs are missing/incomplete
        ignore_missing_imports = true
        
    *   *Rationale:* Mypy ensures type correctness.

8.  (Optional) Add .editorconfig:
    *   Create a .editorconfig file in the root.
    
    # .editorconfig
    root = true

    [*]
    end_of_line = lf
    insert_final_newline = true
    trim_trailing_whitespace = true

    [*.py]
    indent_style = space
    indent_size = 4
    
    *   *Rationale:* Ensures consistency across development environments.

### Phase 3: Workflow Integration (Automation)

9.  Set Up Pre-commit Hooks:
    *   Create a .pre-commit-config.yaml file at the root.
    *   Minimum Recommended Configuration: (As in previous response, feel free to copy)
        
        # .pre-commit-config.yaml
        repos:
          - repo: https://github.com/astral-sh/ruff-pre-commit
            rev: v0.1.9 # Use the latest stable version of Ruff
            hooks:
              - id: ruff
                args: [--fix, --exit-non-zero-on-fix]
              - id: ruff-format
        
          - repo: https://github.com/pre-commit/mirrors-mypy
            rev: v1.7.1 # Use the latest stable version of Mypy
            hooks:
              - id: mypy
        
          - repo: https://github.com/pre-commit/pre-commit-hooks
            rev: v4.5.0 # Use the latest stable version
            hooks:
              - id: check-yaml
              - id: end-of-file-fixer
              - id:trailing-whitespace
              - id: debug-statements
        
    *   Install Pre-commit Hooks: pre-commit install
    *   *Rationale:* Catches common issues immediately, preventing them from entering version control.

10. Configure CI/CD Pipeline (e.g., GitHub Actions):
    *   Create a .github/workflows/lint.yml file.
    *   Example GitHub Actions Workflow: (As in previous response, feel free to copy)
        
        # .github/workflows/lint.yml
        name: Lint and Type Check

        on:
          push:
            branches: [ main, develop ]
          pull_request:
            branches: [ main, develop ]

        jobs:
          lint:
            runs-on: ubuntu-latest
            steps:
              - uses: actions/checkout@v4

              - name: Set up Python
                uses: actions/setup-python@v5
                with:
                  python-version: '3.10'
                  cache: 'uv'

              - name: Install uv
                run: |
                  pip install uv

              - name: Install Dependencies
                run: |
                  uv pip install -e ".[dev]"
                
              - name: Run Ruff Linter
                run: |
                  uv run ruff check .

              - name: Run Ruff Formatter Check
                run: |
                  uv run ruff format --check .

              - name: Run Mypy Type Checker
                run: |
                  uv run mypy .
        
    *   *Rationale:* Provides a consistent and reliable check for code quality across all contributions.

### Phase 4: Template Finalization & Documentation

11. Create Example Code:
    *   Add a simple Python file (e.g., src/main.py) and a tests/test_main.py with pytest for demonstration.

12. Update README.md:
    *   Provide clear instructions for anyone cloning this template:
        *   How to clone and cd into the project.
        *   How the pyproject.toml defines dependencies.
        *   How to activate the environment (source .venv/bin/activate).
        *   How to install pre-commit hooks (pre-commit install).
        *   How to manually run linters (uv run ruff check ., uv run ruff format ., uv run mypy .).
        *   Explanation of the tools used (UV, Ruff, Mypy, Pre-commit).
        *   How to run tests (uv run pytest).

13. Verify All Components:
    *   Make a new branch.
    *   Introduce errors (linting, formatting, typing) and verify that pre-commit blocks or fixes them.
    *   Push a branch to trigger the CI/CD pipeline and ensure it passes (or fails correctly).

This revised flow integrates uv init seamlessly, making the very first steps of project setup even faster and more consistent.