# --------
#  helpers
pwd := $(shell pwd)
include $(MK_DIR)/general/excludes.mk

nvim:
	@nvim .
code:
	@bash -c "cursor ."
gitignore:
	@nvim .gitignore

# ---
# dir and files
pwd:
	@echo "$(pwd)"

pwd-cp: pwd-copy
pwd-copy:
	@make pwd
	@make pwd | pbcopy

dirs:
	@find . $(PRUNE_ARGS) -type d -print | sort

files:
	@find . $(PRUNE_ARGS) -type f -print $(PATTERN_ARGS) | sort

files-depth-1:
	@find . $(PRUNE_ARGS) -maxdepth 1 -type f -print $(PATTERN_ARGS) | sort

files-bat:
ifdef files
	@# Show specific files
	@for file in $(files); do \
		if [ -f "$$file" ]; then \
			bat "$$file"; \
		else \
			echo "File not found: $$file" >&2; \
		fi; \
	done
else ifdef depth
	@# Show files up to specified depth
	@find . $(PRUNE_ARGS) -maxdepth $(depth) -type f $(PATTERN_ARGS) -exec bat {} \;
else
	@# Default: show files at depth 1
	@find . $(PRUNE_ARGS) -maxdepth 1 -type f $(PATTERN_ARGS) -exec bat {} \;
endif
