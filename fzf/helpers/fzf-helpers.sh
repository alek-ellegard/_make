#!/bin/bash
# functions:
# - select_project_and_ticket
#   - select_project
#   - select_ticket_for_project

# ---

source $MK_PATH/ui/ui.sh

ui_selected() {
  _log "selected" "▶" "${_COLOR_SUCCESS-}" "$@" >&2
}

# ---

# Select project from projects directory
select_project() {
  local prompt="${1:-Select project: }"
  local selected_project

  selected_project=$(find projects -maxdepth 1 -type d ! -name "projects" 2>/dev/null |
    sed 's|^projects/||' |
    grep -vE "^(archive|deprecated|TEMPLATES|.claude\.)" |
    sort |
    fzf --prompt="$prompt" --height=15 --layout=reverse)

  if [ -z "$selected_project" ]; then
    return 1
  fi

  # ui echo
  ui_selected "project: $selected_project"
  # return
  echo "$selected_project"
  return 0
}

# Select ticket from project directory
select_ticket_for_project() {
  local project_name="$1"
  local prompt="${2:-Select ticket: }"
  local selected_ticket

  if [ ! -d "projects/$project_name" ]; then
    fail "Project directory not found: projects/$project_name"
  fi

  debug "Scanning tickets in project: $project_name"

  selected_ticket=$(find "projects/$project_name" -maxdepth 1 -type d ! -name "$project_name" 2>/dev/null |
    sed "s|^projects/$project_name/||" |
    sort |
    fzf --prompt="$prompt" --height=15 --layout=reverse)

  if [ -z "$selected_ticket" ]; then
    warn "No ticket selected"
    return 1
  fi

  ui_selected "ticket: $selected_ticket"
  echo "$selected_ticket"
  return 0
}

select_project_and_ticket() {
  title "Interactive Project & Ticket Selection"

  info "Step 1: Choose project"
  SELECTED_PROJECT=$(select_project) || {
    fail "Project selection required"
  }

  info "Step 2: Choose ticket"
  SELECTED_TICKET=$(select_ticket_for_project "$SELECTED_PROJECT") || {
    fail "Ticket selection required"
  }

  local result="projects/$SELECTED_PROJECT/$SELECTED_TICKET"
  ok "Selected: $result"

  # return
  echo "$result"
  return 0
}

# New function: cleanup with confirmation
cleanup_project_artifacts() {
  local project="$1"

  if [ -z "$project" ]; then
    project=$(select_project "Select project to clean: ") || return 1
  fi

  title "Cleanup Project: $project"

  local artifacts_dir="projects/$project/.artifacts"
  if [ -d "$artifacts_dir" ]; then
    info "Found artifacts directory: $artifacts_dir"
    if confirm "Remove all artifacts?"; then
      rm -rf "$artifacts_dir"
      ok "Artifacts cleaned"
    else
      info "Cleanup cancelled"
    fi
  else
    info "No artifacts directory found"
  fi
}
