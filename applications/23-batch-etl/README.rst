23-batch-etl — Phase 008 Services: batch + ETL (A36/A38–A42)
=============================================================

Config-driven batch engine, ETL pipeline, log aggregation, CSV/DB
import-export, bounded streaming poll, and a config startup runner —
all over files plus the ``db_sql.kark`` SQL-subset engine (verbatim
copy of the A20/A21 engine; not extended).

Modes (built binary)::

  svc etl <csv> <dbfile>        A39: validate/filter CSV -> orders table
  svc batch <dbfile> <jobs>     A38: SQL job list, per-job report
  svc logagg <dir>              A41: LEVEL counts over app1/app2.log
  svc impexp <dbfile> <t> <csv> A42: table -> CSV -> copy, roundtrip check
  svc poll <dir>                A40: bounded poll of snap1..3
  svc-run <conf> <workdir>      A36: config startup steps, logged

A37 (scheduler) is blocked: no timer/scheduler primitives exist
(CAP-008). No daemonize/signals exist either, so A36 is a foreground
startup runner, not a daemon.

Fixtures in ``test_data/``: ``orders.csv`` (6 rows: 1 bad amount, 1
cancelled), ``jobs.lst`` (8 self-contained SQL jobs), ``app1.log`` /
``app2.log`` (13 tagged lines), ``snap1..3.txt`` (cumulative 2/4/5),
``svc.conf`` + ``steps.sql``, ``shop.db`` (ETL-loaded fixture for the
impexp pin). Pins: ``expected-etl/batch/logagg/impexp/poll/svc.txt``
via ``verify-apps.ps1``. The svc-run pin uses a TEMP workdir seeded
once with ``steps.sql`` (documented setup, same precedent as prior
TEMP-path pins).

Determinism: etl/batch/impexp/svc-run reset their db/log targets
first; all inputs are fixed files; outputs verified byte-identical
across reruns.

Limitations (documented, not defects):

- CSV subset: no quoted commas; values with ``|``/newlines unsupported
  (engine format).
- Import quotes every value; ``db_encode`` re-derives int/string, so
  exotic strings may change type (fixtures avoid this).
- A40 polling is an explicit fixed sequence — no sleep/timers exist.
- A36 has no daemon/background operation, no reload, no supervision.
