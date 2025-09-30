# Architecture Quick Reference

## Domain Pattern Structure

```
orchestrator.py                    # Main coordinator
features/
├── {domain}_manager.py           # Domain managers coordinate their domain
│   ├── Initialize domain components
│   ├── Handle domain-specific callbacks
│   └── Manage domain lifecycle
└── {domain}/                     # Domain implementation
    ├── __init__.py              # Package marker
    ├── component1.py            # Domain components
    └── component2.py            # Initialized with callbacks from manager
```


## Communication Flow

```
1. orchestrator.initialize()
   ├── {domain}_manager.initialize()
   ├── {domain}_manager.initialize()
   ├── {domain}_manager.initialize()
   └── {domain}_manager.initialize()

2. Message Flow (Callback Chain)
   ZMQ msg → processor_callback → cache_callback → exporter_callback

3. orchestrator.shutdown()
   └── Reverse initialization order
```

## Anti-Patterns to Avoid

❌ **Optional Attributes**
```python
class BadManager:
    def __init__(self):
        self.component: Optional[Component] = None
```

✅ **Declared Components**
```python
class GoodManager:
    def __init__(self):
        self.component: Component  # Will be initialized in initialize()
```

❌ **Direct Dependencies**
```python
# Bad - tight coupling
processor.forward_to_cache(data)
```

✅ **Callback Communication**
```python
# Good - loose coupling via callbacks
processor = Processor(cache_callback=cache.process)
```
