source <(fzf --zsh)
export FZF_DEFAULT_OPTS="--style full --height 40% --layout=reverse --preview 'fzf-preview.sh {} 2>/dev/null'"
# export FZF_DEFAULT_OPTS='--preview "bat --style=numbers --color=always --line-range :500 {}"'
