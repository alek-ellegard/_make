
#include $(MK_PATH)/hatch/<dir>/*.mk

test-hatch-index:
	make pwd
	make hatch-env

help-mk-hatch:
	@echo
	@echo ""
	@echo
	@echo "
		# Clean environment
		hatch-clean:

		hatch-remove-env: hatch-clean

		# Environment setup
		hatch-env:

		hatch-setup: hatch-env

		# Type checking
		hatch-types:

		# Linting and formatting
		hatch-lint:

		hatch-lint-check:

		# CI tasks
		hathc-ci: hatch-lint-check hatch-types hatch-test

		hatch-ci-fix: hatch-lint hatch-types hatch-test

		# Testing
		hatch-test:
		"
	@echo 
