#!/bin/bash

# Determine the platform
OS=$(uname)
ARCH=$(uname -m)

# Set the download URL based on the platform
if [[ "$OS" == "Linux" ]]; then
    if [[ "$ARCH" == "x86_64" ]]; then
        PLATFORM="linux-amd64"
    elif [[ "$ARCH" == "aarch64" ]]; then
        PLATFORM="linux-arm64"
    else
        echo "Unsupported architecture: $ARCH"
        exit 1
    fi
elif [[ "$OS" == "Darwin" ]]; then
    if [[ "$ARCH" == "x86_64" ]]; then
        PLATFORM="darwin-amd64"
    elif [[ "$ARCH" == "arm64" ]]; then
        PLATFORM="darwin-arm64"
    else
        echo "Unsupported architecture: $ARCH"
        exit 1
    fi
else
    echo "Unsupported OS: $OS"
    exit 1
fi

# Fetch the latest release download URL
REPO="Xevion/spotify-player-quickauth"
API_URL="https://api.github.com/repos/$REPO/releases/latest"
DOWNLOAD_URL=$(curl -s $API_URL | grep "browser_download_url.*$PLATFORM" | cut -d '"' -f 4)

if [[ -z "$DOWNLOAD_URL" ]]; then
    echo "Failed to find a download URL for platform: $PLATFORM"
    exit 1
fi

# # Download the executable
# EXECUTABLE="spotify-player-quickauth"
# curl -L -o $EXECUTABLE $DOWNLOAD_URL

# # Make the executable runnable
# chmod +x $EXECUTABLE

# # Run the executable
# ./$EXECUTABLE

# # Delete the executable
# rm $EXECUTABLE