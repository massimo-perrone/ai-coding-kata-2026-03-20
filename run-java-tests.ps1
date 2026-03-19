$ErrorActionPreference = 'Stop'

$rootDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$javaDir = Join-Path $rootDir 'java-kata'
$wrapperBat = Join-Path $javaDir 'gradlew.bat'
$wrapperJar = Join-Path $javaDir 'gradle/wrapper/gradle-wrapper.jar'
$gradle = Get-Command gradle -ErrorAction SilentlyContinue

Write-Host ""
Write-Host '==> java-kata'

Push-Location $javaDir
try {
    if ((Test-Path $wrapperBat) -and (Test-Path $wrapperJar)) {
        & .\gradlew.bat --no-daemon test
        if ($LASTEXITCODE -ne 0) {
            exit $LASTEXITCODE
        }

        Write-Host '[PASS] java-kata'
        exit 0
    }

    if ($gradle) {
        & gradle --no-daemon test
        if ($LASTEXITCODE -ne 0) {
            exit $LASTEXITCODE
        }

        Write-Host '[PASS] java-kata'
        exit 0
    }

    Write-Host '[FAIL] java-kata'
    Write-Host '       Gradle wrapper is incomplete and no local gradle command was found.'
    Write-Host "       Expected wrapper jar: $wrapperJar"
    exit 1
}
finally {
    Pop-Location
}