Looking at your repository, I can see you're building a sophisticated Makefile-based workflow system with modular `.mk` includes and shell helpers. You've already established strong patterns with UI components, FZF integration, and file operations. Let me analyze your use case and create a focused PRD.## PRD: Generic FZF-Based CRUD System

### conceptual foundation

Your system demonstrates emergence through composition: shell functions + Make targets + FZF selection create a powerful workflow layer. The missing abstraction is **universal selection → action mapping**.

### core abstraction

```
selection :: Path → Filter → FZF → Item
action :: Item → Operation → Result
workflow :: selection ∘ action
```

### design principles

1. **path-agnostic selection**
   - works from any base path, not just `projects/`
   - recursive or depth-limited traversal
   - type-aware (files vs directories)

2. **composable actions**
   - selection is separate from action
   - one selection, multiple possible operations
   - chainable workflows

3. **filter inheritance**
   - respects existing EXCLUDE_DIRS and EXCLUDE_PATTERNS
   - additional runtime filters via FZF query
   - type filters (only files, only dirs, both)

### proposed architecture

```Markdown
fzf/crud/crud.sh:
  select_item()      # generic selector
  select_file()      # file-specific
  select_dir()       # dir-specific
  select_multiple()  # multi-select variant

fzf/crud/crud.mk:
  FZF_CREATE  # mkdir, touch with templates
  FZF_READ    # bat, tree, preview
  FZF_UPDATE  # edit, rename, move
  FZF_DELETE  # rm with confirmation
```

### use cases

```make
# Create file in selected directory
make fzf-create type=file

# Read any file with preview
make fzf-read

# Update: rename selected item
make fzf-rename

# Delete with multi-select
make fzf-delete-multi

# Composite: select dir → create file in it
make fzf-dir-then-create
```

### implementation strategy

extend existing patterns:
- leverage `FZF_RUN` macro pattern
- use `UI_RUN` for consistent output
- inherit from `excludes.mk` filters
- compose with existing helpers

### key differentiators

unlike your current project-specific selectors:
- **generic path operations** (not hardcoded to projects/)
- **type-polymorphic** (works on files and dirs)
- **action-decoupled** (selection doesn't imply operation)
- **preview-enhanced** (FZF preview window for context)

### success metrics

- reduced duplication (one selector, many uses)
- increased velocity (quick CRUD without leaving terminal)
- preserved consistency (UI/UX matches existing system)

### technical considerations

assuming:
- fzf supports `--preview` for inline file viewing
- bash 4+ for associative arrays (action mappings)
- fd/find interchangeability for performance

since:
- your system already handles shell function composition
- UI abstraction layer exists
- exclude patterns are centralized

then:
- generic CRUD is a natural extension
- implementation complexity is low
- value/effort ratio is high

---

The power isn't in the individual operations but in the **composition**: any path → any filter → any action. This transforms your Makefile system from task-specific to universally navigable.
