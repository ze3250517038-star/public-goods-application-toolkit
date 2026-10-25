# Rebuild checklist.pdf from checklist.html with headless Chrome.
# Usage: powershell -ExecutionPolicy Bypass -File tools/make-pdf.ps1
$ErrorActionPreference = "Stop"
$root = Split-Path -Parent $PSScriptRoot
$src  = Join-Path $root "checklist.html"
$out  = Join-Path $root "checklist.pdf"

$chrome = @(
  "C:\Program Files\Google\Chrome\Application\chrome.exe",
  "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe",
  "$env:LOCALAPPDATA\Google\Chrome\Application\chrome.exe"
) | Where-Object { Test-Path $_ } | Select-Object -First 1
if (-not $chrome) { throw "Chrome not found; install Chrome or pass a path." }

# Injected print rules keep the 40-item checklist on 2 A4 pages.
$html = [IO.File]::ReadAllText($src, [Text.UTF8Encoding]::new($false))
$tmp  = Join-Path $env:TEMP "checklist-print.html"
$html = $html.Replace("</head>", "<style>@page{size:A4;margin:9mm}@media print{html{zoom:0.72}body{font-size:11px}}</style></head>")
[IO.File]::WriteAllText($tmp, $html, [Text.UTF8Encoding]::new($false))

if (Test-Path $out) { Remove-Item $out -Force }
$args = @("--headless=new","--disable-gpu","--no-sandbox","--no-pdf-header-footer",
          "--user-data-dir=$env:TEMP\chrome-pdf-profile",
          "--print-to-pdf=$out","file:///$($tmp -replace '\\','/')")
$errFile = Join-Path $env:TEMP "chrome-pdf-stderr.txt"
$p = Start-Process -FilePath $chrome -ArgumentList $args -Wait -NoNewWindow -PassThru `
     -RedirectStandardError $errFile
if (-not (Test-Path $out)) { throw "PDF was not produced (chrome exit $($p.ExitCode)): $(Get-Content $errFile -Raw)" }
Start-Sleep -Seconds 2
if (-not (Test-Path $out)) { throw "PDF was not produced." }
$bytes = (Get-Item $out).Length
$text  = [Text.Encoding]::GetEncoding(28591).GetString([IO.File]::ReadAllBytes($out))
$pages = ([regex]::Matches($text, '/Type\s*/Page[^s]')).Count
Write-Host "wrote $out ($bytes bytes, $pages pages)"
if ($pages -ne 2) { Write-Host "WARNING: expected 2 pages" }