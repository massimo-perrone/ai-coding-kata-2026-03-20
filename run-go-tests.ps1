$ErrorActionPreference = 'Stop'

$rootDir = Split-Path -Parent $MyInvocation.MyCommand.Path

Write-Host ""
Write-Host '==> go-kata'

Push-Location (Join-Path $rootDir 'go-kata')
try {
    & go test ./...
    if ($LASTEXITCODE -ne 0) {
        exit $LASTEXITCODE
    }

    Write-Host '[PASS] go-kata'
    exit 0
}
finally {
    Pop-Location
}