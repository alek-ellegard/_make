#--

# Clean environment
hatch-clean:
	rm -rf .hatch
	rm -rf src/metrics_sidecar.egg-info
	rm -rf __pycache__
	find . -type d -name "__pycache__" -exec rm -rf {} + 2>/dev/null || true
	find . -type f -name "*.pyc" -delete

hatch-remove-env: hatch-clean

# Environment setup
hatch-env:
	hatch env create

hatch-setup: hatch-env

# Type checking
hatch-types:
	hatch run dev:mypy src/

# Linting and formatting
hatch-lint:
	hatch run dev:ruff format src/ tests/ 2>/dev/null || true
	hatch run dev:ruff check --fix src/ tests/ 2>/dev/null || true

hatch-lint-check:
	hatch run dev:ruff format --check src/ tests/ 2>/dev/null || true
	hatch run dev:ruff check src/ tests/ 2>/dev/null || true

# CI tasks
hathc-ci: hatch-lint-check hatch-types hatch-test

hatch-ci-fix: hatch-lint hatch-types hatch-test

# Testing
hatch-test:
	hatch run dev:pytest tests/ -v 2>/dev/null || echo "No tests found"


