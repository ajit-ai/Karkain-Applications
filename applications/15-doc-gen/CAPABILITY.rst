A11 Capability Record
=====================

Status: ``IMPLEMENTED`` — textual extraction verified (Phase 005).

.. list-table::
   :widths: 28 22 50
   :header-rows: 1

   * - Capability
     - Demonstrated
     - Notes
   * - CLI arguments
     - yes
     - multiple files via ``getArgs()``; built binary
   * - File reading
     - yes
     - ``readFile`` per file; unreadable section skipped
   * - Prefix detection
     - yes
     - ``substr`` for ``//``/``func ``/``public func ``
   * - Basename scan
     - yes
     - ``substr`` loop over both separators; portable output
   * - Trimming/splitting
     - yes
     - ``trim``/``split`` line pipeline
   * - Arrays
     - yes
     - signature lists in file order
   * - Deterministic output
     - yes
     - argument order + basenames; ``expected.txt`` pinned
   * - AST/semantics
     - no
     - explicitly out of scope (heuristics only)

Usage path executed. No new gap IDs.
