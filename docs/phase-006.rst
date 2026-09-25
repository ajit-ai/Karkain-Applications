Phase 006 Report — A15–A24 Network / HTTP / REST / Database
==============================================================

Scope
-----

Phase 006 covers A15–A24: UDP, HTTP client/server, REST task API,
WebSocket, database CLI, CRUD application, database-backed REST
service, transactional application, and database administration
utility. Karkain ``1.1.0`` throughout; no compiler/runtime changes;
no external services, JSON, or concurrency.

Final status
------------

* A15 — UDP Application: ``BLOCKED`` — no UDP builtins exist (CAP-001).
  Docs only in ``applications/17-udp/``.
* A16 — HTTP Client: ``VERIFIED`` — ``applications/05-http-service/``.
* A17 — HTTP Server: ``VERIFIED`` — ``applications/05-http-service/``.
* A18 — REST Task API: ``VERIFIED`` — ``applications/18-rest-tasks/``.
* A19 — WebSocket: ``BLOCKED`` — no WebSocket capability exists
  (CAP-010). Docs only in ``applications/22-websocket/``; no partial
  support is implied.
* A20 — Database CLI: ``VERIFIED`` — ``applications/06-db-crud/``.
* A21 — CRUD Application: ``VERIFIED`` — ``applications/06-db-crud/``.
* A22 — Database-Backed REST Service: ``VERIFIED`` —
  ``applications/19-task-service/``.
* A23 — Transactional Application: ``VERIFIED`` —
  ``applications/20-db-transactions/`` (application-level
  transactional/recovery pattern; native transactions NOT available).
* A24 — Database Administration Utility: ``VERIFIED`` —
  ``applications/21-db-admin/`` (read-only).

Implementation summary
----------------------

* A16/A17: minimal HTTP/1.1 codec over raw ``net_*`` loopback; routes
  ``/hello`` (200), ``/status`` (200 GET / 405 otherwise), 404
  fallback; single-threaded server plus client with failure path.
* A18: task CRUD (GET/POST ``/tasks``, GET/PUT/DELETE ``/tasks/N``)
  with 200/201/400/404 semantics; text/plain bodies; in-memory store.
* A20/A21: SQL-subset engine (``db_sql.kark``: CREATE, INSERT, SELECT,
  SELECT ... WHERE single equality, UPDATE, DELETE, DROP, TABLES,
  SCHEMA; ``i:``/``s:`` cells; pipe-delimited file persistence) with
  CLI modes (exec/script/tables/schema) and a deterministic users-table
  CRUD demo. Two engine bugs found by execution and fixed: CREATE
  double-stripped the table name; SELECT silently dropped WHERE.
* A22: A18 surface over a ``#karkain-tasks-v1`` file store; mutations
  persist per request.
* A23: guarded transfer on an accounts table — load snapshot, stage
  debit + credit on the working copy, save once on full success,
  re-save the snapshot on step failure. Possible only because every
  engine statement returns a fresh copy.
* A24: read-only inspect/tables/schema/dump/validate/stats; validation
  checks header, table references, row widths, and cell typing and
  enumerates defects; dump proven line-identical to the db file.

Verification evidence
---------------------

All claims rest on real execution; nothing is claimed from source
inspection alone.

* ``tools/verify-service.ps1``: 05-http-service (client cases, server
  log, no-listener failure), 18-rest-tasks (six client cases, server
  log, failure case), 19-task-service (six client cases, server log,
  failure case) — every comparison MATCH.
* ``tools/verify-apps.ps1 -UseBuild`` (fresh builds, fresh TEMP db
  paths): 06-db-crud demo and script modes MATCH (reruns
  byte-identical); 20-db-transactions demo MATCH twice;
  21-db-admin demo MATCH twice.
* Manual execution: A22 restart persistence (fresh server process
  served pre-existing tasks); A20 exec/tables/schema plus unsupported-
  statement and missing-table errors plus script stop-on-error; A23
  commit/rollback/overdraft plus bad-amount and missing-source
  rejections; A24 missing-file handling, unknown-table error,
  five-class corrupt-file validation, dump/file byte comparison.
* ``tools/check-matrix.ps1``: PASS on the finalized tree (Phase 006
  directories and per-app docs now enforced).
* Deterministic fixtures: ``expected-*.txt`` pins plus ``cases.txt``
  harnesses and ``test_data/seed.sql`` fixtures in each app dir.

Capability gaps
---------------

* UDP unavailable (CAP-001) → A15 blocked.
* WebSocket unavailable (CAP-010) → A19 blocked.
* Native database transactions unavailable (CAP-011) → A23 is a
  recovery pattern, explicitly not ACID.
* Advanced SQL unavailable: no joins, aggregates, ORDER BY,
  multi-condition WHERE, NULLs, constraints, bindings (CAP-004).
* Conventional DB administration unavailable: no VACUUM/INDEX/users/
  WAL/status APIs (documented in the A24 capability record).
* HTTP subset only: no routing framework, middleware, concurrency,
  TLS, or JSON (CAP-002, CAP-003, CAP-007).

Files / application areas
-------------------------

* ``applications/05-http-service/`` — codec, app, cases, pins, docs.
* ``applications/06-db-crud/`` — engine, CLI/CRUD app, seed script,
  pins, docs.
* ``applications/17-udp/``, ``applications/22-websocket/`` — blocker
  docs only (no ``app.kark``).
* ``applications/18-rest-tasks/`` — task store, app, cases, pins, docs.
* ``applications/19-task-service/`` — file task store, app, cases,
  pins, docs.
* ``applications/20-db-transactions/`` — engine copy, txn app, pins,
  docs.
* ``applications/21-db-admin/`` — engine copy, admin app, seed script,
  pins, docs.
* ``tools/check-matrix.ps1`` — extended to enforce Phase 006
  directories and per-app docs.
* ``docs/`` — applications, capabilities, capability-gaps (CAP-010,
  CAP-011), architecture (Phase 006 layering), roadmap (reconciled),
  this report.

Phase conclusion
----------------

Phase 006 implementation is complete: all applications that are
supportable with the current Karkain capability set have been
implemented and verified; A15 and A19 remain documented capability
gaps.
