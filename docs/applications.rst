Application Roadmap (A01–A88)
==============================

Statuses: ``planned``, ``prototype``, ``implemented``, ``runnable``,
``partial``, ``blocked``, ``retired``.

Important distinction: ``runnable`` below means the corresponding Karkain
capability has been demonstrated or is presently constructible from verified
Karkain ``1.1.0`` examples (``examples/``, ``stdlib/``). It does NOT mean the
application is already implemented in this repository — A05 is implemented
(Phase 002), A04/A07 are implemented (Phase 003), A13/A14 are implemented
(Phase 004), A02/A03/A06/A08–A12 are implemented or partial (Phase 005),
and A16–A18/A20–A24 are implemented (Phase 006); all other entries
below describe Karkain capability readiness only. ``planned`` means not yet
attempted here. ``partial`` means constructible with documented limitations.
``blocked`` means a missing Karkain capability prevents a genuine
implementation; see :doc:`capability-gaps`.

CLI / system applications
-------------------------

* A01 — System Information Tool. Display OS/CPU/memory/env/filesystem/process
  info. Status: ``blocked`` (Phase 005: no env/time/CPU/process builtins;
  ``system()`` returns exit codes only, captures no output).
  Gap: CAP-008.
* A02 — File Management Utility (list/traverse/copy/move/rename/delete/search/
  metadata/mkdir). Status: ``partial`` (Phase 005,
  ``applications/09-file-tool/``: flat list/read/probe/write/delete/search;
  verified execution pinned). Depends: ``readFile/writeFile/listFiles/
  removeFile/openFile``. Gap: CAP-009 (no recursive walk/stat).
* A03 — Configuration Manager (parse/validate/load config file). Status:
  ``partial`` (Phase 005, ``applications/10-config-manager/``: INI-like
  show/get/validate; verified execution pinned). Depends: ``readFile``,
  ``split/trim/substr``. Gap: CAP-003 (no JSON).
* A04 — Log Analyzer (filter/search/aggregate/statistics). Status:
  ``implemented`` (Phase 003, ``applications/02-log-analyzer/``; verified
  execution pinned in ``expected.txt``). Depends: ``readFile``,
  ``split/trim``, arrays, maps.
* A05 — CSV/Data Processing Tool (filter/transform/aggregate/sort/output).
  Status: ``implemented`` (Phase 002, ``applications/01-csv-tool/``;
  verified execution pinned in ``expected.txt``). Depends: ``readFile``,
  ``split/trim/int``, arrays, maps.
* A06 — Backup Utility (scan/compare/copy-changed/report). Status: ``partial``
  (Phase 005, ``applications/11-backup/``: flat content-compare backup,
  idempotent; verified execution pinned). Depends: ``listFiles/readFile/
  writeFile``. Gap: CAP-009 (no stat/mtime/mkdir/recursion).

Developer tools
---------------

* A07 — Source Code Analyzer (lines/functions/modules/imports). Status:
  ``implemented`` (Phase 003, ``applications/03-source-analyzer/`` textual
  heuristics; verified execution pinned in ``expected.txt``). Depends:
  ``readFile``, ``split/trim/substr/contains``, byte indexing, maps.
* A08 — Project Explorer (CLI project inspection). Status: ``implemented``
  (Phase 005, ``applications/12-project-explorer/``: flat entry listing
  with sizes, totals, manifest check; verified execution pinned). Depends:
  ``listFiles/readFile``. Gap: CAP-009 (no recursion/stat).
* A09 — Dependency Inspector (Karkain metadata/build info). Status:
  ``implemented`` (Phase 005, ``applications/13-dep-inspector/``: textual
  name/version/dependency listing; verified execution pinned). Depends:
  manifest file reads. No resolution/network scope.
* A10 — Code Formatter. Status: ``partial`` (Phase 005,
  ``applications/14-code-format/``: trailing-whitespace normalizer only;
  verified execution pinned). No parser/AST API exists; ``karkain fmt``
  cannot be driven from inside Karkain (``system()`` captures no output).
* A11 — Documentation Generator. Status: ``implemented`` (Phase 005,
  ``applications/15-doc-gen/``: textual signatures + comment counts;
  verified execution pinned). Depends: source reads + ``substr`` prefix
  checks. Not an AST tool.
* A12 — Build/Project Assistant. Status: ``partial`` (Phase 005,
  ``applications/16-build-assist/``: name-based layout validation plus
  next-command suggestions; verified execution pinned). Toolchain
  invocation unavailable (``system()`` boundary, CAP-008).

Networking
----------

