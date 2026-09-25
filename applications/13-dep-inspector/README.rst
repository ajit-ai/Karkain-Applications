A09 Dependency Inspector
========================

Status: ``IMPLEMENTED`` (textual manifest inspection)

Purpose
-------

Inspect a ``karkain.toml`` manifest: package name/version plus sorted
``name = version`` dependency lines, covering ``[dependencies]`` and
``[dev-dependencies]`` (dev entries suffixed ``(dev)``). Textual
heuristic over the genuine manifest fields — not a resolver, locker, or
network client (Phase 005).

Usage (built binary)::

  dep-inspector <manifest-file>

Build::

  cd F:\Codes\Git\Karkain
  karkain build .../13-dep-inspector/app.kark -o dep-inspector.exe

Example (``test_data/sample.toml``)::

  dep-inspector sample.toml
    name: inventory
    version: 0.2.0
    dependencies: 3
    stdlib = ^0.14.0
    testkit (dev) = 0.1.0
    utils = 1.0.0

Also verified against this repository's own ``karkain.toml`` (``name:
karkain-applications``, 0 dependencies). Pinned output: ``expected.txt``.

Capabilities exercised
----------------------

``getArgs``, ``readFile``, ``split``/``trim``/``substr`` (section + pair
parsing, first-quoted-string version extraction), ``map_keys_of``,
``hasKey``-free map build (assignment only), maps, sibling module
(``import deps_parse``), sorted output.

Implemented
-----------

Top-level ``name``/``version`` plus dependency tables; usage and
missing-file diagnostics; deterministic sorted order.

Limitations
-----------

Textual only: no version resolution, no lockfile, no registry/network
access, no transitive graph, no ``source``/``url`` reporting (version
shown is the first quoted string of the entry). Malformed lines skipped.
Values are strings.

Files
-----

* ``app.kark`` — dispatcher, usage/errors, report.
* ``deps_parse.kark`` — section parser + find/quoted/sort helpers.
* ``test_data/sample.toml``. ``expected.txt``. ``CAPABILITY.rst``.
