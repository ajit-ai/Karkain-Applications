07-worker-pool — Phase 007 Concurrency (A25–A30)
====================================================

Deterministic concurrency over ``spawn``/``join``/``wait_all``/channels:
worker pool, pipeline, concurrent file processing, data grid, event
aggregation, and a concurrent HTTP service.

Modes (built binary)::

  workers pool <n>                          A25: 8 square jobs over n workers
  workers pipeline                          A26: producer -> stages -> consumer
  workers files <dir>                       A27: line counts over f1..f3
  workers grid                              A30: 3x3 multiplication grid
  workers events                            A29: tag + aggregate 6 events
  workers http-conc <port> <handlers> <each>  A28: shared-listener HTTP
  workers http-client <host> <port> <m> <p> [body]

Determinism design (all verified by repeated execution):

- Cross-task results flow as ``{id, out}`` maps over result channels;
  main collects the fixed expected count, sorts by id, then prints.
- Workers stop on sentinel ``{stop}`` maps (no close-detection
  primitive exists).
- Grid/file modes join in fixed order.
- HTTP handlers print nothing racy; main prints the joined total.

Fixture data: ``test_data/f1.txt`` (3 lines), ``f2.txt`` (4 non-blank),
``f3.txt`` (1 line). Pins: ``expected-pool/pipeline/files/grid/
events.txt`` via ``verify-apps.ps1``; ``cases-http.txt`` +
``expected-http-*.txt`` via ``verify-service.ps1``.

Limitations (documented, not defects):

- ``join()`` carries INT results only; map/array/string returns arrive
  empty (proven by probe). Hence channel-based result collection.
- No preemptive threads, timeouts, or select (CAP-005).
- No JSON (CAP-003); HTTP bodies are text/plain.