* A13 — TCP Echo Server (networking capability foundation). Status:
  ``implemented`` (Phase 004, ``applications/04-tcp-echo/`` server mode;
  real two-process loopback verified, pinned in ``expected.txt``). Depends:
  ``net_listen/net_accept/net_read/net_write/net_close``.
* A14 — TCP Client (connect/send/receive/timeout handling). Status:
  ``implemented`` (Phase 004, ``applications/04-tcp-echo/`` client mode;
  includes no-listener failure path). Depends: ``net_connect`` + error
  string ``net_last_error``.
* A15 — UDP Application. Status: ``blocked`` (Phase 006,
  ``applications/17-udp/``: documentation only; no UDP builtins exist).
  Gap: CAP-001 (no UDP builtins).

HTTP / REST
-----------

* A16 — HTTP Client (GET/POST/headers/body/status; text bodies, no JSON).
  Status: ``implemented`` (Phase 006, ``applications/05-http-service/``
  client mode; real loopback execution pinned). Depends: ``net_connect``.
  Gap: CAP-003 (no JSON).
* A17 — HTTP Server (routing/request/response/error handling). Status:
  ``implemented`` (Phase 006, ``applications/05-http-service/`` server
  mode; routes ``/hello``/``/status``/404/405; real two-process loopback
  verified, pinned). Depends: ``net_listen/net_accept/net_read/net_write/
  net_close``. Gap: CAP-002 (subset only: no routing framework,
  middleware, or concurrency).
* A18 — REST API (Task Management: resources/CRUD/validation/status).
  Status: ``implemented`` (Phase 006, ``applications/18-rest-tasks/``:
  full CRUD with 200/201/400/404 over real HTTP loopback; in-memory
  store; six cases pinned). Depends: HTTP blocks. Gaps: CAP-002,
  CAP-003 (text bodies only), CAP-004 (no external SQL).
* A19 — WebSocket Application (Real-Time Event Dashboard). Status:
  ``blocked`` (Phase 006, ``applications/22-websocket/``:
  documentation only; no WebSocket capability exists — no partial
  support). Gap: CAP-010.

Databases
---------

* A20 — Database CLI (schema-inspect/query/display over the SQL-subset
  engine: CREATE, INSERT, SELECT, SELECT ... WHERE single equality,
  UPDATE, DELETE, DROP, TABLES, SCHEMA; file persistence/reload).
  Status: ``implemented`` (Phase 006, ``applications/06-db-crud/``
  exec/script/tables/schema modes; verified execution pinned). Depends:
  ``readFile/writeFile/split/trim/substr/int``. Not a general SQL
  implementation. Gap: CAP-004.
* A21 — CRUD Application (users-table lifecycle: create/read/update/
  delete). Status: ``implemented`` (Phase 006,
  ``applications/06-db-crud/`` demo mode; deterministic 45-line pin
  incl. persist/reload/drop). Depends: A20 engine.
* A22 — Database-Backed REST Service (HTTP → REST → service → file
  store). Status: ``implemented`` (Phase 006,
  ``applications/19-task-service/``: A18 surface over a
  ``#karkain-tasks-v1`` file store; real restart persistence proven by
  execution and pinned). Gaps: CAP-003, CAP-004 (no external
  SQL/joins/bindings).
* A23 — Transactional Application (guarded transfer: snapshot → stage
  on working copy → single save on success → re-save snapshot on
  controlled failure). Status: ``implemented`` (Phase 006,
  ``applications/20-db-transactions/``; success + mid-operation
  rollback + overdraft abort + reload pinned). Native database
  transactions are NOT available; this is an application-level
  recovery pattern, not ACID. Gap: CAP-011.
* A24 — Database Administration Utility (read-only inspect/tables/
  schema/dump/validate/stats). Status: ``implemented`` (Phase 006,
  ``applications/21-db-admin/``: header/structure/typing validation
  with defect enumeration, cell census, canonical dump proven
  line-identical to the db file; pinned). Strictly read-only; not a
  production admin system. Gap: CAP-004.

Concurrency
-----------

* A25 — Worker Pool (jobs → pool → results). Status: ``implemented``
  (Phase 007, ``applications/07-worker-pool/`` pool mode: N workers
  share a job channel, sentinel stops, results sorted by id; pool 1/2/8
  deterministic, pinned). Depends: ``spawn/join/wait_all/channel``.
  Gap: CAP-005 (no preemptive pool/timeouts; ``join()`` carries INT
  results only — channel-based collection).
* A26 — Producer/Consumer Pipeline. Status: ``implemented`` (Phase 007,
  ``applications/07-worker-pool/`` pipeline mode: producer → 2 doublers
  → ordered consumer; pinned). Depends: ``spawn/join/channel``.
  Gap: CAP-005.
