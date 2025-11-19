# ===============================
# Questa Regression (PowerShell)
# ===============================

$QUESTA = "C:\questasim64_2024.1\win64\vsim.exe"
$DOFILE = "run_test.do"
$LOGDIR = "logs"

if (!(Test-Path $LOGDIR)) {
    New-Item -ItemType Directory -Force -Path $LOGDIR | Out-Null
}

$tests = Get-Content "tests.list"
$passCount = 0

foreach ($test in $tests) {

    Write-Host "=== Running $test ===" -ForegroundColor Cyan

    $cmd = "`"$QUESTA`" -c -do `"set testname $test; do $DOFILE`""
    $result = Invoke-Expression $cmd

    $logPath = "$LOGDIR\$test.log"
    $result | Out-File $logPath

    if ($result -match "UVM_FATAL" -or $result -match "UVM_ERROR") {
        Write-Host "❌ FAILED: $test" -ForegroundColor Red
    } else {
        Write-Host "✔ PASSED: $test" -ForegroundColor Green
        $passCount++
    }
}

Write-Host "===================================" -ForegroundColor Yellow
Write-Host "REGRESSION DONE: $passCount / $($tests.Count) tests passed" -ForegroundColor Yellow
Write-Host "===================================" -ForegroundColor Yellow

