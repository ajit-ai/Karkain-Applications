A05 Capability Record
=====================

Application actually exercises (verified by execution, Phase 002):

.. list-table::
   :widths: 28 42 30
   :header-rows: 1

   * - Capability
     - Demonstrated
     - Notes
   * - CLI arguments
     - yes
     - ``getArgs()``; filename via built binary (see limitation)
   * - File reading
     - yes
     - ``readFile`` on real ``test_data.csv``
   * - String splitting
     - yes
     - ``split`` on newlines and commas
   * - String trimming
     - yes
     - ``trim`` on lines and fields
   * - Integer conversion
     - yes
     - ``int`` incl. surrounding whitespace
   * - Arrays
     - yes
     - rows, groups entries, key sorting
   * - Maps
     - yes
     - grouping via ``hasKey``/``map_keys_of``
   * - Aggregation
     - yes
     - count/sum/min/max/integer-avg + grouped count/sum
   * - Sibling modules
     - yes
     - ``import csv_parse`` / ``import csv_agg``, ``public func``
   * - Deterministic output
     - yes
     - alphabetically sorted group keys; ``expected.txt`` pinned
   * - JSON
     - no
     - not required; blocked lab-wide (CAP-003)
   * - Database
     - no
     - out of scope
   * - Networking
     - no
     - out of scope

Relevant gap IDs
----------------

* CAP-003 (JSON): not required for this application; no JSON used or claimed.
* CAP-008 (command-line/environment portability): broader limitation applies —
  ``karkain run`` drops program arguments and rejects ``--`` in Karkain
  ``1.1.0`` (verified: ``Error: Unknown flag '--'``; ``getArgs()`` length
  stays 1 under ``run``), and ``get_args()`` in ``stdlib/system`` returns an
  empty array. This application therefore documents the build-then-execute
  invocation as canonical. No new gap created: this is the known CAP-008
  boundary.
* Full CSV quoting/escaping: outside this application's supported dialect by
  design, not a Karkain gap.
* ``std.string``/``std.collections`` wrappers deliberately not imported: they
  resolve only inside the Karkain repository tree (``module 'std.string' not
  found`` outside it, verified). The application uses the underlying verified
  builtins directly — the same primitives those modules wrap.
