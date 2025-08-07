alias python="python3"
command -v lsd >/dev/null 2>&1
if [ $? -eq 0 ]; then
    alias ls="lsd --color=auto"
else
	alias ls="ls --color=auto"
fi
alias ll="ls -Al"
alias grep="grep --color=auto"
alias ga="git add ."
alias gc="git commit -m"
alias gp="git push"
alias gl="git log --graph --oneline --decorate "
alias wget="wget --hsts-file=$XDG_DATA_HOME/wget-hsts"
