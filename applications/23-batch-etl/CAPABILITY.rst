23-batch-etl — Capability record (Phase 008)
==============================================

Implemented (verified by execution):

- A39 ETL: extract 6 rows, reject bad amount, filter cancelled, load 4
  rows, full SELECT dump (pins MATCH).
- A38 batch: 8 SQL jobs with per-job output and ok/err summary.
- A41 log aggregation: INFO 8 / WARN 2 / ERROR 3 over two real logs.
- A42 import/export: table -> CSV -> copy table, ``roundtrip: ok``.
- A40 bounded poll: new/total per snapshot (2/2, 2/4, 1/5).
- A36 config runner: INI parse, ordered steps, step log file, summary.
- Error paths: missing table, missing args, usage.

Blocked / not supported:

- A37 scheduler: no timer/scheduler primitives (CAP-008). No
  directory, no simulation.
- Daemons, signals, supervision, hot reload: no such APIs.
- Streaming beyond fixed polls; JSON; external SQL (CAP-004).

Capability gaps touched: none new (file I/O, strings, int math,
SQL-subset engine reuse).
