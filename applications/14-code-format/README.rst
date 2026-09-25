A10 Trailing-Whitespace Normalizer
==================================

Status: ``PARTIAL`` (narrow subset; full formatting unavailable)

Purpose
-------

The only formatter subset Karkain 1.1.0 can genuinely support: strip
trailing spaces/tabs/CRs per line and rewrite the file, reporting how many
lines changed. There is no parser/AST API to drive indentation or layout,
and ``karkain fmt`` cannot be driven from inside Karkain (``system()``
captures no output), so a full formatter is explicitly out of scope.

Usage (built binary)::

  code-format <src> <dst>

The source is never modified in place; the normalized text goes to
``<dst>`` (``writeFile`` creates it). Re-running on normalized output
reports ``clean`` (verified idempotent).

Build::

  cd F:\Codes\Git\Karkain
  karkain build .../14-code-format/app.kark -o code-format.exe

Example (``test_data/messy.txt`` → ``test_data/messy.clean.txt``)::

  code-format messy.txt messy.clean.txt
    changed: 5 of 8 lines
  code-format messy.clean.txt messy.clean2.txt
    clean: 7 lines

Pinned output: ``expected.txt`` (first run). ``messy.clean.txt`` is
committed as transformation evidence (deterministically regenerable).

Capabilities exercised
----------------------

``getArgs``, ``readFile``/``writeFile``, ``split``, ``substr`` + byte
indexing (``s[end]`` reverse scan for the trim), string equality and
``+`` join, ``len``/``str``, sibling module (``import format_scan``).

Implemented subset
------------------

Trailing whitespace removal, leading whitespace (indentation) preserved,
trailing-newline preserved, per-line change accounting, usage and
read/write error diagnostics.

Limitations
-----------

No indentation, wrapping, or semantic formatting (no AST). Verified
``split`` boundary applies: truly empty lines are dropped by ``split``,
so a file containing them loses those lines on rewrite (whitespace-only
lines survive as emptied lines). Fixture note: one authored
whitespace-only line was stripped to empty by the file-writing tool
itself before execution — the pinned ``5 of 8`` counts reflect the file
as executed, verified byte-for-byte.

Files
-----

* ``app.kark`` — dispatcher, usage/errors, verdict lines.
* ``format_scan.kark`` — rtrim + normalize + join.
* ``test_data/messy.txt``, ``test_data/messy.clean.txt``.
* ``expected.txt``. ``CAPABILITY.rst``.
