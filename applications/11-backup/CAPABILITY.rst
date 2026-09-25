A06 Capability Record
=====================

Status: ``PARTIAL`` — flat content-compare backup verified (Phase 005).

.. list-table::
   :widths: 28 22 50
   :header-rows: 1

   * - Capability
     - Demonstrated
     - Notes
   * - CLI arguments
     - yes
     - src/dst dirs via ``getArgs()``; built binary
   * - Directory scan
     - yes
     - ``listFiles``, sorted; flat only
   * - File comparison
     - yes
     - byte equality of ``readFile`` contents
   * - File copy
     - yes
     - ``writeFile``; per-file ok/failed accounting
   * - Deterministic report
     - yes
     - counts + sorted copied list; ``expected.txt`` pinned
   * - Idempotence
     - yes
     - second run skips everything (executed)
   * - Recursion
     - no
     - no builtin (CAP-009)
   * - Timestamps/metadata
     - no
     - no stat/mtime builtin (CAP-009)
   * - Directory creation
     - no
     - no mkdir builtin (CAP-009); dst must exist

First run pinned in ``expected.txt``; second (all-skipped) run executed
manually. Destination used for pinning lives outside the repo (local
empty dir); the README documents creating it. No new gap IDs.
