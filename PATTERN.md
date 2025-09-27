# PATTERN.md

## Makefile Module Architecture

### Core Pattern

```
_make/
├── index.mk                 # root aggregator
├── PATTERN.md              # this file
├── <domain>/
│   ├── index.mk            # domain aggregator  
│   ├── base.mk             # domain core logic
│   └── <subdomain>/
│       ├── index.mk        # subdomain aggregator
│       └── *.mk            # feature files
└── <domain>/
    └── ...
```

### Include Hierarchy

```make
# _make/index.mk (root)
include $(MK_DIR)/base.mk
include $(MK_DIR)/general/*.mk
include $(MK_DIR)/checks/*.mk
include $(MK_DIR)/hatch/*.mk
include $(MK_DIR)/fzf/*.mk
include $(MK_DIR)/ui/*.mk
include $(MK_DIR)/ai/*.mk

# _make/<domain>/index.mk (domain aggregator)
include $(MK_DIR)/<domain>/base.mk
include $(MK_DIR)/<domain>/<subdomain>/*.mk

# Project Makefile (consumer)
include $(MK_DIR)/index.mk
```

### File Conventions

| File | Purpose | Pattern |
|------|---------|---------|
| `index.mk` | aggregator | includes all siblings/children |
| `base.mk` | core logic | domain fundamentals |
| `*.mk` | features | specific functionality |
| `*.sh` | helpers | sourced by `.mk` via `bash -c` |

### Composition Rules

1. **index.mk always aggregates**
   - never contains logic
   - only include statements
   - optional test target

2. **base.mk contains fundamentals**
   - core domain operations
   - shared variables
   - primary targets

3. **feature files are atomic**
   - single responsibility
   - self-contained
   - composable

### Helper Integration

```make
# Pattern for shell helpers
HELPER_DIR := $(dir $(lastword $(MAKEFILE_LIST)))

define RUN_HELPER
	bash -c 'source $(HELPER_DIR)/helper.sh && $(1)'
endef
```

### Usage Example

```make
# Project Makefile
include $(MK_DIR)/index.mk

# Now all targets available:
# - from general/*.mk
# - from fzf/*.mk  
# - from ui/*.mk
# - etc.
```

### Benefits

- **modularity**: domains isolated
- **composability**: mix and match includes
- **discoverability**: predictable structure
- **extensibility**: add new domains easily
- **testability**: per-domain test targets

### Anti-patterns

- ❌ logic in index.mk files
- ❌ cross-domain dependencies
- ❌ relative includes (use absolute from ~)
- ❌ circular dependencies
- ❌ state between includes
