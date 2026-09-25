A06 Backup Utility
==================

Status: ``PARTIAL`` (content-compare flat backup; no timestamps/recursion)

Purpose
-------

Practical file backup: scan a source directory, compare each file against
the destination by content, copy changed files, report. Timestamps are
unavailable (no stat/mtime builtin), so "changed" means "bytes differ" —
running twice is idempotent by construction (Phase 005).

Usage (built binary)::

  backup <srcDir> <dstDir>

The destination directory must already exist — Karkain cannot create
directories (CAP-009). Create it once with the OS before running.

Build::

  cd F:\Codes\Git\Karkain
  karkain build .../11-backup/app.kark -o backup.exe

Example (``test_data/`` → empty ``backup-dst/``)::

  backup test_data backup-dst
    files: 3
    copied: 3
    skipped: 0
    failed: 0
    copied:
    orders.txt
    readme.txt
    stock.txt

Second run (verified)::

  backup test_data backup-dst
    files: 3
    copied: 0
    skipped: 3
    failed: 0
    copied:
    (none)

Pinned output: ``expected.txt`` (first run).

Capabilities exercised
----------------------

``getArgs``, ``listFiles`` (sorted), ``readFile`` (both trees),
``writeFile`` (copies), string path joining (``dir + "/" + name``),
sibling module (``import backup_run``), deterministic report.

Implemented subset
------------------

Flat scan/compare/copy/report with per-file failure accounting
(``writeFile`` return). Missing destinations read as ``""`` so new files
always copy.

Not implemented (no Karkain 1.1.0 builtin)
-----------------------------------------

Recursive trees, mtime/size comparison, directory creation, permissions
(CAP-009). ``readFile`` boundary: empty source files read as ``""`` and
are treated as already backed up when the destination is missing/empty.
No shell substitutes (``cp``/``robocopy``) are used.

Files
-----

* ``app.kark`` — dispatcher, usage, report.
* ``backup_run.kark`` — scan/compare/copy + sorting.
* ``test_data/`` — ``orders.txt``, ``stock.txt``, ``readme.txt``.
* ``expected.txt``. ``CAPABILITY.rst``.
