19-task-service — Capability record (A22)
==========================================

Implemented (verified by two-process execution):

- REST CRUD backed by a real file store (load on start, save per
  mutation, reload proven across a server restart).
- Deterministic pins: six client cases + server log + failure case.

Partially supported:

- File-backed tasks only (CAP-004: no external SQL/joins/bindings).

Not supported:

- JSON (CAP-003), transactions (see A23 pattern), concurrency, auth.
