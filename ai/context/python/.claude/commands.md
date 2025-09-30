# Quick Command Reference

## Essential Commands for Claude Code Sessions

### all available:

```
make mk-help
```
```
```

### Project Structure
```bash
make files              # List all source files
make dirs               # Show directory tree
make files | grep zmq   # Find ZMQ-related files
make files | grep -E "(manager|orchestrator)"  # Find architecture files
```

### Development Workflow (hatch && uv)
```bash
make setup              # Initial setup
make lint               # Format and fix linting
make types              # Type checking
make test               # Run tests
make ci                 # Full CI pipeline
```


### Docker & Deployment
```bash
make mk-docker # docker specific ones
```
