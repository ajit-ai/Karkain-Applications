21-db-admin — Capability record (A24)
========================================

Implemented (verified by execution, strictly read-only):

- inspect: exists/format/tables/per-table cols+rows/total rows.
- tables: per-table row counts; schema: columns + row count.
- validate: header, R→known-T, width match, i:/s: cell typing;
  prints ``valid`` or enumerates defects (5/5 defect classes proven
  against a deliberately corrupt file: bad header, unknown-table R,
  width mismatch, untyped cell, unknown line kind).
- stats: table count, per-table cols/rows, total rows, int-cells: 8,
  string-cells: 5 (hand-verified against the fixture).
- dump: canonical re-emission, line-identical to the db file bytes
  (8/8 lines match) — the dump IS the stored data.
- Deterministic pin: ``expected-demo.txt`` (MATCH ×2 via harness).

Not supported (no such engine/runtime capability):

- VACUUM/ANALYZE/INDEX/REINDEX/CHECKPOINT, BACKUP/RESTORE APIs, WAL,
  LOCKs, USER MANAGEMENT/PERMISSIONS, status APIs, transaction status,
  connection pools, INFORMATION_SCHEMA, repair/migration tools.

Capability gaps touched: none new (file I/O, strings, int math).
This is an inspection utility, not a production admin system.
