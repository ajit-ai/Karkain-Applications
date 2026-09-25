20-db-transactions — Capability record (A23)
=============================================

Native transactions: NONE. No BEGIN/COMMIT/ROLLBACK, transaction
objects, atomic persistence, or savepoints exist in the engine or in
Karkain 1.1.0 application builtins (verified by source scan of
``db_sql.kark``: zero matches).

Implemented (verified by execution, application-level pattern):

- Guarded transfer with snapshot → stage-all-steps → single-save commit.
- Mid-operation abort: step 1 (debit) staged in memory, step 2 (credit)
  matched 0 rows → snapshot re-saved → persisted state byte-identical
  to pre-operation (proven by ``after-fail`` output + reload).
- Pre-validation aborts: bad amount (``0``, ``xyz``), missing source,
  insufficient funds — file untouched.
- Reload case: fresh ``db_load`` shows committed state (70/80).
- Deterministic pin: ``expected-demo.txt`` (MATCH ×2 via harness).

Partially supported:

- Rollback restores the last saved snapshot only; anything never saved
  cannot be recovered (no write-ahead log possible with file builtins).

Not supported (out of scope):

- ACID semantics, crash recovery, isolation, savepoints (all require
  runtime/engine support that does not exist).
- A24 administration views.

Capability gaps touched: none new (file I/O, strings, int math).
