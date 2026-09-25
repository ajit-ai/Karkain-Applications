26-advanced — Capability record (Phase 011)
=============================================

Implemented (verified by execution):

- A81 studio: cross-db diff (only-in-a/b, common counts), cross-db
  table copy with verify recount (copy bug found by execution and
  fixed: decoded display rows need comma-joined CREATE columns).
- A83 health: UP proven live, DOWN with OS errors, up/down summary.
- A88 sweep: range audit with open-count summary.
- A87 workbench: validation, line-total transform, revenue report
  (4850 cents), rejects.
- Deterministic pins ×4; error paths (missing table/args, bad
  count, usage).

Out of scope (no such primitives):

- A82 IDE, A84 multi-host distribution, A86 scaffolding; A85
  already covered by A29.

Capability gaps touched: none new (net_connect errors, file I/O,
SQL-subset reuse).
