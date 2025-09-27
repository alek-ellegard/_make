## Session Initialization Checklist

### 1. Context Setup
- [ ] Git branch name: `feat/fzf-crud-generic`
- [ ] Issue/ticket file: `crud-fzf-generic.issue.md`
- [ ] Current working directory: `$(MK_DIR)`
- [ ] Recent commits: (modular makefile system with fzf integration established)

### 2. Style Declaration

```Markdown
style:
- be concise and terse
- minimalistic, dont extend the scope  
- prefer minimal code changes, minimal intervention
- leverage existing patterns (FZF_RUN, UI_RUN, excludes)
- composable over monolithic
```

### 3. Request Structure
```
1. Theory/Architecture: 
   - universal selector abstraction (path → filter → item)
   - action decoupling (selection separate from operation)
   - type polymorphism (files vs dirs)

2. Domains/Components:
   - fzf/crud/crud.sh (new selector functions)
   - fzf/crud/crud.mk (new CRUD targets)
   - integration with existing ui.sh and excludes.mk

3. Explicit scope:
   - generic path operations (not hardcoded to projects/)
   - CRUD via fzf selection
   - preserve existing UI patterns
   - respect exclude patterns

4. Explicit non-goals:
   - NOT rewriting existing project/ticket selectors
   - NOT changing ui.sh or excludes.mk
   - NOT adding external dependencies beyond fzf
   - NOT creating complex state management

5. Deliverable format:
   - fzf/crud/crud.sh with select_item(), select_file(), select_dir()
   - fzf/crud/crud.mk with FZF_CREATE, FZF_READ, FZF_UPDATE, FZF_DELETE
   - minimal integration changes to index.mk
```

### 4. AI Should Verify:
### 4. AI Should Verify:
- Which operations need multi-select? → no multi-select (MVP)
- Should preview be mandatory or optional? → preview mandatory (MVP)  
- Default base path (. vs specific)? → . (current directory)
- Confirmation pattern (use existing confirm() vs new)? → use existing confirm() from ui.sh

### 5. Implementation Template
```
Branch: feat/fzf-crud-generic
Issue: crud-fzf-generic.issue.md
Focus: generic fzf CRUD operations only
Non-goals: project-specific logic, external deps, ui.sh changes
Deliverable: crud.sh + crud.mk files ready to include
Style: terse, composable, minimal intervention
```

## Usage
"Using PROMPT_RECIPE.md, implement generic fzf CRUD per PRD, creating fzf/crud/crud.sh and fzf/crud/crud.mk"
