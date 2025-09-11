# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.config/zsh/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# history set
HISTFILE="$XDG_STATE_HOME"/zsh/history
HISTSIZE=10000
SAVEHIST=50000
setopt HIST_IGNORE_ALL_DUPS # History won't save duplicates.
setopt HIST_FIND_NO_DUPS # History won't show duplicates on search.

# dump
autoload -Uz compinit
compinit -d "$XDG_CACHE_HOME"/zsh/zcompdump-"$ZSH_VERSION"
# ignore case
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# plugins
ZSH="$XDG_CONFIG_HOME/zsh"
source $ZSH/zsh-autosuggestions/zsh-autosuggestions.zsh
source $ZSH/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $ZSH/powerlevel10k/powerlevel10k.zsh-theme
# To customize prompt, run `p10k configure` or edit ~/.config/zsh/.p10k.zsh.
[[ ! -f $ZSH/.p10k.zsh ]] || source $ZSH/.p10k.zsh

# alias
source $ZSH/alias.zsh

# fzf
source $ZSH/fzf.zsh

# custom
[[ ! -f $ZSH/custom.zsh ]] || source $ZSH/custom.zsh
