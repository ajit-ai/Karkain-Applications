<# verify-apps.ps1 — run a Karkain application and optionally diff expected.txt.
Synopsis:
  powershell -File tools/verify-apps.ps1 -App <path-to-app.kark> [-Expected <path-to-expected.txt>]
  powershell -File tools/verify-apps.ps1 -App <path-to-app.kark> -ProgramArgs <csv> -UseBuild [-Expected <path-to-expected.txt>]
Rules:
  - Uses the Karkain repository as cwd (required for stdlib + kcc resolution).
  - Never assumes Karkain-Applications itself is a valid Karkain stdlib root.
  - Never modifies the Karkain repository.
  - Karkain 1.1.0 `karkain run` drops program arguments, so apps needing
    getArgs() (e.g. 01-csv-tool) must use -UseBuild: the script builds a temp
    exe and executes it with -ProgramArgs (real OS argv, verified working).
#>
param(
  [Parameter(Mandatory = $true)][string]$App,
  [string]$Expected = "",
  [string[]]$ProgramArgs = @(),
  [switch]$UseBuild,
  [string]$KarkainRoot = "F:\Codes\Git\Karkain",
  [string]$KarkainExe = ""
)

$ErrorActionPreference = "Stop"

if ($KarkainExe -eq "") { $KarkainExe = Join-Path $KarkainRoot "karkain.exe" }
if (-not (Test-Path -LiteralPath $KarkainExe)) {
  Write-Error "Karkain executable not found: $KarkainExe (set -KarkainExe or -KarkainRoot)"
  exit 2
}
if (-not (Test-Path -LiteralPath $KarkainRoot)) {
  Write-Error "Karkain root not found: $KarkainRoot"
  exit 2
}
if (-not (Test-Path -LiteralPath $App)) {
  Write-Error "Application file not found: $App"
  exit 2
}
if ($Expected -ne "" -and -not (Test-Path -LiteralPath $Expected)) {
  Write-Error "Expected-output file not found: $Expected"
  exit 2
}

Write-Output "cwd (Karkain root): $KarkainRoot"
Write-Output "exe: $KarkainExe"
Write-Output "app: $App"

Push-Location -LiteralPath $KarkainRoot
try {
  if ($UseBuild) {
    $tmp = Join-Path ([System.IO.Path]::GetTempPath()) ("verify-apps-" + [System.IO.Path]::GetRandomFileName() + ".exe")
    & $KarkainExe build $App -o $tmp 2>&1 | ForEach-Object { Write-Output $_ }
    if ($LASTEXITCODE -ne 0) { Write-Error "karkain build failed"; exit $LASTEXITCODE }
    try {
      $out = & $tmp @ProgramArgs 2>&1
      $code = $LASTEXITCODE
    } finally {
      Remove-Item -LiteralPath $tmp -ErrorAction SilentlyContinue
    }
  } else {
    if ($ProgramArgs.Count -ne 0) {
      Write-Error "ProgramArgs requires -UseBuild (karkain run drops program arguments in 1.1.0)"
      exit 2
    }
    $out = & $KarkainExe run $App 2>&1
    $code = $LASTEXITCODE
  }
} finally {
  Pop-Location
}
$out | ForEach-Object { Write-Output $_ }
if ($code -ne 0) {
  Write-Error "application failed with exit code $code"
  exit $code
}

if ($Expected -ne "") {
  $actual = ($out | Out-String).Trim() -replace "`r`n", "`n"
  $want = (Get-Content -LiteralPath $Expected -Raw).Trim() -replace "`r`n", "`n"
  if ($actual -ne $want) {
    Write-Error "Output mismatch vs $Expected"
    exit 1
  }
  Write-Output "verify-apps: MATCH ($Expected)"
} else {
  Write-Output "verify-apps: OK (no expected file, run succeeded)"
}
