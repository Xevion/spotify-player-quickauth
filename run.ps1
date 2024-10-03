$ErrorActionPreference = "Stop"

$osPlatform = [System.Runtime.InteropServices.RuntimeInformation]::OSDescription
$architecture = [System.Runtime.InteropServices.RuntimeInformation]::OSArchitecture

$platform = switch -Wildcard ($osPlatform) {
    "*Windows*" { "win32" }
    "*Linux*"   { "linux" }
    "*Darwin*"  { "darwin" }
    Default     { "unknown" }
}

$arch = switch ($architecture) {
    "X64"  { "x64" }
    "X86"  { "x86" }
    "Arm"  { "arm" }
    "Arm64" { "arm64" }
    Default { "unknown" }
}

if ($platform -ne "win32") {
    Write-Host "Non-Windows platform detected. Please use the native SH script for your platform."
    exit 1
}

$target = "x86_64-pc-windows-msvc"

$REPO = "Xevion/spotify-player-quickauth"
$API_URL = "https://api.github.com/repos/$REPO/releases/latest"

try {
    $headers = @{}
    if ($env:GH_TOKEN) {
        $headers["Authorization"] = "Bearer $($env:GH_TOKEN)"
    }

    $response = Invoke-RestMethod -Uri $API_URL -Method Get -Headers $headers
} catch {
    Write-Host "Failed to fetch API response: $_"
    exit 1
}

$DOWNLOAD_URL = $response.assets | Where-Object { $_.browser_download_url -match $target } | Select-Object -ExpandProperty browser_download_url

if (-not $DOWNLOAD_URL) {
    Write-Host "No release found for the current platform"
    exit 1
}

$EXECUTABLE_ZIP = Join-Path (Get-Location) "spotify-player-quickauth.zip"
$EXECUTABLE = "spotify-player-quickauth.exe"

Invoke-RestMethod -Uri $DOWNLOAD_URL -OutFile $EXECUTABLE_ZIP

Add-Type -AssemblyName System.IO.Compression.FileSystem

if (Test-Path $EXECUTABLE) {
    Remove-Item $EXECUTABLE -ErrorAction SilentlyContinue
}

[System.IO.Compression.ZipFile]::ExtractToDirectory($EXECUTABLE_ZIP, (Get-Location).Path)

try {
    & .\$EXECUTABLE
} catch {
    Write-Host "Failed to start executable: $_"
} finally {
    Remove-Item $EXECUTABLE_ZIP -ErrorAction SilentlyContinue
    Remove-Item $EXECUTABLE -ErrorAction SilentlyContinue
}
