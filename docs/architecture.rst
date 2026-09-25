Architecture
============

Separation
----------

::

  Karkain repository
      ↓
  source language/compiler/runtime/stdlib

  Karkain-Applications repository
      ↓
  application source
      ↓
  application-specific documentation
      ↓
  capability evidence
      ↓
  capability gaps

Applications remain independent from compiler implementation details unless
required for execution. Never copy compiler source into this repository.
Never modify ``F:\\Codes\\Git\\Karkain`` to make this repository work; record
Karkain ``1.1.0`` reality instead.

Per-application layout
----------------------

Each application directory contains::

  app.kark        # entry point (file-scope code calls main())
  <module>.kark   # application modules (parse/aggregate/service/...)
  README.rst      # purpose, scenario, capabilities, platforms, run instructions
  CAPABILITY.rst  # capabilities exercised + gaps (used/partial/blocked)
  test data       # e.g. test_data.csv
  expected.txt    # pinned expected stdout for tools/verify-apps.ps1

Dependency model
----------------

Each application states::

  Requires:
    Karkain version (1.1.0)
    compiler/runtime capabilities (verified builtins)
    standard library modules (std.io, std.string, ...)
    external dependencies (gcc, OS)

No hidden dependencies. Every app has an explicit build/run procedure.

Stdlib-resolution constraint (critical)
---------------------------------------

``std.*`` resolution depends on Karkain's repository layout: the module
resolver searches for ``stdlib/`` relative to the project root/upward
hierarchy (``pkg/module/module.go``: ``findStdlibDir``). Therefore
``Karkain-Applications/`` does NOT automatically provide ``stdlib/``.

Phase 001 does NOT copy the Karkain standard library here. The supported
development arrangement is to execute the Karkain toolchain with the Karkain
repository as toolchain root (``F:\\Codes\\Git\\Karkain``). Future
package/vendoring work (``karkain pkg fetch``, workspace members, vendored
``stdlib/``) is out of scope for Phase 001 and must be proposed explicitly,
not smuggled in per-application.

Module assembly note (verified Phase 005): a root file WITH imports uses
import-driven assembly (sibling ``import x`` + ``std.*`` resolution). A root
file with NO imports falls back to flat-directory assembly — every sibling
``.kark`` file is concatenated (verified: a stray ``b.kark`` containing
``bbb`` broke compilation of an import-less probe). Consequences: every
lab ``app.kark`` keeps at least one module import, and non-module ``.kark``
corpus files live under ``test_data/`` (never compiled as roots).

Phase 006 layering (verified)
-----------------------------

* HTTP/REST: codec module (``http_codec.kark``: HTTP/1.1 build + parse
  over raw ``net_*``) → dispatch (routes/status codes) → store
  (in-memory for A18, file-backed ``taskdb`` for A22). Shared modules
  are copied per application directory (documented reuse pattern), not
  cross-imported.
* File-backed database engine (``db_sql.kark``): SQL-subset statements
  return fresh ``{ db, res }`` copies; persistence is one pipe-delimited
  text file (``#karkain-db-v1``, ``T|``/``R|`` lines, ``i:``/``s:`` cell
  tags). No server, no locks, no WAL.
* Application-level transactions (A23): possible only because every
  statement returns a fresh copy — the app keeps the loaded snapshot,
  stages steps on the working copy, and saves once on full success.
  This pattern is a consequence of the copy semantics, not a
  transaction facility.
* Read-only administration (A24): views are derived from raw file text
  plus engine reloads; admin never writes the inspected database.

Verification
------------

* ``tools/verify-apps.ps1`` runs ``karkain run <app>`` with the Karkain
  repository as cwd, compares stdout to ``expected.txt`` when present, and
  fails non-zero on mismatch. Apps needing ``getArgs()`` use ``-UseBuild``
  (builds a temp exe; ``karkain run`` forwards no program arguments in
  1.1.0). Networked apps use ``tools/verify-service.ps1`` (server +
  client cases + server log + failure case); TCP apps use
  ``tools/verify-tcp.ps1``.
* Expected-output pins may be multiple files per app
  (``expected-*.txt``) plus ``cases.txt`` for service harnesses.
* ``tools/check-matrix.ps1`` checks repository structure (docs exist,
  capability IDs present, blocked stays blocked, app dirs exist, no fake
  GUI/UDP/TLS implementations).
