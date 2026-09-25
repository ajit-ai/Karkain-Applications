Capability Gap Register
=========================

CAP-001 — UDP
-------------

* Required by: A15
* Status: ``blocked``
* Missing: UDP/datagram runtime support (no ``net_udp_*`` builtins).
* Karkain work: datagram socket builtins + error model.

CAP-002 — HTTP routing/middleware/concurrent server
----------------------------------------------------

* Required by: A17, A18, A28
* Status: ``partial``
* Current: loopback/basic building blocks (``http_listen``/``http_accept``/
  ``http_read_request``/``http_write_response``). No routing, middleware, or
  concurrent server framework.
* Karkain work: routing + concurrency integration; do not present current
  blocks as a production framework.

CAP-003 — JSON
--------------

* Required by: A16, A18, A79
* Status: ``blocked``
* Missing: JSON parse/emit support.
* Karkain work: stdlib JSON module on verified string/array/map builtins.

CAP-004 — External SQL + joins + bindings
------------------------------------------

* Required by: A20, A22, A43, A44, A45
* Status: ``blocked``
* Current: embedded ``db2`` and the lab SQL-subset engine only (CREATE,
  INSERT, SELECT, single-equality WHERE, UPDATE, DELETE, DROP, TABLES,
  SCHEMA; no joins, no parameter binding, ``|``/newline restrictions,
  pipe-delimited file format).
* Karkain work: external DB drivers or extended dialect; until then use
  the subset engine within documented limits.

CAP-005 — True threads/timeouts/synchronization
------------------------------------------------

* Required by: A25–A30
* Status: ``partial``
* Current verified model: ``spawn``, ``join``, ``wait_all``, channels.
* Not claimed: preemptive threads, timeout scheduling, blocking ``select``,
  production-grade scheduling.
* Karkain work: timeout/sync primitives if pipelines require them.

CAP-006 — GUI toolkit
---------------------

* Required by: A53–A61
* Status: ``blocked``
* Missing: window/controls/event-loop facility.
* Rule: do not invent a GUI API.

CAP-007 — TLS
-------------

* Required by: A71, A72
* Status: ``blocked``
* Missing: TLS client/server capability.
* Rule: do not hand-roll cryptography for demonstration.

CAP-008 — Portable system/environment/arguments/time
-----------------------------------------------------

* Required by: A01, A36–A38
* Status: ``partial``
* Current: ``stdlib/system/system.kark`` is POSIX-oriented
  (``uname/test/mkdir/mv/cp/sleep`` via ``system()``); ``get_args()`` returns
  an empty array in the checked-in stdlib surface; Windows portability is not
  established.
* Phase 005 evidence: ``system(cmd)`` returns only the command exit code
  (verified ``exit 0`` → ``0``, ``exit 3`` → ``3`` on Windows) — command
  output cannot be captured, so A01 has no data source for system facts.
* Karkain work: portable env/args/time/process APIs.

CAP-009 — Recursive filesystem/stat/metadata
---------------------------------------------

* Required by: A02, A06, A33
* Status: ``partial``
* Current: ``listFiles`` (non-recursive, no stat/mtime/mode).
* Karkain work: recursive walk + stat/metadata builtins.

CAP-010 — WebSocket
-------------------

* Required by: A19
* Status: ``blocked``
* Missing: WebSocket capability (no handshake, frame codec, or
  event/push primitives). Confirmed by source scan; no partial support
  exists anywhere in the laboratory.
* Rule: do not hand-roll a frame codec as a "demonstration".

CAP-011 — Native database transactions
--------------------------------------

* Required by: A23
* Status: ``blocked``
* Missing: BEGIN/COMMIT/ROLLBACK, transaction objects, atomic
  persistence, savepoints. The Karkain 1.1.0 application surface offers
  only ``readFile``/``writeFile``.
* Current: A23 application-level pattern only — snapshot the loaded db,
  stage all steps on the working copy, single ``db_save`` on full
  success, re-save the snapshot on controlled failure. This is recovery,
  not ACID: no crash-atomicity, no isolation.
* Karkain work: atomic-write and transaction primitives if durable
  multi-step operations are ever required.
