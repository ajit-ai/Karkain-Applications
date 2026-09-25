A13/A14 TCP Client and Echo Server
==================================

Purpose
-------

Real two-process TCP experiment: a Karkain client connects to a Karkain
server over loopback, sends ``ping``, receives the echo. Establishes the
practical TCP baseline of Karkain ``1.1.0`` (Phase 004) without conflating
it with UDP, TLS, WebSocket, timeouts, or concurrent servers.

Modes
-----

One binary, dispatched on the first argument (arguments arrive via real OS
argv, so use a built binary; ``karkain run`` forwards no program arguments
— CAP-008)::

  tcp-echo server <port>
  tcp-echo client <host> <port> <message>

With fewer than the required arguments the program prints usage::

  Usage: tcp-echo server <port>
  Usage: tcp-echo client <host> <port> <message>

Build
-----

::

  cd F:\Codes\Git\Karkain
  karkain build F:\Codes\Git\Karkain-Applications\applications\04-tcp-echo\app.kark -o tcp-echo.exe

Run (two processes)
-------------------

Terminal 1::

  tcp-echo.exe server 49061

Terminal 2::

  tcp-echo.exe client 127.0.0.1 49061 ping

Or unattended via ``tools/verify-tcp.ps1``, which builds, starts the
server, runs the client, waits, cleans up, and diffs ``expected.txt`` and
``expected-fail.txt``.

Protocol
--------

* Address: ``127.0.0.1`` only (server binds localhost; documented test port
  ``49061``, failure probe ``49062``).
* Message: raw bytes of ``<message>`` (single token; tested with ``ping``).
  No framing, no length prefix.
* Response: byte-identical echo of what the server read (up to 4096 bytes,
  single read).
* Lifecycle: listen → accept one connection → read once → write echo once
  → close client socket → close listening socket → exit. Single
  client/single session by design; no concurrency in this phase.

Example output
--------------

``expected.txt`` (per-process sections; combined order is not claimed —
each process output is deterministic on its own)::

  [server]
  server: listening 127.0.0.1:49061
  server: received ping
  server: echoed ping
  [client]
  client: connected 127.0.0.1:49061
  client: sent ping
  client: received ping

Failure output (``expected-fail.txt``, client with no listener)::

  client: connect failed: connection failure: wsa error 10061

Capabilities (net_* APIs exercised)
-----------------------------------

``net_connect``, ``net_listen``, ``net_accept``, ``net_read``,
``net_write``, ``net_close``, ``net_last_error`` — plus ``getArgs``,
``str``/``int``, sibling modules (``import tcp_client`` /
``import tcp_server``).

Limitations
-----------

* Single client, single message, single session. No ``spawn``/``join``/
  channels used (later phase).
* No TLS (CAP-007), no UDP (CAP-001), no WebSocket, no HTTP.
* No socket-timeout API at Karkain level; the runtime applies a 5s receive
  timeout internally and reports ``read failure: timeout`` via
  ``net_last_error`` (verified in ``pkg/codegen/codegen.go``,
  ``karkain_net_read``/``karkain_net_accept``). Reads are blocking.
* ``net_write`` loops to completion (verified); reads may be partial
  (single ``recv``) — irrelevant at this message size, documented for
  larger protocols.
* ``""`` from ``net_read`` is ambiguous (clean EOF vs error) — disambiguate
  via ``net_last_error`` (``""`` means clean EOF).
* Double-bind is not a reliable failure probe on Windows: the runtime sets
  ``SO_REUSEADDR`` and Windows rebind semantics let a second listener
  succeed and then block in ``accept`` (verified by hang during testing).
  Pinned failure cases are instead: connect-with-no-listener and invalid
  argument count.
* ``wsa error 10061`` text is Windows-specific.
* No exit codes (same CAP-008 boundary as earlier phases): errors print and
  return normally.

Files
-----

* ``app.kark`` — mode dispatcher, usage.
* ``tcp_client.kark`` — A13 connect/send/receive/close + diagnostics.
* ``tcp_server.kark`` — A14 listen/accept/echo/close, one session.
* ``expected.txt`` — pinned round-trip output. ``expected-fail.txt`` —
  pinned no-listener output. ``CAPABILITY.rst`` — evidence.
