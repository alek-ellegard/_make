# ---
# FZF CRUD test targets
#

# Create new file with FZF directory selection
new:
	@bash -c 'source $(MK_DIR)/ui/ui.sh && \
		source $(MK_DIR)/fzf/crud/crud.sh && \
		dir=$$(select_dir "." "Select directory: ") || exit 1; \
		info "Selected: $$dir"; \
		read -p "File path (can include subdirs): " name && \
		full_path="$$dir/$$name" && \
		info "Creating: $$full_path" && \
		$${EDITOR:-nvim} "$$full_path"'

# Quick file selector and reader with arrow navigation
view:
	@bash -c 'source $(MK_DIR)/ui/ui.sh && \
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
	@bash -c 'source $(MK_DIR)/ui/ui.sh && \
		source $(MK_DIR)/fzf/crud/crud.sh && \
		file=$$(select_file "." "Edit file: ") || exit 1; \
		$${EDITOR:-nvim} "$$file"'

