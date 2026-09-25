25-taskops — Capability record (A62, Phase 010)
==================================================

Implemented (verified by two-process execution):

- Full chain CLI → HTTP → REST → file DB: six pinned ops cases.
- Client-side processing of live responses: id parsing
  (``op-create``), open/done aggregation (``op-summary``), CSV
  rendering (``op-export``).
- Server log + no-listener failure case pinned.
- State persisted to the db file (verified bytes).

Not supported:

- GUI variant of A62 (blocked, CAP-006).
- Separate A63/A64 implementations (same-stack variants).
- JSON, external SQL, concurrency, auth (inherited limits).

Capability gaps touched: none new.
