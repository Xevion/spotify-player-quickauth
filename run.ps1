$ErrorActionPreference = "Stop"

$osPlatform = [System.Runtime.InteropServices.RuntimeInformation]::OSDescription
$architecture = [System.Runtime.InteropServices.RuntimeInformation]::OSArchitecture

# Adjust the platform and architecture for the API call
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
    Write-Host "It looks like you are not on a Windows platform. Please use the native SH script option for your platform."
    exit 1
}


$target = "x86_64-pc-windows-msvc"

# Fetch the latest release download URL
$REPO = "Xevion/spotify-player-quickauth"
$API_URL = "https://api.github.com/repos/$REPO/releases/latest"
$DOWNLOAD_URL = (Invoke-RestMethod -Uri $API_URL).assets | Where-Object { $_.browser_download_url -match $target } | Select-Object -ExpandProperty browser_download_url

if (-not $DOWNLOAD_URL) {
	Write-Host "No release could be found for the current platform"
	exit 1
}

$EXECUTABLE = "spotify-player-quickauth.exe"
Invoke-WebRequest -Uri $DOWNLOAD_URL -OutFile $EXECUTABLE
Start-Process -FilePath $EXECUTABLE -Wait
Remove-Item $EXECUTABLE
