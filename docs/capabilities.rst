Capability Matrix
==================

Living record. ``used`` only when an application actually exercises the
capability. Evidence cites verified Karkain ``1.1.0`` sources; application
evidence column names the lab application once implemented (Phase 002+).

.. list-table::
   :widths: 38 22 16 24
   :header-rows: 1

   * - Capability
     - Applications
     - Status
     - Evidence
   * - CLI ``getArgs``, ``print``/``println``
     - A02-A14 (all runnable lab apps)
     - used
     - lab apps ``01-csv-tool`` through ``16-build-assist`` minus blocked
       A01 (built binaries; ``karkain run`` forwards no args)
   * - Filesystem ``readFile``/``writeFile``/``listFiles``
     - A02/A04/A05/A07/A08/A09/A11/A12
     - used
     - lab apps ``09-file-tool`` (list/read/write/delete/search),
       ``12-project-explorer``, ``13-dep-inspector``, ``15-doc-gen``,
       ``16-build-assist`` + ``examples/03-systems/01_file_io.kark``
   * - File removal/probe ``removeFile``/``openFile``/``createFile``
     - A02
     - used
     - lab app ``09-file-tool`` (verified: missing→0/empty probes)
   * - Strings ``split``/``trim``/``substr``/``contains``
     - A04/A05/A07
     - used
     - lab apps ``01-csv-tool``, ``02-log-analyzer``,
       ``03-source-analyzer`` (incl. split-drops-empty finding)
   * - Collections arrays/maps
     - A04/A05/A07
     - used
     - lab apps ``01-csv-tool``, ``02-log-analyzer``,
       ``03-source-analyzer``
   * - ``system(cmd)``
     - A01
     - partial
     - POSIX-oriented ``stdlib/system/system.kark``
   * - TCP ``net_*``
     - A13/A14
     - used
     - lab app ``04-tcp-echo`` (two-process loopback verified) +
       ``examples/04-networking/01_tcp_echo.kark``
   * - HTTP
     - A16/A17/A18/A22
     - used
     - lab apps ``05-http-service`` (codec + server/client, pinned),
       ``18-rest-tasks`` (REST CRUD, pinned), ``19-task-service``
       (persistent REST, pinned) + ``examples/07-web/01_http_loopback.kark``
   * - Embedded DB2
     - A20/A21/A22/A23/A24
     - used
     - lab apps ``06-db-crud`` (SQL-subset CLI + CRUD, pinned),
       ``19-task-service`` (restart persistence proven),
       ``20-db-transactions`` (app-level rollback pattern, pinned),
       ``21-db-admin`` (read-only admin, pinned) +
       ``examples/06-database/01_db_crud.kark``
   * - Native DB transactions
     - A23
     - blocked
     - no BEGIN/COMMIT/ROLLBACK, atomic persistence, or savepoints;
       A23 implements snapshot/stage/single-save/snapshot-restore only
       (application-level recovery, not ACID)
   * - ``spawn``/``join``
     - A25/A26/A27/A28/A29/A30
     - used
     - lab app ``07-worker-pool`` (pool/pipeline/files/grid/events/
       concurrent-HTTP, all pinned) +
       ``examples/08-concurrency/01_parallel_sum.kark``
   * - SHA-256/SHA-512
     - A69/A70
     - used
     - ``stdlib/crypto/crypto.kark``
   * - UDP
     - A15
     - blocked
     - no UDP builtin
   * - WebSocket
     - A19
     - blocked
     - no WebSocket support
   * - TLS
     - A71/A72
     - blocked
     - no TLS capability
   * - JSON
     - A16/A18/A79
     - blocked
     - no JSON library
   * - External SQL
     - A22/A43-A45
     - blocked
     - DB2 only
   * - GUI
     - A53-A61
     - blocked
     - no GUI toolkit
   * - Portable system/env/time
     - A01/A36-A38
     - partial
     - current ``stdlib/system``
   * - Recursive filesystem/stat
     - A02/A06/A33
     - partial
     - ``listFiles`` only
