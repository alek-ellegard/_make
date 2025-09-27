# Parameter validation checks
.PHONY: check-dir check-file check-user check-template-dir

check-dir:
	@[ -z "$(dir)" ] && { echo "Error: dir parameter required"; exit 1; } || true

check-file:  
	@[ -z "$(file)" ] && { echo "Error: file parameter required"; exit 1; } || true

check-user:
	@[ -z "$(user)" ] && { echo "Error: user parameter required"; exit 1; } || true

check-template-dir:
	@[ ! -d "projects/TEMPLATES" ] && { echo "Warning: project/TEMPLATES directory not found"; exit 1; } || true

# Composite checks
check-ticket-deps: check-dir check-template-dir

# Generic validation functions
define require_param
	@[ -z "$(1)" ] && { echo "Error: $(2) parameter required"; exit 1; } || true
endef

define warn_missing_dir
	@[ ! -d "$(1)" ] && echo "Warning: $(1) directory not found" || true
endef
