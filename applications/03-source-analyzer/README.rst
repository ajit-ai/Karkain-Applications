A07 Source Analyzer
===================

Purpose
-------

Practical source-code inspection utility. Scans explicitly listed source
files and reports lightweight textual metrics plus per-extension counts.
Second application of Phase 003 (Karkain ``1.1.0``).

This analyzer performs textual source analysis; it is not a Karkain parser,
compiler front-end, AST analyzer, or semantic analyzer.

Supported inputs
----------------

Explicit file paths as command-line arguments (no recursive traversal —
Karkain ``1.1.0`` has no recursive-walk/stat API, CAP-009). Any text file
is accepted; extension grouping covers whatever extensions are passed.
No host-shell file discovery (``find``/``ls``/``dir``/``grep``) is used.

Invocation
----------

Build once, then run with explicit files::

  cd F:\Codes\Git\Karkain
  karkain build F:\Codes\Git\Karkain-Applications\applications\03-source-analyzer\app.kark -o source-analyzer.exe
  source-analyzer.exe .../test_data/sample1.kark .../test_data/sample2.kark .../test_data/notes.txt

Without filenames the program prints usage::

  Usage: source-analyzer <file> [file ...]

Unreadable files print ``error: cannot read <path>`` and are skipped.

Metrics and exact heuristics
----------------------------

* ``files`` — successfully read files.
* ``lines`` — physical lines via byte-level newline counting (plus one
  when content does not end with newline).
* ``nonempty`` — split lines non-empty after ``trim``.
* ``blank`` — ``lines - nonempty`` (derived arithmetically; see limitation).
* ``comments`` — trimmed line starts with ``//``.
* ``chars`` — sum of ``len(line)`` over split lines (newlines excluded).
* ``func``/``import``/``struct``/``let`` — non-comment lines where
  ``contains(line, <word>) == 1``. Comment lines are excluded so a
  ``// func helper`` note is not counted as code. These are textual
  substring heuristics, not AST metrics.
* ``ext:`` — file counts by extension after the last ``.`` (sorted keys;
  extension-less files grouped as ``(none)``).

Example output (``expected.txt``, corpus: ``sample1.kark``,
``sample2.kark``, ``notes.txt``)::

  files: 3
  lines: 23
  nonempty: 19
  blank: 4
  comments: 2
  chars: 261
  func: 3
  import: 1
  struct: 1
  let: 1
  ext:
  kark: 2
  txt: 1

Karkain capabilities exercised
------------------------------

``getArgs`` (multiple file arguments), ``readFile``, ``split``, ``trim``,
``substr`` (comment-prefix and extension scan), ``contains`` (construct
heuristics), byte indexing (``content[i]`` newline scan), ``len``,
``str``, arrays, maps (extension counts, ``hasKey``/``map_keys_of``),
sorted deterministic output, sibling modules (``import source_scan``).

Limitations
-----------

* Textual heuristics only — no parsing, no semantics, no dependency
  analysis. A line containing ``func`` inside a string literal would count.
* ``split(s, "\n")`` drops empty substrings (verified ``1.1.0`` behavior),
  so blank lines are never observed directly; ``blank`` is derived as
  ``lines - nonempty`` with ``lines`` from byte-level newline counting.
* ``raw`` cannot be used as a variable name (reserved word in the Karkain
  lexer); the scanner names that variable ``parts``.
* ``contains`` returns ``1``/``0`` (int), hence ``== 1`` comparisons.
* No recursive traversal, no stat/metadata (CAP-009). No exit codes
  (same boundary as Phase 002). No ``karkain run -- args`` (CAP-008).

Files
-----

* ``app.kark`` — orchestration (args, usage/errors, aggregation, output).
* ``source_scan.kark`` — per-file scanning, extension extraction, sorting.
* ``test_data/`` — ``sample1.kark``, ``sample2.kark``, ``notes.txt``.
* ``expected.txt`` — pinned output. ``CAPABILITY.rst`` — evidence.
