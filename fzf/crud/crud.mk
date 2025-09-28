# Generic FZF CRUD operations
# Composable selection → action targets

# Include dependencies
include $(MK_PATH)/ui/ui.mk
-include $(MK_PATH)/general/excludes.mk

# Source paths
FZF_CRUD_DIR := $(dir $(lastword $(MAKEFILE_LIST)))

# Run macro for CRUD operations
define FZF_CRUD_RUN
	bash -c 'source $(MK_PATH)/ui/ui.sh && source $(MK_PATH)/fzf/crud/crud.sh && $(1)'
endef

# CREATE operations
.PHONY: fzf-create
fzf-create: ## Create file/dir with FZF selection
	@$(call FZF_CRUD_RUN, \
		dir=$$(select_dir "." "Select parent directory: ") || exit 1; \
		$(MK_PATH)/ui/ui.sh && info "Selected: $$dir"; \
		read -p "Name for new item: " name; \
		read -p "Type (file/dir): " type; \
		if [ "$$type" = "dir" ]; then \
			mkdir -p "$$dir/$$name" && ok "Created directory: $$dir/$$name"; \
		else \
			touch "$$dir/$$name" && ok "Created file: $$dir/$$name"; \
		fi)

# READ operations
.PHONY: fzf-read
fzf-read: ## Read/preview file with FZF selection
	@$(call FZF_CRUD_RUN, \
		file=$$(select_file "." "Select file to read: ") || exit 1; \
		if command -v bat >/dev/null; then \
			bat "$$file"; \
		else \
			cat "$$file"; \
		fi)

.PHONY: fzf-tree
fzf-tree: ## Show directory tree with FZF selection
	@$(call FZF_CRUD_RUN, \
		dir=$$(select_dir "." "Select directory: ") || exit 1; \
		if command -v tree >/dev/null; then \
			tree -L 2 "$$dir"; \
		else \
			ls -la "$$dir"; \
		fi)

# UPDATE operations
.PHONY: fzf-edit
fzf-edit: ## Edit file with FZF selection
	@$(call FZF_CRUD_RUN, \
		file=$$(select_file "." "Select file to edit: ") || exit 1; \
		$${EDITOR:-vi} "$$file")

.PHONY: fzf-rename
fzf-rename: ## Rename item with FZF selection
	@$(call FZF_CRUD_RUN, \
		item=$$(select_item "." "Select item to rename: ") || exit 1; \
		$(MK_PATH)/ui/ui.sh && info "Selected: $$item"; \
		read -p "New name: " new_name; \
		dir=$$(dirname "$$item"); \
		mv "$$item" "$$dir/$$new_name" && ok "Renamed to: $$dir/$$new_name")

.PHONY: fzf-move
fzf-move: ## Move item with FZF selection
	@$(call FZF_CRUD_RUN, \
		item=$$(select_item "." "Select item to move: ") || exit 1; \
		$(MK_PATH)/ui/ui.sh && info "Selected: $$item"; \
		dest=$$(select_dir "." "Select destination: ") || exit 1; \
		mv "$$item" "$$dest/" && ok "Moved to: $$dest/")

# DELETE operations
.PHONY: fzf-delete
fzf-delete: ## Delete item with FZF selection and confirmation
	@$(call FZF_CRUD_RUN, \
		item=$$(select_item "." "Select item to delete: ") || exit 1; \
		source $(MK_PATH)/ui/ui.sh && \
		if confirm "Delete $$item?"; then \
			rm -rf "$$item" && ok "Deleted: $$item"; \
		else \
			info "Cancelled"; \
		fi)

.PHONY: fzf-delete-multi
fzf-delete-multi: ## Delete multiple items with FZF multi-select
	@$(call FZF_CRUD_RUN, \
		items=$$(select_multiple "." "Select items to delete (TAB to mark): " "all") || exit 1; \
		source $(MK_PATH)/ui/ui.sh && \
		count=$$(echo "$$items" | wc -l | tr -d " "); \
		if confirm "Delete $$count items?"; then \
			echo "$$items" | while read -r item; do \
				rm -rf "$$item" && echo "  ✓ $$item"; \
			done && ok "Deleted $$count items"; \
		else \
			info "Cancelled"; \
		fi)

# Composite operations
.PHONY: fzf-dir-then-create
fzf-dir-then-create: ## Select directory then create file in it
	@$(call FZF_CRUD_RUN, \
		dir=$$(select_dir "." "Select directory: ") || exit 1; \
		source $(MK_PATH)/ui/ui.sh && info "Selected: $$dir"; \
		read -p "File name: " name; \
		touch "$$dir/$$name" && ok "Created: $$dir/$$name"; \
		if confirm "Edit now?"; then \
			$${EDITOR:-vi} "$$dir/$$name"; \
		fi)

# Test target
.PHONY: test-fzf-crud
test-fzf-crud: ## Test FZF CRUD operations
	@echo "Testing FZF CRUD selectors..."
	@$(call FZF_CRUD_RUN, \
		echo "✓ crud.sh sourced"; \
		type select_item >/dev/null && echo "✓ select_item available"; \
		type select_file >/dev/null && echo "✓ select_file available"; \
		type select_dir >/dev/null && echo "✓ select_dir available"; \
		type select_multiple >/dev/null && echo "✓ select_multiple available")
	@echo "✓ All CRUD functions loaded"
	@echo ""
	@echo "Try: make fzf-read"

# Help for CRUD operations
.PHONY: fzf-crud-help
fzf-crud-help: ## Show FZF CRUD operations help
	@echo
	@echo "FZF CRUD Operations:"
	@echo ""
	@echo "  CREATE:"
	@echo "    make fzf-create        - Create file or directory"
	@echo ""
	@echo "  READ:"
	@echo "    make fzf-read          - View file contents"
	@echo "    make fzf-tree          - Show directory tree"
	@echo ""
	@echo "  UPDATE:"
	@echo "    make fzf-edit          - Edit file"
	@echo "    make fzf-rename        - Rename file or directory"
	@echo "    make fzf-move          - Move file or directory"
	@echo ""
	@echo "  DELETE:"
	@echo "    make fzf-delete        - Delete single item"
	@echo "    make fzf-delete-multi  - Delete multiple items"
	@echo ""
	@echo "  COMPOSITE:"
	@echo "    make fzf-dir-then-create - Select dir, then create file"
	@echo
