EXCLUDE_DIRS := .git __pycache__ .pytest_cache .mypy_cache venv .venv .hatch env dist build \
  node_modules .next .nuxt coverage .sass-cache \
  target vendor bin \
  .tox .coverage htmlcov .idea .vscode .DS_Store \
  .ruff_cache

EXCLUDE_PATTERNS := "*.pyc" "*.pyo" "*.pyd" "__pycache__" \
  "*.o" "*.so" "*.dylib" "*.dll" \
  "*.log" "*.tmp" "*.temp" \
  ".*.swp" ".*.swo" "*~" \
  "Thumbs.db" ".DS_Store"

# Generate -name "dir" -prune arguments
PRUNE_ARGS := $(foreach dir,$(EXCLUDE_DIRS),-name "$(dir)" -prune -o)

# Generate -not -name "pattern" arguments
PATTERN_ARGS := $(foreach pattern,$(EXCLUDE_PATTERNS),-not -name $(pattern))
