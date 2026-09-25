Flagship Application — CLI Operations Console (Phase 012)
============================================================

The Karkain Operations Console, CLI path (the GUI portion remains
blocked under CAP-006). It aggregates verified capabilities —
filesystem, SQL-subset database, TCP health probes, batch sessions —
into one operations surface with scripted runbooks and file reports.

Prerequisites (per the original gate): CLI/filesystem, TCP, HTTP,
database, and concurrency were demonstrated independently in
Phases 002–011 before this console was built.

Modes (built binary)::

  console status <workdir>              seed + status dashboard
  console session <runbook> <workdir>   seed + numbered transcript
  console report <runbook> <workdir> <out>  session + write transcript

Runbook commands: ``status`` | ``db-query <SQL>`` | ``probe <host>
<port>`` | ``show <path>``. Unknown commands are reported, never
executed. Runbooks are operator-trusted input: the engine would
execute any SQL statement, so only SELECT belongs in runbooks
(documented).

The console seeds its workdir (``console.db`` + ``note.txt``) from
fixed literals, so sessions are deterministic from any existing
workdir. Fixture: ``test_data/runbook.txt``. Pins:
``expected-status/session/report.txt`` via ``verify-apps.ps1``.

Limitations (documented, not defects):

- No GUI (CAP-006); no daemon/supervision; no multi-host transport.
- No ``mkdir`` (CAP-009): the workdir must already exist; seed
  writes fail silently otherwise, yielding an empty-db session.
- Absolute paths never appear in output (path-independent pins).
