A03 Configuration Manager
=========================

Status: ``PARTIAL`` (INI-like subset; JSON unavailable)

Purpose
-------

Real configuration workflow (parse → validate → load) over an INI-like
subset using verified Karkain 1.1.0 builtins (Phase 005).

Supported subset (NOT JSON, NOT full INI/TOML)
----------------------------------------------

``#``/``;`` full-line comments, ``[section]`` headers, ``key = value``
pairs, surrounding whitespace tolerated. Keys stored qualified as
``section.key`` (pairs before any section use the bare key). Lines without
``=`` and empty keys skipped; duplicate keys: last wins.

Modes (built binary)::

  config-manager show <file>
  config-manager get <file> <section.key>
  config-manager validate <file> <key> [key ...]

Build::

  cd F:\Codes\Git\Karkain
  karkain build .../10-config-manager/app.kark -o config-manager.exe

Example (``test_data/sample.ini``)::

  config-manager show sample.ini
    limits.debug = off
    limits.retries = 3
    server.host = 127.0.0.1
    server.port = 8080
  config-manager get sample.ini server.host
    127.0.0.1
  config-manager validate sample.ini server.host limits.retries
    ok
  config-manager validate sample.ini server.host server.missing
    missing: server.missing

Pinned output: ``expected.txt`` (show).

Capabilities exercised
----------------------

``getArgs``, ``readFile``, ``split``/``trim``/``substr``, ``len``,
``hasKey``, ``map_keys_of``, maps (qualified keys), sibling module
(``import config_parse``), sorted deterministic output.

Not implemented
---------------

JSON (blocked lab-wide, CAP-003), nested sections, typed values (all
values are strings), file writing. ``get``/``validate`` with too few
arguments print usage; missing file prints an error.

Files
-----

* ``app.kark`` — modes, usage/errors.
* ``config_parse.kark`` — subset parser + find/sort helpers.
* ``test_data/sample.ini``. ``expected.txt``. ``CAPABILITY.rst``.
