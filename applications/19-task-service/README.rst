19-task-service — A22 Database-Backed REST Service
==================================================

A18 REST surface over a file-backed task store (``taskdb.kark``:
``#karkain-tasks-v1`` format with ``task|``/``next|`` lines; codec and
task logic copied from ``05-http-service``/``18-rest-tasks``).

Same routes and status semantics as A18; every mutation persists to
the db file, and a restarted server process reloads it — restart
persistence proven by execution (fresh process served pre-existing
tasks).

Verification: ``tools/verify-service.ps1`` — six pinned cases, server
log, and failure case all MATCH.

Limitations: single equality-free store (id lookup only), no JSON
(CAP-003), no external SQL (CAP-004), single-threaded.
