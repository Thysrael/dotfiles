export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_STATE_HOME="$HOME/.local/state"

export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
export PATH="$HOME/.local/bin:/usr/local/bin:$PATH"

export LESSHISTFILE="$XDG_STATE_HOME"/less/history

export NPM_CONFIG_INIT_MODULE="$XDG_CONFIG_HOME"/npm/config/npm-init.js
export NPM_CONFIG_CACHE="$XDG_CACHE_HOME"/npm
export NPM_CONFIG_TMP="$XDG_RUNTIME_DIR"/npm
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME"/npm/npmrc

export TERMINFO="$XDG_DATA_HOME"/terminfo
export TERMINFO_DIRS="$XDG_DATA_HOME"/terminfo:/usr/share/terminfo

export DOTNET_CLI_HOME="$XDG_DATA_HOME"/dotnet

export CUDA_CACHE_PATH="$XDG_CACHE_HOME"/nv
export DOCKER_CONFIG="$XDG_CONFIG_HOME"/docker
export W3M_DIR="$XDG_DATA_HOME"/w3m

# Vim
export VIMINIT='
if has("nvim")
    source $XDG_CONFIG_HOME/nvim/init.lua
else
    let $MYVIMRC="$XDG_CONFIG_HOME/vim/vimrc"
    source $MYVIMRC
endif'
