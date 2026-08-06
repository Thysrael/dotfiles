#!/bin/sh

set -eu

repo_root=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)

if [ "$(uname -s)" != Darwin ]; then
    printf 'Error: boot-mac requires macOS.\n' >&2
    exit 1
fi

if ! xcode-select -p >/dev/null 2>&1; then
    xcode-select --install >/dev/null 2>&1 || true
    printf "Install the requested Command Line Tools, then run 'make boot-mac' again.\n" >&2
    exit 1
fi

if ! command -v brew >/dev/null 2>&1; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

brew_bin=$(command -v brew 2>/dev/null || true)
[ -n "$brew_bin" ] || [ ! -x /opt/homebrew/bin/brew ] || brew_bin=/opt/homebrew/bin/brew
[ -n "$brew_bin" ] || [ ! -x /usr/local/bin/brew ] || brew_bin=/usr/local/bin/brew
if [ -z "$brew_bin" ]; then
    printf 'Error: Homebrew installation completed but brew was not found.\n' >&2
    exit 1
fi

eval "$("$brew_bin" shellenv)"
brew bundle --file="$repo_root/Brewfile"
git -C "$repo_root" submodule update --init --recursive
mkdir -p "$HOME/Library/Rime"
make -C "$repo_root" mac
