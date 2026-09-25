A04 Capability Record
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
     - ``getArgs()``; filename via built binary (run drops args)
   * - File reading
     - yes
     - ``readFile`` on real ``test_data.log``
   * - String splitting
     - yes
     - ``split`` on newlines and spaces
   * - String trimming
     - yes
     - ``trim`` on lines and fields
   * - Arrays
     - yes
     - records as ``[date, level, message]``
   * - Maps
     - yes
     - level counters keyed by level name
   * - Numeric counters
     - yes
     - totals; integer ``error * 100 / total``
   * - Integer conversion
     - no
     - format carries no numeric fields; not required
   * - Deterministic output
     - yes
     - fixed field order; ``expected.txt`` pinned, ran twice
   * - Malformed tolerance
     - yes
     - unknown-level/short lines counted, never crash
   * - JSON
     - no
     - not required; blocked lab-wide (CAP-003)
   * - Database/networking
     - no
     - out of scope

Relevant gap IDs
----------------

* CAP-003 (JSON): not required; no JSON used or claimed.
* CAP-008 (command-line/environment portability): same boundary as Phase
  002 — ``karkain run`` forwards no program arguments. No new gap created.
* Exit codes: same boundary as Phase 002 — errors print and return
  normally; ``system("exit ...")`` deliberately not used.
* ``std.string`` wrappers deliberately not imported (module not resolvable
  outside the Karkain tree; verified Phase 002). Underlying builtins used
  directly.
