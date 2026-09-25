A05 CSV/Data Processing Tool
===========================

Purpose
-------

Real command-line CSV aggregation utility. Reads a CSV file, aggregates the
numeric column, and prints deterministic summary statistics with per-category
grouping. First real application of the Karkain Applications Laboratory
(Phase 002, Karkain ``1.1.0``).

What it does
------------

* Takes a CSV filename from the command line via ``getArgs()``.
* Reads the file with ``readFile``.
* Parses ``category,value`` records (header ignored, fields trimmed,
  value converted with ``int``).
* Computes row count, sum, min, max, integer average, plus per-category
  count/sum sorted alphabetically.
* Prints usage when no filename is available; prints an error when the file
  cannot be read.

Input format
------------

Simple dialect only (NOT RFC 4180):

* comma-separated, one record per line;
* no quoted fields, no embedded commas, no multiline fields;
* first non-empty line is the header and is ignored;
* value field must be an integer; surrounding whitespace tolerated;
* empty lines and rows with fewer than two fields (or an empty field) are
  skipped.

Usage
-----

Build once, then run the binary (the filename reaches the program through
real OS arguments)::

  cd F:\Codes\Git\Karkain
  karkain build F:\Codes\Git\Karkain-Applications\applications\01-csv-tool\app.kark -o csv-tool.exe
  csv-tool.exe F:\Codes\Git\Karkain-Applications\applications\01-csv-tool\test_data.csv

Without a filename the program prints usage (this is also what
``karkain run .../app.kark`` shows, see Limitations)::

  Usage: csv-tool <csv-file>

Example input (``test_data.csv``)::

  category,value
  alpha,10
  beta,20
  alpha,5
  gamma,15
  beta,30

Example output (``expected.txt``)::

  rows: 5
  sum: 80
  min: 5
  max: 30
  avg: 16
  groups:
  alpha: count=2 sum=15
  beta: count=2 sum=50
  gamma: count=1 sum=15

Karkain capabilities exercised
------------------------------

``getArgs``, ``print``/``println``, ``readFile``, ``split``, ``trim``,
``int``, ``str``, arrays, maps, ``push``, ``hasKey``, ``map_keys_of``,
sibling modules (``import csv_parse`` / ``import csv_agg`` with
``public func`` + qualified calls), ``while``/``if`` control flow.

Implemented
-----------

File-based CSV aggregation with header handling, trimming, integer
conversion, count/sum/min/max/integer-avg, grouped count/sum with sorted
deterministic output, usage and unreadable-file diagnostics.

Not implemented / outside current Karkain capability
----------------------------------------------------

* Full RFC 4180 quoting/escaping (out of dialect scope by design).
* JSON output (blocked, CAP-003).
* Non-zero process exit codes for errors: Karkain ``1.1.0`` exposes no
  verified exit-code builtin, so failures print an error and return
  normally. Not faked via ``system("exit ...")``.
* ``karkain run app.kark -- file.csv``: the ``1.1.0`` CLI rejects ``--``
  (``Error: Unknown flag '--'``) and drops extra program arguments, so the
  filename only arrives via a built binary. Documented, not worked around.

Files
-----

* ``app.kark`` — orchestration (args, usage/errors, output).
* ``csv_parse.kark`` — file reading and record parsing.
* ``csv_agg.kark`` — statistics, grouping, key sorting.
* ``test_data.csv`` — sample dataset. ``expected.txt`` — pinned output.
* ``CAPABILITY.rst`` — capability evidence.
