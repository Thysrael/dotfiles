#!/usr/bin/env zsh

set -eu

if (( $# != 1 )); then
    print -u2 'Usage: init-server.sh <ssh-host>'
    exit 2
fi

ssh_host=$1
case $ssh_host in
    *[!A-Za-z0-9._-]* | '')
        print -u2 "Invalid SSH host: $ssh_host"
        exit 2
        ;;
esac

repo_url=${DOTFILES_REPO_URL:-https://github.com/Thysrael/dotfiles.git}
remote_port=${REMOTE_PROXY_PORT:-17897}
repo_root=${0:A:h:h}

source "$repo_root/zsh/proxy.zsh"
pr start "$ssh_host"

proxy_url="http://127.0.0.1:$remote_port"
command ssh "$ssh_host" \
    "DOTFILES_REPO_URL=${(q)repo_url} PROXY_URL=${(q)proxy_url} sh -s" <<'REMOTE'
set -eu

export http_proxy=$PROXY_URL
export https_proxy=$PROXY_URL

dotfiles_dir="$HOME/dotfiles"
if [ -d "$dotfiles_dir/.git" ]; then
    git -C "$dotfiles_dir" pull --ff-only
elif [ -e "$dotfiles_dir" ]; then
    printf 'Error: %s exists and is not a git repository.\n' "$dotfiles_dir" >&2
    exit 1
else
    git clone --depth 1 --recursive --shallow-submodules \
        "$DOTFILES_REPO_URL" "$dotfiles_dir"
fi

git -C "$dotfiles_dir" submodule update --init --recursive --depth 1
make -C "$dotfiles_dir" boot-server
REMOTE
