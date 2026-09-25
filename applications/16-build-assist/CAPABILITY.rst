A12 Capability Record
=====================

Status: ``PARTIAL`` — validation subset verified (Phase 005).

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
     - ``listFiles`` sorted; missing dir → error path
   * - Name-based checks
     - yes
     - manifest/entrypoint by exact name; ``.kark`` by suffix
   * - Guidance output
     - yes
     - exact ``karkain check/build`` strings printed
   * - Deterministic output
     - yes
     - basename dir echo; ``expected.txt`` pinned
   * - Toolchain invocation
     - no
     - ``system()`` boundary (CAP-008); deliberately not attempted
   * - Stat/content checks
     - no
     - name-based only (CAP-009)

Usage and missing-dir paths executed. No new gap IDs.
