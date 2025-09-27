#---
#include $(MK_DIR)/fzf/base.mk
include $(MK_DIR)/fzf/crud/*.mk
include $(MK_DIR)/fzf/helpers/*.mk

# fzf/index.mk 
# - help aggregation responsible
help:
	@echo
	@echo "fzf"
	@echo
	@echo "  # Create file in selected directory"
	@echo "  make fzf-create type=file"
	@echo
	@echo "  # Read any file with preview"
	@echo "  make fzf-read"
	@echo
	@echo "  # Update: rename selected item"
	@echo "  make fzf-rename"
	@echo
	@echo "  # Delete with multi-select"
	@echo "  make fzf-delete-multi"
	@echo 
	@echo "  # Composite: select dir → create file in it"
	@echo "  make fzf-dir-then-create"
	@echo

