# _make

Modular Makefile system for composable workflow automation.

## Quick Start

```bash
# In your project's Makefile
include _make/index.mk
```

## Architecture

```
_make/
├── index.mk                 # Root aggregator
├── <domain>/
│   ├── index.mk            # Domain aggregator
│   ├── base.mk             # Core logic
│   └── <subdomain>/
│       └── *.mk            # Feature modules
```

## Modules

- **general/**    - Core utilities and project management
- **checks/**     - Validation and testing utilities
- **hatch/**      - Python/Hatch project management
- **fzf/**        - Interactive FZF-based file operations
- **ui/**         - Consistent UI components and messaging
- **ai/**         - AI workflow integrations

## Key Features

- Modular composition via simple includes
- FZF-powered interactive workflows
- Consistent UI/UX across all targets
- Shell helper integration
- Extensible domain-based architecture

## Usage

```bash
make help              # Show available domain help targets

# some features:
make f-pwd            # Interactive file path selector
make fzf-read         # Browse and preview files
```

## Documentation

- [Pattern Guide](PATTERN.md) - Architecture and conventions
- [PRDs](docs/PRDs/) - Feature specifications
