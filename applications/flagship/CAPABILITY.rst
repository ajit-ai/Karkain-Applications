Flagship — Capability record (Phase 012, CLI console)
=========================================================

Implemented (verified by execution):

- Status dashboard: seeded tables/rows summary.
- Runbook sessions: status, live SELECT (incl. WHERE), TCP probe,
  file view, unknown-command + missing-arg handling; 5/5 summary.
- Report mode: transcript file proven line-identical to stdout (26
  lines) plus a path-independent ``wrote lines=`` confirmation.
- Deterministic pins ×3; reruns byte-identical.

Toolchain finding (runtime memory-safety defect, documented):

- Passing a non-empty array into a module function and mutating it
  there can crash the native binary (exit -1073741819) or silently
  lose the pushes; behavior is code-shape-dependent. Established by
  17 bisect probes. Avoidance rule now used lab-wide: accumulate
  arrays only in the owning scope; helpers RETURN line arrays;
  never pass arrays for mutation. (Related known semantic: ``push``
  to a parameter never propagates — cf. ``db_pushline`` reassign.)
- Intermittent ``cannot locate src/compiler`` resolver error also
  observed from the pristine tree; retries succeed.

Not supported:

- GUI console (blocked, CAP-006); daemons; multi-host orchestration.

Capability gaps touched: none new (engine/TCP/file reuse).
