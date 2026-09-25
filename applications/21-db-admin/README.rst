21-db-admin — A24 Database Administration Utility
==================================================

Strictly read-only inspection over the ``db_sql.kark`` engine (verbatim
copy of the A20/A21 engine; the engine was not extended for A24).
Never mutates the inspected database: dump-to-stdout is the export
story. Conventional admin features (VACUUM, INDEX, BACKUP APIs, users,
permissions, WAL, locks, INFORMATION_SCHEMA, connection pools) do not
exist here and are not claimed.

Modes (``karkain run app.kark ...`` or the built binary)::

  admin demo <dbfile> <seedfile>     reset + seed + every view (pinned)
  admin inspect <dbfile>             exists/format/tables/rows summary
  admin tables <dbfile>              tables + row counts
  admin schema <dbfile> <table>      columns + row count
  admin dump <dbfile>                canonical re-emission (sorted)
  admin validate <dbfile>            format checks over raw file text
  admin stats <dbfile>               counts + int/string cell census

Fixture: ``test_data/seed.sql`` (products ×3 rows, suppliers ×2 rows,
fixed values) executed through the real engine — the utility inspects
actual stored data, never canned output.

Validation performed (all derivable from the real format):

- ``#karkain-db-v1`` header present
- every ``R`` names a known ``T`` table
- row width equals column width
- every cell carries an ``i:``/``s:`` type tag
- anything else is reported as a defect (proven against a corrupt file)

Limitations (documented, not defects):

- No repair/vacuum/repair, no users/permissions, no live status:
  the engine stores none of that metadata.
- Missing/empty file reports ``exists: no`` instead of failing.
- ``demo`` resets its db file so reruns are identical.
