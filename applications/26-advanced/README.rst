26-advanced — Phase 011 Advanced (A81/A83/A87/A88)
===================================================

Advanced applications built strictly from verified dependencies: a
multi-database studio, a TCP service-health console, a port-range
auditor, and a sales data-processing workbench.

Modes (built binary)::

  adv studio-diff <dbA> <dbB>        A81: table/row-count diff
  adv studio-copy <src> <dst> <t>    A81: copy table across databases
  adv studio-demo <workdir>          A81: seed A+B, diff, copy, verify
  adv health <host> <p...>           A83: TCP service health probes
  adv sweep <host> <start> <count>   A88: port-range audit (cap 16)
  adv workbench <csv> <dbfile>       A87: sales pipeline + report

A81 goes beyond the A24 read-only admin: it opens two databases at
once, diffs schemas/row counts, and copies a table across files with
a verify recount. A83/A88 probes are real TCP connects: UP means the
connect succeeded (proven live against a listener), DOWN reports the
OS error; there is no banner grabbing.

Out of scope by evidence, documented not simulated: A82 (IDE — no
editor/AST), A84 (distributed — loopback-only transport; local
distribution is A25), A85 (satisfied by the A29 pattern), A86 (dev
platform — no scaffolding primitives).

Fixtures: ``test_data/sales.csv`` (6 rows: 1 bad qty), pins
``expected-studio/workbench/health/sweep.txt`` via
``verify-apps.ps1``. Studio pins use a TEMP workdir (documented
setup, prior TEMP-path precedent).

Limitations (documented, not defects):

- Dead-port probes take ~2s each (OS connect timeout); sweep count
  capped at 16.
- Import quoting follows the engine rules (see A42).
- ``net_close`` on failed connects is tolerated by the runtime.
