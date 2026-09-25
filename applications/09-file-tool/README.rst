A02 File Management Utility
===========================

Status: ``PARTIAL`` (flat subset implemented; recursion/metadata unavailable)

Purpose
-------

Practical file utility: list, read, probe, write, delete, and
content-search files using verified Karkain 1.1.0 builtins (Phase 005).

Modes (built binary; ``karkain run`` forwards no program arguments)::

  file-tool list <dir>
  file-tool cat <file>
  file-tool exists <path>
  file-tool write <file> <content>
  file-tool delete <file>
  file-tool search <dir> <needle>

Build::

  cd F:\Codes\Git\Karkain
  karkain build .../09-file-tool/app.kark -o file-tool.exe

Example (``test_data/``: ``alpha.txt``, ``beta.txt``, ``notes.log``)::

  file-tool list test_data
    alpha.txt
    beta.txt
    notes.log
  file-tool search test_data beta
    beta.txt
  file-tool cat test_data/alpha.txt
    alpha one
  file-tool exists test_data/alpha.txt
    exists: yes

Pinned outputs: ``expected.txt`` (list), ``expected-search.txt`` (search).

Capabilities exercised
----------------------

``getArgs``, ``listFiles`` (sorted for determinism), ``readFile``,
``writeFile`` (creates/replaces), ``removeFile``, ``openFile`` existence
probe, ``contains``, arrays, sibling module (``import file_tool``).

Implemented subset
------------------

Flat single-directory listing, whole-file read, readable-file probe,
create/replace write (single-token content), delete, filename-sorted
content search. Usage and per-mode error diagnostics.

Not implemented (no Karkain 1.1.0 builtin)
-----------------------------------------

Recursive traversal, copy/move/rename, stat/mtime/size metadata, directory
creation (CAP-009). ``readFile`` returns ``""`` for both missing and empty
files, so ``cat`` reports both identically; ``exists`` uses the ``openFile``
probe instead and covers readable regular files only. No shell substitutes
(``cp``/``mv``/``find``) are used.

Files
-----

* ``app.kark`` — mode dispatcher, usage/errors.
* ``file_tool.kark`` — operations + sorting.
* ``test_data/`` — ``alpha.txt``, ``beta.txt``, ``notes.log``.
* ``expected.txt``, ``expected-search.txt`` — pinned outputs.
* ``CAPABILITY.rst`` — evidence.
