05-http-service — A16 HTTP Client + A17 HTTP Server
===================================================

Minimal HTTP/1.1 over raw ``net_*`` loopback (``http_codec.kark``:
request/response build + parse; no JSON — CAP-003).

Modes (built binary)::

  http-service server <port> <maxRequests>
  http-service client <host> <port> <method> <path> [body]

Routes: ``GET /hello`` → 200 ``Hello, Karkain!``; ``GET /status`` → 200;
anything else → 404; non-GET on ``/status`` → 405. Single-threaded;
serves ``maxRequests`` then exits.

Verification: ``tools/verify-service.ps1`` — three client cases, server
log, and no-listener failure case all MATCH (see ``cases.txt`` and
``expected-*.txt``).

Limitations: no routing framework, no middleware, no concurrency, no
TLS, no chunked encoding (see CAP-002).
