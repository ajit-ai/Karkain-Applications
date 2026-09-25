A11 Documentation Generator
===========================

Status: ``IMPLEMENTED`` (textual heuristics; not an AST tool)

Purpose
-------

Lightweight module documentation: per-file function signatures plus
comment counts, extracted textually. This analyzer performs textual
source analysis; it is not a Karkain parser, compiler front-end, AST
analyzer, or semantic analyzer.

Heuristics
----------

* Function: non-comment line whose trimmed form starts with ``func `` or
  ``public func ``; signature is the full trimmed line.
* Doc comment: non-empty trimmed line starting with ``//`` (counted, and
  never counted as a function — a ``// func helper`` note is a comment).
* Files processed in argument order; no sorting needed for determinism.

Usage (built binary)::

  doc-gen <file> [file ...]

Build::

  cd F:\Codes\Git\Karkain
  karkain build .../15-doc-gen/app.kark -o doc-gen.exe

Example (``test_data/mod1.kark``, ``test_data/mod2.kark``)::

  ## mod1.kark
  funcs:
  - public func total(items) {
  - public func price(sku) {
  comments: 2
  ## mod2.kark
  funcs:
  - public func restock(sku, qty) {
  - func helper() {
  comments: 1

Headers use basenames, so absolute-path invocation still yields portable
output. Pinned output: ``expected.txt``.

Capabilities exercised
----------------------

``getArgs`` (multiple files), ``readFile``, ``split``/``trim``/``substr``
(prefix checks, basename scan over ``/`` and ``\\``), ``len``/``str``,
arrays, sibling module (``import doc_scan``).

Limitations
-----------

Textual only: string literals containing ``func`` would count; indented
vs top-level makes no difference; no signatures beyond the source line;
no cross-file or dependency analysis. Unreadable files print an error
section and are skipped. ``split`` empty-line boundary applies but is
immaterial here (empty lines match neither heuristic).

Files
-----

* ``app.kark`` — dispatcher, usage, per-file sections.
* ``doc_scan.kark`` — prefix/basename/scan helpers.
* ``test_data/mod1.kark``, ``test_data/mod2.kark``.
* ``expected.txt``. ``CAPABILITY.rst``.
