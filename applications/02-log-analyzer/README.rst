A04 Log Analyzer
===============

Purpose
-------

Practical command-line log-analysis utility. Reads a real log file, parses
``DATE LEVEL MESSAGE`` records, counts levels, and prints deterministic
summary statistics including error percentage and longest message. Second
application family of the laboratory (Phase 003, Karkain ``1.1.0``).

Supported log format
--------------------

Deliberately constrained; NOT a generic production log parser. One record
per line: ``DATE LEVEL MESSAGE`` where ``DATE`` is any non-empty token,
``LEVEL`` is exactly ``INFO``, ``WARN``, or ``ERROR``, and ``MESSAGE`` is
the non-empty remainder of the line. Surrounding whitespace tolerated.
Empty lines skipped. Lines with fewer than three tokens, an empty field, or
an unknown level become ``UNKNOWN`` records (counted, excluded from message
statistics).

Command-line usage
------------------

Build once, then run the binary (the filename reaches the program through
real OS arguments)::

  cd F:\Codes\Git\Karkain
  karkain build F:\Codes\Git\Karkain-Applications\applications\02-log-analyzer\app.kark -o log-analyzer.exe
  log-analyzer.exe F:\Codes\Git\Karkain-Applications\applications\02-log-analyzer\test_data.log

Without a filename the program prints usage (this is also what
``karkain run .../app.kark`` shows, see Limitations)::

  Usage: log-analyzer <log-file>

Input example (``test_data.log``, 10 records: 5 INFO, 2 WARN, 2 ERROR,
1 unknown-level line)::

  2026-01-01 INFO service started
  2026-01-01 ERROR database unavailable
  ...
  2026-01-02 OOPS broken line here

Output example (``expected.txt``)::

  records: 10
  info: 5
  warn: 2
  error: 2
  unknown: 1
  error_pct: 20
  longest: 20

``error_pct`` uses integer arithmetic (``error * 100 / total``); ``longest``
is the maximum message length over valid records.

Karkain capabilities exercised
------------------------------

``getArgs``, ``print``/``println``, ``readFile``, ``split``, ``trim``,
``str``, ``len``, arrays, maps (level counters, ``hasKey`` not needed —
fixed levels stored in a map and read back), sibling modules
(``import log_parse`` / ``import log_agg``, ``public func``).

Implemented
-----------

File-based log parsing with header-less records, unknown-record tolerance,
total/per-level/unknown counts, integer error percentage, longest-message
statistic, usage and unreadable-file diagnostics, deterministic fixed-order
output.

Not implemented / outside current Karkain capability
----------------------------------------------------

* Arbitrary production formats (timestamps, JSON logs, multiline records).
* Non-zero process exit codes: no verified exit-code builtin exists, so
  failures print an error and return normally (same boundary as Phase 002).
* ``karkain run app.kark -- file.log``: the ``1.1.0`` CLI rejects ``--`` and
  drops extra program arguments (Phase 002 finding, CAP-008). Build-then-
  execute is canonical.

Files
-----

* ``app.kark`` — orchestration (args, usage/errors, output).
* ``log_parse.kark`` — line parsing and record validation.
* ``log_agg.kark`` — counts, error percentage, longest message.
* ``test_data.log`` — sample dataset. ``expected.txt`` — pinned output.
* ``CAPABILITY.rst`` — capability evidence.
