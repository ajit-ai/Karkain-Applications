A13/A14 Capability Record
==========================

Verified by real Karkain-to-Karkain loopback execution (Phase 004,
``tools/verify-tcp.ps1``: PASS, repeated runs identical).

TCP capability
--------------

.. list-table::
   :widths: 24 16 60
   :header-rows: 1

   * - Builtin
     - Used
     - Evidence
   * - ``net_connect``
     - yes
     - client fd; ``-1`` + ``connection failure: wsa error 10061`` with no listener
   * - ``net_listen``
     - yes
     - server fd on ``127.0.0.1:49061``; ``SO_REUSEADDR`` set by runtime
   * - ``net_accept``
     - yes
     - one connection; blocking; 5s recv timeout applied to accepted socket
   * - ``net_read``
     - yes
     - blocking, 5s timeout, single ``recv`` (partial reads possible);
       ``""`` means EOF or error — ``net_last_error`` disambiguates
   * - ``net_write``
     - yes
     - loops to completion; returns bytes sent or ``-1``
   * - ``net_close``
     - yes
     - client socket + listening socket closed; server exits cleanly
   * - ``net_last_error``
     - yes
     - surfaced in connect-failure output; ``""`` = last op ok

Supporting capabilities
-----------------------

``getArgs`` (mode/host/port/message dispatch; built binary only),
``str``/``int`` (port conversion, address formatting), sibling modules
(``import tcp_client`` / ``import tcp_server``, ``public func``).

File I/O: not used by the application (only by the PowerShell
orchestrator, which is repository verification, not Karkain functionality).

Not demonstrated (explicitly out of scope)
------------------------------------------

UDP (CAP-001), TLS (CAP-007), WebSocket, HTTP routing/concurrency
(CAP-002), thread/timeout/sync primitives and concurrent servers
(CAP-005), exit codes (CAP-008 boundary: errors print, return normally).

Relevant gap IDs
----------------

* CAP-001 UDP — untouched; TCP success implies nothing about UDP.
* CAP-002 HTTP server/concurrency — untouched.
* CAP-005 concurrency/timeouts — no ``spawn`` used; the runtime's internal
  5s receive timeout is not a Karkain-level timeout API.
* CAP-007 TLS — untouched; plaintext loopback only.
* CAP-008 — same ``karkain run`` argument boundary as earlier phases.

No new gap IDs: the Windows double-bind observation (second listener may
succeed and block in ``accept``) is a platform semantic of the existing
``SO_REUSEADDR`` runtime behavior, not a new missing capability; it is
recorded in ``README.rst`` as a testing note.
