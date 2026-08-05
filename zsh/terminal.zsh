autoload -Uz add-zsh-hook

_reset_terminal_modes() {
    [[ -o interactive ]] || return 0
    [[ -t 0 || -t 1 || -t 2 ]] || return 0

    {
        printf '\e[?1000l\e[?1002l\e[?1003l\e[?1005l\e[?1006l\e[?1015l\e[<99u' > /dev/tty
    } 2>/dev/null
}

add-zsh-hook -d precmd _fix_stale_mouse_tracking 2>/dev/null
add-zsh-hook -d precmd _reset_terminal_modes 2>/dev/null
add-zsh-hook precmd _reset_terminal_modes
