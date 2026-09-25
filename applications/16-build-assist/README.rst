A12 Build/Project Assistant
===========================

Status: ``PARTIAL`` (layout validation + guidance; cannot invoke toolchain)

Purpose
-------

Validate a Karkain project directory by name (manifest, entrypoint,
``.kark`` count) and print the exact ``karkain`` commands to run next.
It deliberately does NOT invoke the toolchain itself: ``system()``
returns exit codes only and is not portable, so driving
``karkain check/build`` from inside Karkain would add nothing verifiable.

Usage (built binary)::

  build-assist <dir>

Build::

  cd F:\Codes\Git\Karkain
  karkain build .../16-build-assist/app.kark -o build-assist.exe

Example (``test_data/``: ``app.kark``, ``karkain.toml``, ``notes.txt``)::

  build-assist test_data
    dir: test_data
    entries: 3
    kark_files: 1
    manifest: present
    entrypoint: app.kark
    suggest: karkain check app.kark
    suggest: karkain build app.kark -o app.exe

Without an entrypoint the tool prints ``entrypoint: absent`` plus
``suggest: create app.kark entrypoint``. The ``dir:`` line uses the
basename so absolute-path invocation stays portable. Pinned output:
``expected.txt``.

Capabilities exercised
----------------------

``getArgs``, ``listFiles`` (sorted), ``substr`` (``.kark`` suffix,
basename scan), ``len``/``str``, sibling module (``import assist_scan``).

Implemented subset
------------------

Name-based layout validation (manifest/entrypoint/``.kark`` count),
actionable next-command suggestions, usage and missing-dir diagnostics.

Not implemented
---------------

Toolchain invocation, dependency fetching, build orchestration
(``system()`` boundary, CAP-008). No stat API, so checks are name-based
only (CAP-009).

Files
-----

* ``app.kark`` — dispatcher, usage/errors, suggestions.
* ``assist_scan.kark`` — scan + sort + suffix/basename helpers.
* ``test_data/`` — ``app.kark``, ``karkain.toml``, ``notes.txt``.
* ``expected.txt``. ``CAPABILITY.rst``.
