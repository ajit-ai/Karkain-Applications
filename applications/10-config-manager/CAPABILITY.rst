A03 Capability Record
=====================

Status: ``PARTIAL`` — INI-like subset verified by execution (Phase 005).

.. list-table::
   :widths: 28 22 50
   :header-rows: 1

   * - Capability
     - Demonstrated
     - Notes
   * - CLI arguments
     - yes
     - three modes via ``getArgs()``; built binary
   * - File reading
     - yes
     - ``readFile`` on real ``sample.ini``
   * - String parsing
     - yes
     - ``split``/``trim``/``substr`` section+pair parser
   * - Maps
     - yes
     - qualified ``section.key`` storage; ``hasKey``/``map_keys_of``
   * - Validation workflow
     - yes
     - required-key check with ``missing:`` diagnostics / ``ok``
   * - Deterministic output
     - yes
     - sorted keys; ``expected.txt`` pinned
   * - JSON
     - no
     - unavailable (CAP-003); not required here
   * - Typed values
     - no
     - all values strings by design of the subset

``show`` pinned in ``expected.txt``; ``get`` (hit/miss),
``validate`` (ok/missing), usage, and missing-file paths all executed.
No new gap IDs.
