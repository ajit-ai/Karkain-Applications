18-rest-tasks — A18 REST Task API
=================================

Task CRUD over the ``05-http-service`` codec (``tasks.kark`` store +
``http_codec.kark`` copy). Text/plain bodies; no JSON — CAP-003.

Routes: ``GET``/``POST /tasks`` (list / create, empty title → 400);
``GET``/``PUT``/``DELETE /tasks/N`` (one / set open-done / remove;
unknown id → 404). Store is in-memory; persistence is A22
(``19-task-service``).

Verification: ``tools/verify-service.ps1`` — six pinned client cases,
server log, and failure case all MATCH.

Limitations: single-threaded, no auth, no JSON, no persistence here.
