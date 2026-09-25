Karkain-Applications Laboratory
================================

The real-world application and capability laboratory for the Karkain
programming language (Karkain ``1.1.0``, branch ``develop``).

Purpose
-------

The Karkain repository demonstrates language features. This repository
demonstrates real software applications built only with currently available
Karkain functionality. It answers, with evidence:

* What real applications can Karkain build today?
* Which capabilities are still missing?

Contents
--------

* :doc:`philosophy` — laboratory principles (evidence over claims, no fake APIs).
* :doc:`applications` — complete A01–A88 roadmap with verified statuses.
* :doc:`capabilities` — living capability matrix (used / partial / blocked).
* :doc:`capability-gaps` — CAP-001 … CAP-011 gap register.
* :doc:`architecture` — repository architecture and stdlib-resolution constraint.
* :doc:`roadmap` — Phase 001 … Phase 012 execution order.
* :doc:`phase-006` — Phase 006 (A15–A24) final report.
* :doc:`release` — formal release state (roadmap complete).

Current Karkain version
-----------------------

* Version: ``1.1.0``
* Branch: ``develop``
* Executable: ``karkain.exe``
* Toolchain root for ``karkain run`` in current dev setup: ``F:\\Codes\\Git\\Karkain``
* Related repository: ``https://github.com/ajit-ai/Karkain``

Application categories
----------------------

CLI/system, filesystem, developer tools, networking, HTTP/REST, databases,
concurrency, services, data engineering, enterprise, real-time/live,
GUI/Desktop (blocked), full-stack, cloud/service, security, developer
productivity, advanced, flagship (deferred).

Phase 001 state
---------------

Foundation + inventory only. No applications are implemented in this phase.
``applications/01-csv-tool/`` through ``applications/07-worker-pool/`` are
planned directory placeholders; ``applications/flagship/`` is intentionally
deferred. Blocked capabilities (UDP, WebSocket, TLS, GUI, JSON, external SQL)
are documented, not implemented.

.. toctree::
   :maxdepth: 2

   philosophy
   applications
   capabilities
   capability-gaps
   architecture
   roadmap
   phase-006
   release
