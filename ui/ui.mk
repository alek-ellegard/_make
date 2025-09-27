#! bin/bash

# Get the directory of this include file
UI_HELPERS_DIR := $(dir $(lastword $(MAKEFILE_LIST)))

# Define shell function to source UI and run commands
define UI_RUN
	bash -c 'source $(UI_HELPERS_DIR)/ui.sh && $(1)'
endef

define ui_title
	$(call UI_RUN,title "$(1)")
endef

define ui_info
	$(call UI_RUN,info "$(1)")
endef

define ui_ok
	$(call UI_RUN,ok "$(1)")
endef

define ui_fail
	$(call UI_RUN,fail "$(1)")
endef

# Enhanced separators with UI consistency
define start
	$(call ui_title,$(1))
endef

define end
	@echo
endef

# New: UI-aware confirmation
define ui_confirm
	$(call UI_RUN,confirm "$(1)")
endef
