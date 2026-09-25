25-taskops — A62 Full-Stack Task Operations (Phase 010)
=========================================================

GUI-free full-stack slice: ops CLI → HTTP → REST service → file
database, in one application directory. The service layer is the
verified A22 stack reused verbatim (``http_codec``/``tasks``/``taskdb``
copied from ``19-task-service``); new in A62 are the ops CLI modes
that drive the whole chain and do client-side work.

Modes (built binary)::

  taskops server <port> <maxRequests> <dbfile>
  taskops client <host> <port> <method> <path> [body]
  taskops op-create <host> <port> <title>
  taskops op-list <host> <port>
  taskops op-complete <host> <port> <id>
  taskops op-summary <host> <port>
  taskops op-export <host> <port>

``op-summary`` aggregates open/done counts from the live list;
``op-export`` renders CSV from the live list. Both parse real
``id: title [state]`` lines — no canned output.

Verification: ``tools/verify-service.ps1`` with ``cases.txt`` (create
×2, list, complete, summary, export), server log, and failure case —
all MATCH. Deterministic from a fresh db file.

Limitations (documented, not defects):

- Same stack limits as A22: text/plain, no JSON (CAP-003), no
  external SQL (CAP-004), single-threaded server.
- Titles with ``|`` or newlines unsupported (store format).
- A63 (inventory) and A64 (monitoring) are not separate
  implementations; the same stack with a different table serves
  them (documented variants).
