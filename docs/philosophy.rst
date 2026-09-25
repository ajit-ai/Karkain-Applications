Laboratory Philosophy
======================

Real applications
-----------------

Applications should represent useful software rather than syntax
demonstrations. An application belongs here when a developer would recognize
it as a useful software component, utility, service, or application. Small
real applications are preferred over large artificial demos.

Evidence over claims
--------------------

A capability is marked ``used`` only when an application actually exercises
it. Statuses are limited to ``planned``, ``prototype``, ``implemented``,
``runnable``, ``partial``, ``blocked``, ``retired``. Subjective ratings
(``excellent``, ``best``, ``poor``, ``8/10``, ``production ready``) are not
used unless objectively defined.

No fake APIs
------------

Unsupported HTTP, JSON, GUI, TLS, UDP, database, concurrency, and similar
facilities must never be simulated and presented as implemented Karkain
capabilities. ``fake_http_server()``, ``fake_database()``, ``fake_async()``,
``fake_gui()``, ``fake_thread()`` are prohibited as application
implementations. Mocks are allowed only when explicitly identified as tests
or architectural experiments.

Capability gaps are valuable
----------------------------

A blocked application is useful because it identifies what Karkain needs
next. Every blocked application records the exact missing builtin, stdlib
module, or runtime facility and what Karkain work would unblock it.

Applications drive language evolution
-------------------------------------

The feedback cycle is::

  real application
        ↓
  required capability
        ↓
  currently supported?
        ↓
   yes          no
    ↓            ↓
  build       capability gap
    ↓            ↓
  experience   Karkain roadmap
    ↓            ↓
       next application
