A09 Capability Record
=====================

Status: ``IMPLEMENTED`` — textual inspection verified (Phase 005).

.. list-table::
   :widths: 28 22 50
   :header-rows: 1

   * - Capability
     - Demonstrated
     - Notes
   * - CLI arguments
     - yes
     - manifest path via ``getArgs()``; built binary
   * - File reading
     - yes
     - ``readFile`` on real manifests (sample + repo's own)
   * - Section parsing
     - yes
     - ``split``/``trim``/``substr`` over genuine TOML fields
   * - Version extraction
     - yes
     - first quoted string of each dependency entry
   * - Maps
     - yes
     - dep name -> version; ``map_keys_of`` + sort
   * - Deterministic output
     - yes
     - sorted deps; ``expected.txt`` pinned
   * - Resolution/lockfile
     - no
     - out of scope by design (textual inspector only)
   * - Registry/network
     - no
     - never attempted

Sample plus repo-manifest runs executed; usage and missing-file paths
executed. No new gap IDs.
