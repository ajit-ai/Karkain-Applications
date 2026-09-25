Roadmap (Phases)
================

Future phases are driven by actual Karkain capabilities and application
findings. This roadmap must not be interpreted as a claim that all listed
capabilities already exist.

* Phase 001 — Foundation + inventory (docs + tools only, no apps).
  Status: ``completed``.
* Phase 002 — A05 CSV Tool (``applications/01-csv-tool/``).
  Status: ``completed``.
* Phase 003 — A04 Log Analyzer + A07 Source Analyzer
  (``applications/02-log-analyzer/``, ``applications/03-source-analyzer/``).
  Status: ``completed``.
* Phase 004 — A13/A14 TCP (``applications/04-tcp-echo/``).
  Status: ``completed``.
* Phase 005 — A01–A12 Core/System (``applications/08-system-info/`` through
  ``applications/16-build-assist/``; A01 blocked with docs only, A02/A03/A06/
  A10/A12 partial, A08/A09/A11 implemented).
  Status: ``completed``.
* Phase 006 — A15–A24 Network / HTTP / REST / Database
  (``applications/05-http-service/``, ``applications/06-db-crud/``,
  ``applications/17-udp/``, ``applications/18-rest-tasks/``,
  ``applications/19-task-service/``, ``applications/20-db-transactions/``,
  ``applications/21-db-admin/``, ``applications/22-websocket/``;
  A16–A18/A20–A24 implemented and verified, A15/A19 blocked with docs
  only). Status: ``completed``.
* Phase 007 — A25–A30 Concurrency (``applications/07-worker-pool/``;
  worker pool, pipeline, concurrent files, concurrent HTTP, events,
  data grid — all implemented and verified, deterministic).
  Status: ``completed``.
* Phase 008 — Services/Event Processing (``applications/23-batch-etl/``;
  config startup runner, batch engine, ETL pipeline, log aggregation,
  import/export roundtrip, bounded streaming poll — all implemented
  and verified, deterministic; A37 scheduler blocked, not simulated).
  Status: ``completed``.
* Phase 009 — GUI investigation (``applications/24-gui/`` blocker docs;
  toolchain source scan found no GUI facility; A53–A61 remain blocked
  under CAP-006; no GUI code by design).
  Status: ``completed``.
* Phase 010 — CLI + HTTP + DB integration (``applications/25-taskops/``;
  A62 full-stack slice implemented and verified; GUI variant blocked).
  Status: ``completed``.
* Phase 011 — Advanced applications (``applications/26-advanced/``;
  A81 studio, A83 health, A87 workbench, A88 sweep implemented and
  verified; A82/A86 blocked-or-planned, A84/A85 partial-by-prior-work,
  all documented not simulated).
  Status: ``completed``.
* Phase 012 — Flagship CLI Operations Console (``applications/flagship/``;
  status dashboard, runbook sessions, file reports — implemented and
  verified; GUI portion remains blocked under CAP-006).
  Status: ``completed``.

Historical note: this roadmap previously listed HTTP (A16/A17) and
Database (A20/A21/A23) as separate phases. Phase 006 was executed as the
grouped A15–A24 scope, and the subsequent phases were renumbered 007–012
in their existing intended order. No phases were invented or removed;
no applications were renumbered. The total reconciled count is 12
phases, matching the long-standing ``Phase 001 … Phase 012`` ordering.

Phase boundaries move with evidence: if an application hits a missing
capability, stop at the boundary, record the gap in
:doc:`capability-gaps`, and feed it back to the Karkain roadmap. A
documented blocker is a successful laboratory result.
