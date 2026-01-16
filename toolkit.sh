#!/bin/bash

REPO="thysrael/dotfiles"

# 1. reconnize architecture
ARCH=$(uname -m)
case $ARCH in
    x86_64|amd64)
        SUFFIX="amd64"
        ;;
    aarch64|arm64)
        SUFFIX="arm64"
        ;;
    *)
        echo "❌ Unsupported architecture: $ARCH"
        exit 1
        ;;
esac

FILE="toolkit-${SUFFIX}.tar.gz"

# 2. process version parameter (default to latest)
VERSION=${1:-"latest"}
if [ "$VERSION" = "latest" ]; then
    # GitHub "releases/latest/download" link will automatically redirect to the latest tag
    URL="https://github.com/${REPO}/releases/latest/download/${FILE}"
else
    # Target specific version
    echo "🔙 Targeting specific version: $VERSION"
    URL="https://github.com/${REPO}/releases/download/${VERSION}/${FILE}"
fi

DEST="${HOME}/.local/bin"

echo "=================================================="
echo "🚀 Architecture: $ARCH ($SUFFIX)"
echo "📦 Package:      $FILE"
echo "🎯 Version:      $VERSION"
echo "📂 Destination:  $DEST"
echo "=================================================="

# 3. ensure directory exists
mkdir -p "$DEST"

# 4. download and extract
echo "⬇️ Downloading..."
# curl -L (follow redirects) -f (fail on error)
curl -L -f -s "$URL" | tar -xz -C "$DEST"

if [ $? -eq 0 ]; then
    echo "✅ Success! Tools installed."
    echo ""
    echo "Current versions:"
    echo "-----------------"
    echo "rg:      $("$DEST/rg" --version | head -n 1)"
    echo "lazygit: $("$DEST/lazygit" --version | head -n 1)"
else
    echo "❌ Deployment failed."
    echo "   Please check if version '$VERSION' exists in Release page."
    exit 1
fi