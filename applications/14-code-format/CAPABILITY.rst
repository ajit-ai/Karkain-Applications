A10 Capability Record
=====================

Status: ``PARTIAL`` — narrow subset verified (Phase 005).

.. list-table::
   :widths: 28 22 50
   :header-rows: 1

   * - Capability
     - Demonstrated
     - Notes
   * - CLI arguments
     - yes
     - src/dst via ``getArgs()``; built binary
   * - File reading/writing
     - yes
     - ``readFile`` in, ``writeFile`` out (never in place)
   * - Byte-level trim
     - yes
     - reverse ``s[i]`` scan over space/tab/CR
   * - String join
     - yes
     - ``+`` rejoin with newline preservation
   * - Change accounting
     - yes
     - per-line equality count; ``changed``/``clean`` verdicts
   * - Idempotence
     - yes
     - second run reports ``clean`` (executed)
   * - Deterministic output
     - yes
     - ``expected.txt`` pinned; clean file committed
   * - AST formatting
     - no
     - no parser API (explicitly out of scope)
   * - Empty-line preservation
     - no
     - ``split`` drops truly empty lines (verified boundary)

Read/write error paths and usage executed. No new gap IDs (split
boundary already recorded in Phase 003).
