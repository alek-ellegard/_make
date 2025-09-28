# This is a default goal that will run when you just type "make"
.DEFAULT_GOAL := help-hatch

# ==============================================================================
# HELP
# ==============================================================================

help-hatch:
	@echo "Available commands:"
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "  \033[36m%-20s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

# ==============================================================================
# ENVIRONMENT & CLEANUP
# ==============================================================================

hatch-clean: ## Clean all build artifacts and pycache
	@echo "Cleaning environment..."
	# Your clean command here

hatch-remove-env: hatch-clean ## Remove the virtual environment completely
	@echo "Removing environment..."
	# Your remove command here

hatch-env: ## Create or update the virtual environment
	@echo "Setting up environment..."
	# Your env setup command here

hatch-setup: hatch-env ## Alias for hatch-env

# ==============================================================================
# QUALITY & LINTING
# ==============================================================================

hatch-types: ## Run static type checking with mypy
	@echo "Running type checks..."
	# Your type check command here

hatch-lint: ## Fix linting and formatting issues automatically
	@echo "Linting and formatting..."
	# Your linting command here

hatch-lint-check: ## Check for linting and formatting issues
	@echo "Checking linting..."
	# Your lint check command here

# ==============================================================================
# CI & TESTING
# ==============================================================================

hatch-test: ## Run the test suite
	@echo "Running tests..."
	# Your test command here

hatch-ci: hatch-lint-check hatch-types hatch-test ## Run all CI checks (lint, types, tests)
	@echo "CI checks passed!"

hatch-ci-fix: hatch-lint hatch-types hatch-test ## Run all CI checks, attempting to fix issues
	@echo "CI fix process complete!"