* A27 — Concurrent File Processor. Status: ``implemented`` (Phase 007,
  ``applications/07-worker-pool/`` files mode: ``readFile`` inside
  spawned tasks, ordered joins; pinned). Depends: ``spawn`` +
  ``readFile``. Gap: CAP-005.
* A28 — Concurrent HTTP Service. Status: ``implemented`` (Phase 007,
  ``applications/07-worker-pool/`` http-conc mode: handlers share one
  listener via ``net_accept``; deterministic server log; pinned via
  ``verify-service.ps1``). Depends: HTTP blocks + ``spawn``.
  Gaps: CAP-002, CAP-005.
* A29 — Event Processing System (queue/channel → workers → aggregator).
  Status: ``implemented`` (Phase 007,
  ``applications/07-worker-pool/`` events mode: 2 taggers +
  order-independent tally; pinned). Gap: CAP-005.
* A30 — Parallel Data Processor. Status: ``implemented`` (Phase 007,
  ``applications/07-worker-pool/`` grid mode: 9 spawns, row-major
  ordered joins; pinned). Depends: ``spawn/join`` grid.

System applications
-------------------

* A31 — Process Manager (launch/monitor/terminate). Status: ``partial``.
  Depends: ``system()`` only; no process handles/signals.
* A32 — Service/Daemon (long-running background service). Status:
  ``planned`` (partial at best; no daemonize/signal API).
* A33 — File Synchronization Utility. Status: ``partial``. Gap: CAP-009.
* A34 — Local IPC Application (client/server via available facilities).
  Status: ``partial``. Depends: TCP loopback as IPC transport.
* A35 — System Monitor. Status: ``partial``. Gap: CAP-008.

Configuration-driven applications
---------------------------------

* A36 — Application Server (config/logging/startup/services/shutdown).
  Status: ``implemented`` (Phase 008, ``applications/23-batch-etl/``
  svc-run mode: INI config, ordered SQL startup steps, step log file;
  foreground runner — no daemonize/signals exist; pinned). Depends:
  config parse + SQL-subset engine. Gap: CAP-008 (partial).
* A37 — Job Scheduler (schedule/queue/execute/record). Status:
  ``planned``. Gap: CAP-008 (no timer/scheduler primitives) —
  deliberately not simulated in Phase 008.
* A38 — Batch Processing Engine. Status: ``implemented`` (Phase 008,
  ``applications/23-batch-etl/`` batch mode: SQL job list with
  per-job report + ok/err summary; pinned). Depends: file +
  SQL-subset engine reads.

Data engineering
----------------

* A39 — ETL Pipeline (extract/transform/validate/load). Status:
  ``implemented`` (Phase 008, ``applications/23-batch-etl/`` etl mode:
  CSV validation/filter/load with reject/skip accounting + SELECT
  dump; pinned).
* A40 — Streaming Data Processor. Status: ``implemented`` (Phase 008,
  ``applications/23-batch-etl/`` poll mode: bounded fixed-sequence
  poll of growing snapshots; no timers exist so no true streaming;
  pinned).
* A41 — Log Aggregation Service. Status: ``implemented`` (Phase 008,
  ``applications/23-batch-etl/`` logagg mode: LEVEL counts over two
  real logs; pinned). Depends: A04-style blocks.
* A42 — Data Import/Export Service (files/services/DB). Status:
  ``implemented`` (Phase 008, ``applications/23-batch-etl/`` impexp
  mode: table → CSV → copy table with roundtrip check; pinned).
  Depends: ``readFile/writeFile`` + SQL-subset engine.

Enterprise applications
-----------------------

* A43 — Task Management System (CLI/API + DB + validation + config +
  logging). Status: ``planned`` (partial path exists via DB2). Gap: CAP-004.
* A44 — Inventory Management. Status: ``planned``. Gap: CAP-004.
* A45 — Order Management (Customer/Order/Item/Product/Payment/Status).
  Status: ``planned``. Gap: CAP-004.
* A46 — Authentication/Authorization Service. Status: ``blocked``. Lacks TLS
  and secure randomness; only deterministic SHA digests exist.
* A47 — Configuration/Administration Server. Status: ``planned``. Depends:
  HTTP blocks.

Real-time / live applications
-----------------------------

* A48 — Live Monitoring Dashboard. Status: ``planned``. Depends: poll loops;
  no push/WebSocket.
