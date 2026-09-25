<# verify-service.ps1 — generic two-process request/response verification.
For Karkain services whose server serves a fixed number of connections
then exits (single-threaded, deterministic). The network traffic is 100%
Karkain; PowerShell only orchestrates processes and compares text.

Case file: TAB-separated lines, one per client run:
  <expectedFile><TAB><arg1><TAB><arg2>...
Arguments may contain spaces (only TAB separates). Blank lines skipped.
Server stdout is compared to -ExpectedServer. Optional no-listener
failure probe via -FailArgs + -FailExpected (run after the server exits).
Never modifies the Karkain repo. Never leaves orphans (kill on timeout).
#>
param(
  [Parameter(Mandatory = $true)][string]$App,
  [Parameter(Mandatory = $true)][string]$CaseFile,
  [string[]]$ServerArgs = @(),
  [string]$ExpectedServer = "",
  [string[]]$FailArgs = @(),
  [string]$FailExpected = "",
  [string]$KarkainRoot = "F:\Codes\Git\Karkain",
  [string]$KarkainExe = "",
  [string]$ExeName = "karkain-svc-verify.exe",
  [int]$StartupDelayMs = 1500,
  [int]$ServerTimeoutS = 30
)

$ErrorActionPreference = "Stop"

if ($KarkainExe -eq "") { $KarkainExe = Join-Path $KarkainRoot "karkain.exe" }
if (-not (Test-Path -LiteralPath $KarkainExe)) { Write-Error "Karkain executable not found: $KarkainExe"; exit 2 }
if (-not (Test-Path -LiteralPath $App)) { Write-Error "Application file not found: $App"; exit 2 }
if (-not (Test-Path -LiteralPath $CaseFile)) { Write-Error "Case file not found: $CaseFile"; exit 2 }

$procBase = [System.IO.Path]::GetFileNameWithoutExtension($ExeName)
Get-Process $procBase -ErrorAction SilentlyContinue | Stop-Process -Force
Start-Sleep -Milliseconds 300
$exe = Join-Path ([System.IO.Path]::GetTempPath()) $ExeName

Write-Output "building: $App"
Push-Location -LiteralPath $KarkainRoot
try {
  & $KarkainExe build $App -o $exe 2>&1 | ForEach-Object { Write-Output $_ }
  if ($LASTEXITCODE -ne 0) { Write-Error "karkain build failed"; exit $LASTEXITCODE }
} finally {
  Pop-Location
}

function Norm($lines) { return (($lines | Out-String).Trim() -replace "`r`n", "`n") }

try {
  $srvOut = Join-Path ([System.IO.Path]::GetTempPath()) ("svc-server-" + [System.IO.Path]::GetRandomFileName() + ".out")
  Write-Output ("starting server: {0} {1}" -f $exe, ($ServerArgs -join " "))
  $srv = Start-Process -FilePath $exe -ArgumentList $ServerArgs -RedirectStandardOutput $srvOut -NoNewWindow -PassThru
  Start-Sleep -Milliseconds $StartupDelayMs
  if ($srv.HasExited) {
    Write-Error "server exited before clients ran"
    Get-Content -LiteralPath $srvOut -ErrorAction SilentlyContinue | ForEach-Object { Write-Output $_ }
    exit 1
  }

  $caseNo = 0
  foreach ($line in (Get-Content -LiteralPath $CaseFile)) {
    if ($line.Trim() -eq "") { continue }
    $parts = $line -split "`t"
    if ($parts.Count -lt 2) { Write-Error ("bad case line: {0}" -f $line); exit 2 }
    $caseNo++
    $wantFile = $parts[0]
    if (-not [System.IO.Path]::IsPathRooted($wantFile)) {
      $wantFile = Join-Path (Split-Path -Parent $CaseFile) $wantFile
    }
    $cargs = @()
    if ($parts.Count -gt 1) { $cargs = $parts[1..($parts.Count - 1)] }
    if (-not (Test-Path -LiteralPath $wantFile)) { Write-Error ("expected file not found: {0}" -f $wantFile); exit 2 }
    Write-Output ("case {0}: {1} {2}" -f $caseNo, $exe, ($cargs -join " "))
    $out = & $exe @cargs 2>&1
    $out | ForEach-Object { Write-Output $_ }
    $want = (Get-Content -LiteralPath $wantFile -Raw).Trim() -replace "`r`n", "`n"
    if ((Norm $out) -ne $want) { Write-Error ("case {0} mismatch vs {1}" -f $caseNo, $wantFile); exit 1 }
    Write-Output ("case {0}: MATCH" -f $caseNo)
  }

  if (-not $srv.WaitForExit($ServerTimeoutS * 1000)) {
    Stop-Process -InputObject $srv -Force
    Write-Error ("server did not exit within {0}s; killed" -f $ServerTimeoutS)
    exit 1
  }
  if ($ExpectedServer -ne "" -and -not [System.IO.Path]::IsPathRooted($ExpectedServer)) {
    $ExpectedServer = Join-Path (Split-Path -Parent $CaseFile) $ExpectedServer
  }
  if ($FailExpected -ne "" -and -not [System.IO.Path]::IsPathRooted($FailExpected)) {
    $FailExpected = Join-Path (Split-Path -Parent $CaseFile) $FailExpected
  }
  if ($ExpectedServer -ne "") {
    $gotSrv = Norm (Get-Content -LiteralPath $srvOut)
    $wantSrv = (Get-Content -LiteralPath $ExpectedServer -Raw).Trim() -replace "`r`n", "`n"
    if ($gotSrv -ne $wantSrv) { Write-Error ("server output mismatch vs {0}" -f $ExpectedServer); Write-Output $gotSrv; exit 1 }
    Write-Output "server output: MATCH"
  }
  Remove-Item -LiteralPath $srvOut -ErrorAction SilentlyContinue

  if ($FailArgs.Count -gt 0 -and $FailExpected -ne "") {
    Write-Output ("failure case: {0} {1}" -f $exe, ($FailArgs -join " "))
    $fout = & $exe @FailArgs 2>&1
    $fout | ForEach-Object { Write-Output $_ }
    $wantF = (Get-Content -LiteralPath $FailExpected -Raw).Trim() -replace "`r`n", "`n"
    if ((Norm $fout) -ne $wantF) { Write-Error ("failure mismatch vs {0}" -f $FailExpected); exit 1 }
    Write-Output "failure case: MATCH"
  }
} finally {
  Get-Process $procBase -ErrorAction SilentlyContinue | Stop-Process -Force
  Remove-Item -LiteralPath $exe -ErrorAction SilentlyContinue
}
Write-Output "verify-service: PASS"
