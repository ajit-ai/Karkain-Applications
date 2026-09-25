18-rest-tasks — Capability record (A18)
========================================

Implemented (verified by two-process execution):

- REST CRUD with 200/201/400/404 semantics on real HTTP loopback.
- Six pinned cases: list-empty, create, list, update, get,
  delete-missing.

Partially supported:

- HTTP subset (CAP-002), text bodies only (CAP-003), embedded
  in-memory store (CAP-004: no external SQL).

Not supported here:

- Persistence (see A22), concurrency, auth, TLS.
