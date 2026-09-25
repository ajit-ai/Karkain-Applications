A07 Capability Record
=====================

Application actually exercises (verified by execution, Phase 003):

.. list-table::
   :widths: 28 42 30
   :header-rows: 1

   * - Capability
     - Demonstrated
     - Notes
   * - CLI arguments
     - yes
     - multiple file args via ``getArgs()``; built binary
   * - File reading
     - yes
     - ``readFile`` per listed file; unreadable skipped
   * - String splitting
     - yes
     - ``split`` on newlines
   * - Trimming
     - yes
     - ``trim`` for blank/comment detection
   * - Substring/prefix
     - yes
     - ``substr`` for ``//`` prefix and extension scan
   * - Substring search
     - yes
     - ``contains`` for func/import/struct/let heuristics
   * - Byte indexing
     - yes
     - ``content[i]`` newline counting
   * - Arrays
     - yes
     - lines, keys, sorted copies
   * - Maps
     - yes
     - extension counts via ``hasKey``/``map_keys_of``
   * - Numeric counters
     - yes
     - all metrics aggregated across files
   * - Deterministic ordering
     - yes
     - sorted extension keys; ran twice
   * - Recursive traversal
     - no
     - unavailable (CAP-009); explicit file args used
   * - File stat/metadata
     - no
     - unavailable (CAP-009)
   * - JSON
     - no
     - not required (CAP-003)

Newly verified language facts (fed back, no new gap IDs)
--------------------------------------------------------

* ``split(s, "\n")`` drops empty substrings: blank lines never appear as
  elements. Worked around with byte-level newline counting; ``blank`` is
  derived (``lines - nonempty``).
* ``raw`` is a reserved lexer word and cannot be a variable name
  (``error[K001]``); renamed to ``parts``.
* ``contains`` returns int ``1``/``0``, so call sites compare ``== 1``.

Relevant gap IDs
----------------

* CAP-008 (command-line portability): same ``karkain run`` argument
  boundary as Phase 002. No new gap.
* CAP-009 (recursive filesystem/stat/metadata): this application stays
  inside the boundary via explicit file arguments. No new gap.
* ``std.*`` wrappers not imported (same resolution boundary as Phase 002).
