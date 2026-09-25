A01 System Information Tool
===========================

Status: ``BLOCKED`` (intended scope not implementable in Karkain 1.1.0)

Purpose (intended)
------------------

Display operating system, CPU, memory, environment, filesystem, and process
information. Exercise system-level programming.

Why blocked
-----------

Verified against Karkain 1.1.0 (Phase 005 probes, throwaway programs outside
this repository):

* No environment-variable, time/date, CPU, memory, or process builtins
  exist. ``stdlib/system/system.kark`` ``get_env``/``platform_name``/
  ``current_dir`` shell out via ``system()`` and are POSIX-oriented.
* ``system(cmd)`` returns only the command exit code (verified: ``exit 0``
  → ``0``, ``exit 3`` → ``3`` on Windows). Command output cannot be
  captured, so no system fact can be brought back into the program.
* ``getArgs()`` (built binary) is the only host input available.

A tool that prints only hardcoded or argument-echoed values would fake the
application. No ``app.kark`` is therefore provided.

What exists instead
-------------------

The neighboring Phase 005 applications cover the honest subset: file
listing/reading (A02), project inspection (A08), and build assistance
(A12). Genuine OS/CPU/memory/process reporting awaits portable
system/environment/time APIs.

Capability gap: CAP-008.
