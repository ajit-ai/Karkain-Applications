A08 Capability Record
=====================

Status: ``IMPLEMENTED`` — flat inspection verified (Phase 005).

.. list-table::
   :widths: 28 22 50
   :header-rows: 1

   * - Capability
     - Demonstrated
     - Notes
   * - CLI arguments
     - yes
     - dir via ``getArgs()``; built binary
   * - Directory listing
     - yes
     - ``listFiles``, sorted; missing dir → error path
   * - Per-file sizes
     - yes
     - ``len(readFile(...))``; 0 covers dirs/empty (boundary)
   * - Suffix detection
     - yes
     - ``substr`` ``.kark`` check for counting
   * - Manifest detection
     - yes
     - ``karkain.toml`` matched by name
   * - Deterministic output
     - yes
     - sorted entries; ``expected.txt`` pinned
   * - Recursion/stat
     - no
     - no builtin (CAP-009)

Missing-dir error path executed. No new gap IDs.
