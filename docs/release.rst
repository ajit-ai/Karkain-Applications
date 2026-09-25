Release — Roadmap Complete
===========================

Status: the 12-phase laboratory roadmap is complete. All phases are
implemented and verified, or intentionally blocker-documented. Phase
012 (Flagship CLI Operations Console): PASS. There is no Phase 013.

Phase summary
-------------

* Phases 001–005: foundation, CSV, analyzers, TCP, core/system apps.
* Phase 006 (A15–A24): HTTP/REST/database; A15 UDP and A19 WebSocket
  blocked with docs only. See :doc:`phase-006`.
* Phase 007 (A25–A30): deterministic concurrency.
* Phase 008 (A36/A38–A42): batch/ETL services; A37 scheduler blocked.
* Phase 009: GUI investigation — no GUI facility exists; A53–A61
  blocked, no code by design.
* Phase 010 (A62): full-stack CLI + HTTP + DB slice.
* Phase 011 (A81/A83/A87/A88): advanced apps from verified
  dependencies; A82/A84/A85/A86 out of scope by evidence.
* Phase 012: flagship CLI console (status/runbooks/reports);
  GUI console blocked.

How to build, run, and verify applications
------------------------------------------

Toolchain: Karkain ``1.1.0`` (``karkain.exe``) run with the Karkain
repository as toolchain root — this repository never vendors
``stdlib/`` (see :doc:`architecture`). ``karkain run`` forwards no
program arguments in 1.1.0, so argument-taking apps are verified
through built binaries:

* ``tools/verify-apps.ps1 -App <app.kark> -UseBuild
  -ProgramArgs <args> -Expected <expected.txt>``
* ``tools/verify-service.ps1`` for networked services (server +
  client cases + server log + failure probe).
* ``tools/check-matrix.ps1`` for structural/capability gates.

Application verification is local-only (Windows + Karkain toolchain)
and is not part of CI for that reason.

Known toolchain limitations (documented, not fixed)
---------------------------------------------------

* The separate Karkain compiler repository currently carries
  unrelated in-progress generics work that can break previously
  valid code. This repository was verified against a pristine-HEAD
  sandbox of that toolchain; reproduce that setup before diagnosing
  any application failure. Never modify the compiler to suit an app.
* Native defect found during Phase 012: passing a non-empty array
  into a module function and mutating it there can crash the native
  binary or silently lose the mutation. Avoidance rule used
  lab-wide: accumulate arrays only in the owning scope; helpers
  return line arrays. Related semantic: ``push`` to a parameter
  never propagates (cf. ``db_pushline`` reassignment).
* Intermittent ``cannot locate src/compiler`` resolver errors were
  observed; retries succeed.

Relationship to the Karkain repository
--------------------------------------

``https://github.com/ajit-ai/Karkain`` (branch ``develop``) provides
language, compiler, runtime, and standard library. This laboratory
only consumes released behavior, records version ``1.1.0`` reality,
and never modifies that repository.

HTML documentation and GitHub Pages
-----------------------------------

* Build: ``pip install -r docs/requirements-docs.txt`` then
  ``sphinx-build -b html -W docs docs/_build/html`` (warnings fail
  the build, locally and in CI).
* Publish: push to ``main`` triggers ``.github/workflows/docs.yml``
  (official Pages Actions: configure → build → upload → deploy).
  Repository Pages must use the "GitHub Actions" source once.
* Expected URL: ``https://ajit-ai.github.io/Karkain-Applications/``.
  Remote deployment has not been executed from this environment;
  the workflow is configured, not yet run.
* CI (``.github/workflows/ci.yml``) runs the matrix check plus the
  ``-W`` docs build on ``main``/``develop`` pushes and pull requests.
