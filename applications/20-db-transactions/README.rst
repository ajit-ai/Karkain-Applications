20-db-transactions — A23 Transactional Application
==================================================

Domain: ``accounts`` (name, balance). Demonstrates a guarded multi-step
transfer: read balances → debit working copy → credit working copy →
save once only when every step succeeds.

Capability finding (explicit):

    Native database transactions are not provided by the current
    Karkain/database capability set.

There is no BEGIN/COMMIT/ROLLBACK in ``db_sql.kark`` or in the Karkain
1.1.0 builtins available to applications (only ``readFile``/``writeFile``,
no atomic persistence, no concurrency). This application therefore
implements an APPLICATION-LEVEL transactional pattern, not ACID
transactions:

- The loaded db is kept as a snapshot; every ``db_exec`` already
  returns a fresh working copy, so steps never touch the snapshot.
- ``db_save`` is called exactly once, after all steps succeed (commit).
- Any step failure discards the working copy and re-saves the snapshot
  (explicit rollback); the persisted state is provably unchanged.
- Pre-validation aborts (bad amount, missing source, insufficient funds)
  happen before any staging; the mid-operation abort (destination matched
  zero rows at step 2) stages step 1 in memory, then rolls back.

Modes (``karkain run app.kark ...`` or the built binary)::

  txn demo <dbfile>                        reset + success + failure + reload (pinned)
  txn show <dbfile>                        print all accounts
  txn transfer <dbfile> <from> <to> <amt>  one guarded transfer, save-on-success only

``db_sql.kark`` is a verbatim copy of the A20/A21 engine (documented
module-reuse pattern); the engine was not extended for A23.

Limitations (documented, not defects):

- Single-process only; no crash-atomicity (a kill between steps 1..N and
  the single save loses the in-memory operation — nothing partial is
  ever written, but the operation itself is lost).
- No isolation: concurrent writers could interleave (no concurrency
  exists in this laboratory, so this is untestable here).
- No savepoints, no nested operations, no multi-table atomicity beyond
  what fits in one ``db_save``.
- ``demo`` resets its db file so reruns are identical.
