#!/bin/sh

set -ex

if [ "$OS" = "Windows_NT" ]; then
	target="x86_64-pc-windows-msvc"
else
	case $(uname -sm) in
	"Darwin x86_64") target="x86_64-apple-darwin" ;;
	"Darwin arm64") target="aarch64-apple-darwin" ;;
	"Linux aarch64") target="aarch64-unknown-linux-musl" ;;
	"Linux x86_64") target="x86_64-unknown-linux-musl" ;;
	*) echo "Unsupported platform"; exit 1 ;;
	esac
fi

# Fetch the latest release download URL
REPO="Xevion/spotify-player-quickauth"
API_URL="https://api.github.com/repos/$REPO/releases/latest"
DOWNLOAD_URL=$(curl -s $API_URL | grep "browser_download_url.*$target" | cut -d '"' -f 4)

if [ -z "$DOWNLOAD_URL" ]; then
	echo "No release could be found for the current platform"
	exit 1
fi

EXECUTABLE="spotify-player-quickauth"
curl -Lso $EXECUTABLE.tar.gz $DOWNLOAD_URL
tar -xvf $EXECUTABLE
chmod +x $EXECUTABLE
./$EXECUTABLE
rm $EXECUTABLE