05-http-service — Capability record (A16/A17)
==============================================

Implemented (verified by two-process execution):

- Raw-socket HTTP/1.1 request/response codec (build + parse).
- Server: route dispatch with 200/404/405 semantics.
- Client: status + body reporting; connection-failure error path.
- Deterministic pins: ``expected-client-hello.txt``,
  ``expected-client-404.txt``, ``expected-server.txt``,
  ``expected-client-fail.txt``.

Partially supported:

- HTTP subset only (CAP-002: no routing/middleware/concurrent server).

Not supported:

- JSON bodies (CAP-003), TLS (CAP-007), WebSocket (A19 blocked).
