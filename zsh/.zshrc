# history set
HISTFILE="$XDG_STATE_HOME"/zsh/history
HISTSIZE=10000
SAVEHIST=50000
setopt HIST_IGNORE_ALL_DUPS # History won't save duplicates.
setopt HIST_FIND_NO_DUPS # History won't show duplicates on search.

# dump
compinit -d "$XDG_CACHE_HOME"/zsh/zcompdump-"$ZSH_VERSION"
