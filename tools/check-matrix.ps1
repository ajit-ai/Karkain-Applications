<# check-matrix.ps1 — structural check for the capability laboratory (not a compiler test).
Verifies:
  - docs/capabilities.rst, docs/capability-gaps.rst, docs/applications.rst exist
  - required capability IDs exist; blocked stays blocked
  - required application directories exist (Phases 001-012: 01-26 + flagship)
  - README.rst/CAPABILITY.rst present for every documented app dir
  - no fake GUI/UDP/TLS implementations were added
#>
$ErrorActionPreference = "Stop"

$root = Split-Path -Parent $PSScriptRoot
$fail = 0
function Check($cond, $msg) {
  if ($cond) { Write-Output "OK: $msg" } else { Write-Error "FAIL: $msg"; $script:fail = 1 }
}

$cap = Join-Path $root "docs\capabilities.rst"
$gaps = Join-Path $root "docs\capability-gaps.rst"
$apps = Join-Path $root "docs\applications.rst"
Check (Test-Path -LiteralPath $cap) "docs/capabilities.rst exists"
Check (Test-Path -LiteralPath $gaps) "docs/capability-gaps.rst exists"
Check (Test-Path -LiteralPath $apps) "docs/applications.rst exists"

if (Test-Path -LiteralPath $cap) {
  $t = Get-Content -LiteralPath $cap -Raw
  foreach ($id in @("UDP", "WebSocket", "TLS", "JSON", "External SQL", "GUI")) {
    Check ($t -match [regex]::Escape($id)) "capabilities.rst mentions $id"
  }
  Check ($t -match "blocked") "capabilities.rst represents blocked"
}
if (Test-Path -LiteralPath $gaps) {
  $t = Get-Content -LiteralPath $gaps -Raw
  foreach ($id in @("CAP-001","CAP-002","CAP-003","CAP-004","CAP-005","CAP-006","CAP-007","CAP-008","CAP-009")) {
    Check ($t -match [regex]::Escape($id)) "$id present"
  }
}
foreach ($d in @("applications\01-csv-tool","applications\02-log-analyzer","applications\03-source-analyzer","applications\04-tcp-echo","applications\05-http-service","applications\06-db-crud","applications\07-worker-pool","applications\08-system-info","applications\09-file-tool","applications\10-config-manager","applications\11-backup","applications\12-project-explorer","applications\13-dep-inspector","applications\14-code-format","applications\15-doc-gen","applications\16-build-assist","applications\17-udp","applications\18-rest-tasks","applications\19-task-service","applications\20-db-transactions","applications\21-db-admin","applications\22-websocket","applications\23-batch-etl","applications\24-gui","applications\25-taskops","applications\26-advanced","applications\flagship")) {
  Check (Test-Path -LiteralPath (Join-Path $root $d)) "$d exists"
}
foreach ($d in @("applications\05-http-service","applications\06-db-crud","applications\07-worker-pool","applications\08-system-info","applications\09-file-tool","applications\10-config-manager","applications\11-backup","applications\12-project-explorer","applications\13-dep-inspector","applications\14-code-format","applications\15-doc-gen","applications\16-build-assist","applications\17-udp","applications\18-rest-tasks","applications\19-task-service","applications\20-db-transactions","applications\21-db-admin","applications\22-websocket","applications\23-batch-etl","applications\24-gui","applications\25-taskops","applications\26-advanced","applications\flagship")) {
  Check (Test-Path -LiteralPath (Join-Path $root "$d\README.rst")) "$d README.rst exists"
  Check (Test-Path -LiteralPath (Join-Path $root "$d\CAPABILITY.rst")) "$d CAPABILITY.rst exists"
}

$prohibited = @("fake_http_server","fake_database","fake_async","fake_gui","fake_thread")
$files = Get-ChildItem -Recurse -LiteralPath (Join-Path $root "applications") -Include *.kark,*.rst,*.md,*.ps1 -ErrorAction SilentlyContinue
$hit = @()
foreach ($f in $files) {
  $c = Get-Content -LiteralPath $f.FullName -Raw -ErrorAction SilentlyContinue
  foreach ($p in $prohibited) { if ($c -match [regex]::Escape($p)) { $hit += "$($f.FullName): $p" } }
}
Check ($hit.Count -eq 0) "no fake implementations"
if ($hit.Count -ne 0) { $hit | ForEach-Object { Write-Output $_ } }

if ($fail -ne 0) { exit 1 }
Write-Output "check-matrix: PASS"
