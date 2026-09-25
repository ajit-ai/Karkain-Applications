24-gui — Capability record (Phase 009)
========================================

Status: ``blocked`` for A53–A61. No GUI capability exists to exercise.

Evidence: full-text source scan of the pristine-HEAD toolchain
(``stdlib/``, ``src/``, ``pkg/``) for GUI terms — zero genuine
matches. ``stdlib/gpu`` is compute-only.

Gap: CAP-006 (GUI toolkit/event-loop).

Rule: do not invent a GUI API. No code in this directory by design.
CLI equivalents live in their own application directories.
