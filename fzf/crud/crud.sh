#!/bin/bash
# Generic FZF CRUD selectors
# composable selection → action mapping

# --
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
MK_PATH="$(cd "$SCRIPT_DIR/../.." && pwd)"
# --

source $MK_PATH/ui/ui.sh

# Get exclude patterns for find command
_get_exclude_args() {
  local exclude_dirs=".git __pycache__ .pytest_cache .mypy_cache venv .venv .hatch env dist build node_modules .next .nuxt coverage .sass-cache target vendor bin .tox .coverage htmlcov .idea .vscode .DS_Store .ruff_cache"
  local args=""
  for dir in $exclude_dirs; do
    args="$args -name \"$dir\" -prune -o"
  done
  echo "$args"
}

# Generic item selector (files and directories)
select_item() {
  local base_path="${1:-.}"
  local prompt="${2:-Select item: }"
  local preview="${3:-true}"

  local exclude_args=$(_get_exclude_args)
  local preview_cmd=""

  if [ "$preview" = "true" ]; then
    preview_cmd="--preview 'if [ -d {} ]; then ls -la {}; else head -50 {}; fi' --preview-window=right:50%:wrap"
  fi

  local selected
  selected=$(eval "find \"$base_path\" $exclude_args -print" 2>/dev/null |
    sed "s|^$base_path/||" |
    grep -v "^$" |
    sort |
    eval "fzf --prompt=\"$prompt\" --height=20 --layout=reverse $preview_cmd")

  if [ -z "$selected" ]; then
    return 1
  fi

  echo "$base_path/$selected"
  return 0
}

# File-specific selector
select_file() {
  local base_path="${1:-.}"
  local prompt="${2:-Select file: }"
  local preview="${3:-true}"

  local exclude_args=$(_get_exclude_args)
  local preview_cmd=""

  if [ "$preview" = "true" ]; then
    preview_cmd="--preview 'head -50 {}' --preview-window=right:50%:wrap"
  fi

  local selected
  selected=$(eval "find \"$base_path\" $exclude_args -type f -print" 2>/dev/null |
    sed "s|^$base_path/||" |
    grep -v "^$" |
    sort |
    eval "fzf --prompt=\"$prompt\" --height=20 --layout=reverse $preview_cmd")

  if [ -z "$selected" ]; then
    return 1
  fi

  echo "$base_path/$selected"
  return 0
}

# Directory-specific selector
select_dir() {
  local base_path="${1:-.}"
  local prompt="${2:-Select directory: }"
  local preview="${3:-true}"

  local exclude_args=$(_get_exclude_args)
  local preview_cmd=""

  if [ "$preview" = "true" ]; then
    preview_cmd="--preview 'ls -la {}' --preview-window=right:50%:wrap"
  fi

  local selected
  selected=$(eval "find \"$base_path\" $exclude_args -type d -print" 2>/dev/null |
    sed "s|^$base_path/||" |
    grep -v "^$" |
    sort |
    eval "fzf --prompt=\"$prompt\" --height=20 --layout=reverse $preview_cmd")

  if [ -z "$selected" ]; then
    return 1
  fi

  echo "$base_path/$selected"
  return 0
}

# Multi-select variant
select_multiple() {
  local base_path="${1:-.}"
  local prompt="${2:-Select items (TAB to mark): }"
  local type="${3:-all}" # all, file, dir

  local exclude_args=$(_get_exclude_args)
  local find_type=""

  case "$type" in
  file) find_type="-type f" ;;
  dir) find_type="-type d" ;;
  *) find_type="" ;;
  esac

  local selected
  selected=$(eval "find \"$base_path\" $exclude_args $find_type -print" 2>/dev/null |
    sed "s|^$base_path/||" |
    grep -v "^$" |
    sort |
    fzf --prompt="$prompt" --height=20 --layout=reverse --multi)

  if [ -z "$selected" ]; then
    return 1
  fi

  echo "$selected" | while read -r item; do
    echo "$base_path/$item"
  done
  return 0
}
