24-gui — Phase 009 GUI investigation (blocked, no code)
==========================================================

Covers A53–A61 (Calculator, Text Editor, File Manager GUI, Database
Browser, System Monitor GUI, Application Dashboard, Database
Administration Studio, REST Client GUI, Business Management Desktop).

Finding: Karkain 1.1.0 provides NO GUI facility. Phase 009 searched
the pristine-HEAD toolchain (stdlib modules, compiler builtins, Go
runtime) for window/controls/widget/event-loop/presentation
capability:

- ``stdlib/`` (16 modules: async, collections, core, crypto, db,
  encoding, generics, gpu, http, io, math, net, numerics, string,
  system, testing) — no GUI module; the ``gpu`` module is compute
  buffers/kernels only (no surfaces, swapchains, or display).
- No window/widget/button/canvas/event-loop builtins anywhere.
- Only incidental matches: "Windows" cross-compile targets and an
  EOF comment — not GUI capability.

Therefore all nine applications stay ``blocked`` under CAP-006, and
this directory intentionally contains no ``app.kark``. Per laboratory
rule, a documented blocker is a successful result. Do not invent a
GUI API, do not hand-roll widgets over stdout, and do not present
terminal dashboards as GUI implementations.

The CLI-accessible equivalents already exist where the underlying
task is supportable: file management (A02/09-file-tool), database
inspection (A24/21-db-admin), system facts (A01 limits documented),
REST interaction (A16/05-http-service CLI client).
