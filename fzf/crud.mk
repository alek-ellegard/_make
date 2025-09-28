# ---
# FZF CRUD test targets
#

# Create new file with FZF directory selection
new:
	@echo
	@bash -c 'source $(UI_SH) && \
		source $(MK_DIR)/fzf/crud/crud.sh && \
		dir=$$(select_dir "." "Select directory: ") || exit 1; \
		info "Selected: $$dir"; \
		read -p "File path (can include subdirs): " name && \
		full_path="$$dir/$$name" && \
		info "Creating: $$full_path" && \
		$${EDITOR:-nvim} "$$full_path"'

# Quick file selector and reader with arrow navigation
view:
	@echo
	@bash -c 'source $(UI_SH) && \
		source $(MK_DIR)/fzf/crud/crud.sh && \
		exclude_args=$$(_get_exclude_args) && \
		eval "find . $$exclude_args -type f -print" 2>/dev/null | \
		sed "s|^\./||" | \
		grep -v "^$$" | \
		sort | \
		fzf --prompt="View file: " \
		    --height=80% \
		    --layout=reverse \
		    --border \
		    --preview="if command -v bat >/dev/null; then bat --color=always --style=numbers {}; else cat {}; fi" \
		    --preview-window=right:60%:wrap \
		    --bind="enter:execute(if command -v bat >/dev/null; then bat --paging=always {}; else less {}; fi)" \
		    --bind="ctrl-e:execute(\$${EDITOR:-vi} {})" \
		    --bind="?:toggle-preview" \
		    --bind="esc:abort" \
		    --header="Arrows=nav, ENTER=view, Ctrl-E=edit, ESC=exit, ?=toggle preview"'

# Quick file editor
edit:
	@echo
	@bash -c 'source $(UI_SH) && \
		source $(MK_DIR)/fzf/crud/crud.sh && \
		file=$$(select_file "." "Edit file: ") || exit 1; \
		$${EDITOR:-nvim} "$$file"'

# File path display with clipboard copy
f-pwd:
	@echo
<<<<<<< HEAD
	@bash -c 'source $(MK_PATH)/ui/ui.sh && \
		source $(MK_PATH)/fzf/crud/crud.sh && \
=======
	@bash -c 'source $(MK_DIR)/ui/ui.sh && \
		source $(MK_DIR)/fzf/crud/crud.sh && \
>>>>>>> cd80c82 (﻿ refactor: 🔨 convenience)
		exclude_args=$$(_get_exclude_args) && \
		file=$$(eval "find . $$exclude_args -type f -print" 2>/dev/null | \
			sed "s|^\\./||" | \
			grep -v "^$$" | \
			sort | \
			fzf --prompt="Select file for path: " \
			    --height=80% \
			    --layout=reverse \
			    --border \
			    --preview="if command -v bat >/dev/null; then bat --color=always --style=numbers {}; else cat {}; fi" \
			    --preview-window=right:60%:wrap \
			    --bind="?:toggle-preview" \
			    --bind="esc:abort" \
			    --header="Arrows=nav, ENTER=select, ESC=exit, ?=toggle preview") || exit 1; \
		rel_path="./$$file" && \
		abs_path="$$(cd "$$(dirname "$$file")" && pwd)/$$(basename "$$file")" && \
		echo "" && \
		info "Relative path: $$rel_path" && \
		info "Absolute path: $$abs_path" && \
		echo "" && \
		if command -v pbcopy >/dev/null 2>&1; then \
			echo "$$abs_path" | pbcopy && \
			ok "Absolute path copied to clipboard"; \
		elif command -v xclip >/dev/null 2>&1; then \
			echo "$$abs_path" | xclip -selection clipboard && \
			ok "Absolute path copied to clipboard"; \
		else \
			warn "Clipboard tool not found (pbcopy/xclip)"; \
		fi'

