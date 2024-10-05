#!/bin/sh
set -e

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

# Flags parsing
STOP=0
KEEP=0
for arg in "$@"; do
	case $arg in
	-K|--keep)
		# Keep the unzipped executable after running
		KEEP=1
		;;
	-S|--stop)
		# Don't run the executable after unzipping (also keeps it)
		STOP=1
		KEEP=1
		;;
	esac
done

# Fetch the latest release download URL
REPO="Xevion/spotify-quickauth"
API_URL="https://api.github.com/repos/$REPO/releases/latest"
if [ -n "$GH_TOKEN" ]; then
	API_URL="$API_URL -H 'Authorization: Bearer $GH_TOKEN'"
fi
DOWNLOAD_URL=$(curl -s $API_URL  | grep "browser_download_url" | grep $target | cut -d '"' -f 4)

if [ -z "$DOWNLOAD_URL" ]; then
	echo "No release could be found for the current platform"
	exit 1
fi

EXECUTABLE="spotify-quickauth"
curl -Lso $EXECUTABLE.tar.gz $DOWNLOAD_URL
tar -xvf $EXECUTABLE.tar.gz $EXECUTABLE 1>/dev/null
rm $EXECUTABLE.tar.gz
chmod +x $EXECUTABLE
if [ "$KEEP" -eq 0 ]; then
	trap "rm -f $EXECUTABLE" INT EXIT
fi
if [ "$STOP" -eq 0 ]; then
	./$EXECUTABLE $@
fi