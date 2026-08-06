#!/bin/sh

set -eu

repo_root=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)

if [ "$(uname -s)" != Linux ]; then
    printf 'Error: boot-server requires Linux.\n' >&2
    exit 1
fi

case $(uname -m) in
    x86_64 | amd64) suffix=amd64 ;;
    aarch64 | arm64) suffix=arm64 ;;
    *)
        printf 'Error: unsupported architecture: %s\n' "$(uname -m)" >&2
        exit 1
        ;;
esac

file="toolkit-$suffix.tar.gz"
url="https://github.com/thysrael/dotfiles/releases/latest/download/$file"
dest="$HOME/.local/bin"

mkdir -p "$dest"
printf 'Downloading %s...\n' "$file"
curl -Lf --progress-bar "$url" | tar -xz -C "$dest"
printf 'Installed %s to %s\n' "$file" "$dest"
"$dest/rg" --version
"$dest/lazygit" --version
"$dest/opencode" --version
make -C "$repo_root" server
