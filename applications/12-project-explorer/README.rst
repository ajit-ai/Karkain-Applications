A08 Project Explorer
===================

Status: ``IMPLEMENTED`` (flat project inspection)

Purpose
-------

CLI project inspection: list a directory's entries with sizes, totals,
``.kark`` count, and manifest presence — the honest flat subset of project
exploration available in Karkain 1.1.0 (Phase 005).

Usage (built binary)::

  project-explorer <dir>

Build::

  cd F:\Codes\Git\Karkain
  karkain build .../12-project-explorer/app.kark -o explorer.exe

Example (``test_data/``: ``karkain.toml``, ``main.kark``, ``notes.txt``,
``util.kark``)::

  project-explorer test_data
    entries: 4
    karkain.toml: 79 chars
    main.kark: 78 chars
    notes.txt: 19 chars
    util.kark: 64 chars
    total_chars: 240
    kark_files: 2
    manifest: present

Pinned output: ``expected.txt``.

Capabilities exercised
----------------------

``getArgs``, ``listFiles`` (sorted entries), ``readFile`` per entry,
``len`` (sizes), ``substr`` (``.kark`` suffix), ``str``, sibling module
(``import explorer``).

Implemented
-----------

Sorted entry listing with byte sizes, totals, ``.kark`` counting,
``karkain.toml`` presence by name, usage and missing-dir diagnostics.

Limitations
-----------

Flat only (no recursion, CAP-009). Entries that read as ``""``
(subdirectories, empty or missing files) report ``0 chars`` and are
indistinguishable — the ``readFile`` boundary. Sizes are byte counts of
file content (newlines excluded from nothing: raw content length).
The tool was also run against this repository's own lab directories
during development as a smoke check (output not pinned).

Files
-----

* ``app.kark`` — dispatcher, usage/errors, report.
* ``explorer.kark`` — scan + sort + suffix check.
* ``test_data/`` — ``karkain.toml``, ``main.kark``, ``notes.txt``,
  ``util.kark``. ``expected.txt``. ``CAPABILITY.rst``.
