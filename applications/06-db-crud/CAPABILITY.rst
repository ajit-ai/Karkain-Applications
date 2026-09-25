06-db-crud — Capability record (A20/A21)
==========================================

Implemented (verified by execution):

- A20 Database CLI: ``exec`` (single statement + autosave), ``script``
  (batch file, stop-on-error), ``tables``, ``schema``.
- A21 CRUD Application: ``demo`` runs create → insert ×2 → select →
  select-where → update → select → delete → select → tables → schema →
  persist → reload → drop → tables on a ``users`` table.
- SELECT with single-WHERE equality (added to the engine for A20).
- Reload-after-save proven in the demo (rows survive a fresh load).
- Deterministic pins: ``expected-demo.txt`` (45 lines), ``expected-script.txt``.

Partially supported:

- WHERE is one ``col = value`` equality only.
- Script files support ``#`` comments and blank lines.

Not supported (out of scope, see A23/A24):

- Transactions / rollback (A23).
- Database administration views (A24).
- External SQL, JSON, networking, concurrency.

Capability gaps touched: none new (file I/O, strings, int math — all proven).
