A02 Capability Record
=====================

Status: ``PARTIAL`` — flat subset verified by execution (Phase 005).

.. list-table::
   :widths: 28 22 50
   :header-rows: 1

   * - Capability
     - Demonstrated
     - Notes
   * - CLI arguments
     - yes
     - six modes via ``getArgs()``; built binary
   * - Directory listing
     - yes
     - ``listFiles``, sorted; missing dir reads as empty
   * - File reading
     - yes
     - ``readFile``; ``""`` covers missing+empty (boundary)
   * - File writing
     - yes
     - ``writeFile`` creates/replaces (verified in TEMP)
   * - File deletion
     - yes
     - ``removeFile``; missing file returns 0 (verified)
   * - Existence probe
     - yes
     - ``openFile`` non-empty check; readable files only
   * - Content search
     - yes
     - list + read + ``contains``; names sorted
   * - Sorting
     - yes
     - bubble sort for deterministic output
   * - Recursive traversal
     - no
     - no builtin (CAP-009)
   * - Copy/move/rename
     - no
     - no builtin (CAP-009); no shell substitutes used
   * - Stat/metadata/mkdir
     - no
     - no builtin (CAP-009)

``list`` pinned in ``expected.txt``; ``search`` in
``expected-search.txt``; ``cat``/``exists``/``write``/``delete``/usage
executed manually (write/delete against TEMP copies to keep the corpus
pristine). No new gap IDs.
