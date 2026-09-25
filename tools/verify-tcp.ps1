<# verify-tcp.ps1 — two-process Karkain-to-Karkain TCP verification for 04-tcp-echo.
Steps:
  1. build app.kark to a fixed temp exe (kills stale instances first);
  2. start the Karkain server (output redirected to a temp file);
  3. wait a minimal startup delay, run the Karkain client, capture output;
  4. wait for the server to exit (kill on timeout — never leave orphans);
  5. compare combined [server]/[client] output against expected.txt;
  6. run the no-listener failure case against expected-fail.txt.
The TCP communication itself is 100% Karkain net_* APIs; PowerShell only
orchestrates processes and compares text. Never modifies the Karkain repo.
#>
param(
  [string]$AppDir = "",
  [string]$KarkainRoot = "F:\Codes\Git\Karkain",
  [string]$KarkainExe = "",
  [string]$Host_ = "127.0.0.1",
  [int]$Port = 49061,
  [int]$FailPort = 49062,
  [string]$Message = "ping",
  [int]$StartupDelayMs = 1500,
  [int]$ServerTimeoutS = 20
)

$ErrorActionPreference = "Stop"

if ($AppDir -eq "") { $AppDir = Join-Path (Split-Path -Parent $PSScriptRoot) "applications\04-tcp-echo" }
if ($KarkainExe -eq "") { $KarkainExe = Join-Path $KarkainRoot "karkain.exe" }
if (-not (Test-Path -LiteralPath $KarkainExe)) { Write-Error "Karkain executable not found: $KarkainExe"; exit 2 }

$app = Join-Path $AppDir "app.kark"
$expected = Join-Path $AppDir "expected.txt"
$expectedFail = Join-Path $AppDir "expected-fail.txt"
foreach ($f in @($app, $expected, $expectedFail)) {
  if (-not (Test-Path -LiteralPath $f)) { Write-Error "Required file not found: $f"; exit 2 }
}

$exeName = "karkain-tcp-echo-verify.exe"
$exe = Join-Path ([System.IO.Path]::GetTempPath()) $exeName
Get-Process "karkain-tcp-echo-verify" -ErrorAction SilentlyContinue | Stop-Process -Force
Start-Sleep -Milliseconds 300

Write-Output "building: $app"
Push-Location -LiteralPath $KarkainRoot
try {
  & $KarkainExe build $app -o $exe 2>&1 | ForEach-Object { Write-Output $_ }
  if ($LASTEXITCODE -ne 0) { Write-Error "karkain build failed"; exit $LASTEXITCODE }
} finally {
  Pop-Location
}

try {
  $srvOut = Join-Path ([System.IO.Path]::GetTempPath()) ("tcp-server-" + [System.IO.Path]::GetRandomFileName() + ".out")
  Write-Output "starting server: $exe server $Port"
  $srv = Start-Process -FilePath $exe -ArgumentList @("server", "$Port") -RedirectStandardOutput $srvOut -NoNewWindow -PassThru
  Start-Sleep -Milliseconds $StartupDelayMs
  if ($srv.HasExited) { Write-Error "server exited before client connected"; Get-Content -LiteralPath $srvOut -ErrorAction SilentlyContinue; exit 1 }

  Write-Output "running client: $exe client $Host_ $Port $Message"
  $clientOut = & $exe client $Host_ $Port $Message 2>&1
  $clientOut | ForEach-Object { Write-Output $_ }

  if (-not $srv.WaitForExit($ServerTimeoutS * 1000)) {
    Stop-Process -InputObject $srv -Force
    Write-Error "server did not exit within ${ServerTimeoutS}s; killed (orphan cleanup done)"
    exit 1
  }
  $serverOut = Get-Content -LiteralPath $srvOut
  Remove-Item -LiteralPath $srvOut -ErrorAction SilentlyContinue

  $actual = "[server]`n" + (($serverOut | Out-String).Trim() -replace "`r`n", "`n") + "`n[client]`n" + (($clientOut | Out-String).Trim() -replace "`r`n", "`n")
  $want = (Get-Content -LiteralPath $expected -Raw).Trim() -replace "`r`n", "`n"
  if ($actual -ne $want) {
    Write-Error "Round-trip mismatch vs $expected"
    Write-Output "--- actual ---"; Write-Output $actual
    exit 1
  }
  Write-Output "verify-tcp: ROUND TRIP MATCH"

  Write-Output "failure case: client with no listener on port $FailPort"
  $failOut = & $exe client $Host_ $FailPort $Message 2>&1
  $failOut | ForEach-Object { Write-Output $_ }
  $wantFail = (Get-Content -LiteralPath $expectedFail -Raw).Trim() -replace "`r`n", "`n"
  $gotFail = ($failOut | Out-String).Trim() -replace "`r`n", "`n"
  if ($gotFail -ne $wantFail) {
    Write-Error "Failure-case mismatch vs $expectedFail"
    exit 1
  }
  Write-Output "verify-tcp: FAILURE CASE MATCH"
} finally {
  Get-Process "karkain-tcp-echo-verify" -ErrorAction SilentlyContinue | Stop-Process -Force
  Remove-Item -LiteralPath $exe -ErrorAction SilentlyContinue
}
Write-Output "verify-tcp: PASS"
