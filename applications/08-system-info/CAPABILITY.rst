A01 Capability Record
=====================

Status: ``BLOCKED`` — no implementation; this file records the boundary.

Probed (throwaway programs, Karkain 1.1.0, Windows)
---------------------------------------------------

.. list-table::
   :widths: 30 30 40
   :header-rows: 1

   * - Capability
     - Available
     - Evidence
   * - ``system(cmd)`` exit code
     - yes
     - returns command status only
   * - ``system(cmd)`` output capture
     - no
     - return value is an int; stdout unreachable
   * - Environment variables
     - no
     - no builtin; ``stdlib/system`` approach is POSIX-only
   * - OS/CPU/memory/process APIs
     - no
     - nothing in builtins or importable stdlib
   * - ``getArgs``
     - yes
     - insufficient for system facts

Gap: CAP-008 (portable system/environment/arguments/time). No new gap ID:
the boundary is the known CAP-008 scope (output-less ``system()`` plus
missing env/time APIs).
