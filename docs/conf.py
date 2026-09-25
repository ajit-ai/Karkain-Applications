# Sphinx configuration — Karkain-Applications laboratory docs.
# Minimal stdlib-only build (no extensions) so Read the Docs, GitHub
# Actions, and local builds all work with just Sphinx itself.
project = "Karkain-Applications"
author = "Karkain laboratory"
version = "1.0"
release = "1.0-roadmap-complete"
extensions = []
templates_path = ["_templates"]
exclude_patterns = ["_build", "_templates"]
master_doc = "index"
source_suffix = ".rst"
language = "en"
html_theme = "alabaster"
html_title = "Karkain-Applications Laboratory"
# Project-owned hardening stylesheet (layout invariants only: no fixed
# content heights, always-visible footer, anchor margin). Alabaster's
# layout unconditionally links _static/custom.css; this file supplies it.
html_static_path = ["_static"]
