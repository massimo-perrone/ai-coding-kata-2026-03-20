$ErrorActionPreference = 'Stop'

$rootDir = Split-Path -Parent $MyInvocation.MyCommand.Path

Write-Host ""
Write-Host '==> rust-kata'

Push-Location (Join-Path $rootDir 'rust-kata')
try {
    & cargo test
    if ($LASTEXITCODE -ne 0) {
        exit $LASTEXITCODE
    }

    Write-Host '[PASS] rust-kata'
    exit 0
}
finally {
    Pop-Location
}