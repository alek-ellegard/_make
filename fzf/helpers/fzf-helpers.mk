# Get the directory of this include file
FZF_HELPERS_DIR := $(dir $(lastword $(MAKEFILE_LIST)))

# Define shell function to source both helper scripts
define FZF_RUN
	bash -c 'source $(MK_DIR)/ui/ui.sh && source $(MK_DIR)/fzf/helpers/fzf-helpers.sh && $(1)'
endef

# UI-enhanced project selection
define FZF_SELECT_PROJECT
	$(call start,Project Selection)
	$(call FZF_RUN,select_project "$(1)")
	$(call end)
endef

# UI-enhanced ticket selection
define FZF_SELECT_TICKET_FOR_PROJECT
	$(call start,Ticket Selection)
	$(call FZF_RUN,select_ticket_for_project "$(1)" "$(2)")
	$(call end)
endef

# Complete interactive selection with UI
define FZF_SELECT_PROJECT_AND_TICKET
	$(call FZF_RUN,select_project_and_ticket)
endef

# New: Cleanup with confirmation
define FZF_CLEANUP_PROJECT
	$(call FZF_RUN,cleanup_project_artifacts "$(1)")
endef

# New: List projects with formatting
define FZF_LIST_PROJECTS
	$(call ui_info,Available projects:)
	$(call FZF_RUN,find projects -maxdepth 1 -type d ! -name "projects" | sed 's|^projects/||' | grep -vE "^(archive|deprecated)" | sort | table)
endef
