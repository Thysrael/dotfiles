zwc() {
    if (( $# == 0 )); then
        print -u2 "usage: zwc <file-or-directory> [...]"
        return 2
    fi

    local target file
    local -a files
    for target in "$@"; do
        if [[ -f "$target" ]]; then
            files+=("$target")
        elif [[ -d "$target" ]]; then
            while IFS= read -r -d '' file; do
                files+=("$file")
            done < <(command rg --files -0 -g '*.md' -- "$target")
        else
            print -u2 "zwc: no such file or directory: $target"
            return 1
        fi
    done

    if (( ${#files} == 0 )); then
        print 0
        return
    fi

    command xcrun swift "$ZSH/zwc.swift" "${files[@]}"
}
