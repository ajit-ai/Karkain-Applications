06-db-crud — A20 Database CLI + A21 CRUD Application
====================================================

A20 is a command-line interface over the ``db_sql.kark`` SQL-subset engine.
A21 is a deterministic CRUD lifecycle demo (users table) on the same engine.

Engine surface (``db_sql.kark``):

- ``CREATE TABLE t (a, b, ...)``
- ``INSERT INTO t VALUES (v, ...)``
- ``SELECT * FROM t`` and ``SELECT a, b FROM t``
- ``SELECT ... WHERE c = v`` (single equality filter)
- ``UPDATE t SET c = v WHERE c = w``
- ``DELETE FROM t WHERE c = w``
- ``TABLES``, ``SCHEMA t``, ``DROP TABLE t``
- File persistence: ``#karkain-db-v1`` with ``T|``/``R|`` lines

Modes (``karkain run app.kark ...`` or the built binary)::

  db-crud demo <dbfile>              reset + full CRUD demo (A21, pinned)
  db-crud exec <dbfile> <sql...>     run one statement, autosave on ok (A20)
  db-crud script <dbfile> <sqlfile>  run #-comment/blank-tolerant script,
                                     stop on first error, db reset first (A20)
  db-crud tables <dbfile>            list tables (A20)
  db-crud schema <dbfile> <table>    show columns + row count (A20)

Values: integer literals store as ints, ``'quoted'`` strings dequote,
barewords store as strings. Keywords are case-insensitive; table and
column names are case-sensitive.

Limitations (documented, not defects):

- No JOIN, no ORDER BY, no aggregates, no multi-condition WHERE.
- No NULLs, no types beyond int/string, no column constraints.
- Values may not contain ``|`` or newlines (pipe-delimited file format).
- No transactions here (that is A23); every exec/script step saves eagerly.
- No concurrency, no networking, no external SQL server.
- ``demo`` resets its db file so reruns are identical.
- ``script`` likewise resets its db file before running.
