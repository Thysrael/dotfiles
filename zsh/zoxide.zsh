# zoxide
command -v zoxide >/dev/null 2>&1
if [ $? -eq 0 ]; then
    eval "$(zoxide init zsh --cmd cd)"
fi