* A49 — Real-Time Event Monitor. Status: ``planned``.
* A50 — Live Log Viewer. Status: ``planned``. Depends: ``readFile`` polling.
* A51 — Real-Time Metrics Service. Status: ``planned``.
* A52 — Notification/Event Service. Status: ``planned`` (delivery via
  TCP/HTTP only).

GUI / Desktop (blocked)
-----------------------

* A53 — Calculator, A54 — Text Editor, A55 — File Manager GUI,
  A56 — Database Browser, A57 — System Monitor GUI, A58 — Application
  Dashboard. Status: all ``blocked``. Gap: CAP-006 (no GUI toolkit/event-loop).
  Phase 009 investigated the pristine-HEAD toolchain for any GUI
  facility and found none (``stdlib/gpu`` is compute-only); blocker
  docs live in ``applications/24-gui/`` (no code by design).

Network + Database + GUI integration
------------------------------------

* A59 — Database Administration Studio. Status: ``blocked`` (GUI).
* A60 — REST Client GUI. Status: ``blocked`` (GUI).
* A61 — Business Management Desktop Application. Status: ``blocked`` (GUI).

Full-stack
----------

* A62 — Full-Stack Task Management (client → HTTP/REST → service → DB).
  Status: ``implemented`` (Phase 010, ``applications/25-taskops/``:
  A22 service layer reused verbatim plus ops CLI with client-side
  id parsing, open/done summary, and CSV export over live responses;
  six cases + server log + failure pinned via ``verify-service.ps1``).
  GUI-dependent variant stays ``blocked`` (CAP-006).
* A63 — Inventory System. Status: ``partial``/``blocked`` per above.
* A64 — Monitoring Platform (agents → collector → storage → API →
  dashboard). Status: ``planned`` (CLI/API part constructible; dashboard GUI
  blocked).

Cloud / service
---------------

* A65 — Microservice. Status: ``planned``. Depends: HTTP blocks.
* A66 — Service-to-Service Communication. Status: ``planned``. Depends: TCP/HTTP.
* A67 — Background Worker Service. Status: ``planned``. Depends: ``spawn``.
* A68 — Event-Driven Service. Status: ``planned``.

Security
--------

* A69 — Secure Configuration Tool. Status: ``runnable`` (hash demonstration
  via ``sha256/sha512`` + ``hex/base64``; not encryption).
* A70 — Credential/Secret Configuration Demonstrator. Status: ``runnable``
  (same hash-demo scope; never claim secure storage).
* A71 — TLS Client/Server. Status: ``blocked``. Gap: CAP-007.
* A72 — Secure API Service. Status: ``blocked``. Gap: CAP-007.

Developer productivity
----------------------

* A73 — Terminal Dashboard, A74 — Project Generator, A75 — Log Search Tool,
  A76 — Source Search Tool, A77 — File Statistics Tool, A78 — Configuration
  Validator, A79 — JSON/Data Inspector, A80 — Repository Analysis Tool.
  Status: ``runnable`` where scope is file/stat/search via
  ``readFile/listFiles/split/contains`` (A79 limited: no JSON — Gap CAP-003).
  None implemented here yet.

Advanced
--------

* A81 — Local Database Studio. Status: ``implemented`` (Phase 011,
  ``applications/26-advanced/``: two-database diff, cross-db table
  copy with verify recount; pinned).
* A82 — Lightweight IDE. Status: ``blocked`` (no editor/AST
  primitives; not simulated).
* A83 — Service Management Console. Status: ``implemented``
  (Phase 011, ``applications/26-advanced/`` health mode: real TCP
  probes with UP/DOWN summary; UP proven live; pinned).
* A84 — Distributed Task Processor. Status: ``partial`` (local
  distribution is A25; loopback-only transport, no multi-host).
* A85 — Event Processing Platform. Status: ``partial`` (covered by
  the A29 pattern in ``applications/07-worker-pool/``).
* A86 — Local Development Platform. Status: ``planned`` (no
  scaffolding primitives; not simulated).
* A87 — Data Processing Workbench. Status: ``implemented`` (Phase 011,
  ``applications/26-advanced/`` workbench mode: validation, line-total
  transform, revenue report; pinned).
* A88 — Network Administration Tool. Status: ``implemented`` (Phase 011,
  ``applications/26-advanced/`` sweep mode: port-range audit; pinned).

Flagship
--------

* Karkain Operations Console (CLI → core → network/database/filesystem →
  background jobs → concurrency). Status: ``implemented`` (Phase 012,
  ``applications/flagship/``: status dashboard, scripted runbooks with
  live SELECT/TCP-probe/file views, file reports proven line-identical
  to stdout; pinned). GUI portion blocked (CAP-006); CLI console path
  delivered as targeted.
