07-worker-pool — Capability record (Phase 007)
================================================

Implemented (verified by real concurrent execution):

- A25 worker pool: N workers share a job channel, results collected
  and sorted by id (pool 1/2/8 all deterministic).
- A26 pipeline: producer -> 2 doublers -> ordered consumer.
- A27 concurrent files: ``readFile`` inside spawned tasks, ordered
  joins (3/4/1, total 8).
- A30 data grid: 9 spawns, row-major ordered joins (total 36).
- A29 events: 2 taggers + order-independent tally (big 3 / small 3).
- A28 concurrent HTTP: 2 handlers share one listener via
  ``net_accept`` (proven by probe), 2x2 requests all correct,
  deterministic server log.
- Deterministic pins for all six; error paths (bad workers, usage).

Runtime facts established by probe (CAP-005):

- ``spawn``/``join``/``wait_all``/``channel``/``chanSend``/``receive``/
  ``chanClose`` all work; multi-consumer channels distribute work.
- ``join()`` returns INT only (maps/arrays/strings arrive empty).
- No close-detection: workers need sentinel stop messages.

Not supported:

- Preemptive scheduling, timeouts, select, thread priorities.
- JSON, TLS, auth (same HTTP limits as Phase 006).

Capability gaps touched: CAP-005 (partial, as documented); no new gaps.
