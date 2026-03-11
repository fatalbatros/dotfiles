alias f='vifm'
alias v='vim'
alias vv='vim -c "normal '\''0"'
alias nn='vim ~/.notes/log'

alias j='jump'

alias G='vim -c "G | on"'
alias gco='git checkout'

alias ls='ls --color=auto'
alias grep='grep --color=auto'

alias slp='slock & sleep 0.5 && systemctl suspend'
alias dotfiles='/usr/bin/git --git-dir="$HOME/.dotfiles/" --work-tree="$HOME"'

export EDITOR="vim"
export MARKPATH="/home/alba/.local/share/marks"
export TERM="alacritty"

bat() {
    cat /sys/class/power_supply/BAT0/capacity
}

_completemarks () { 
    local curw=${COMP_WORDS[COMP_CWORD]};
    local wordlist=$(find $MARKPATH -type l -printf "%f\n");
    COMPREPLY=($(compgen -W "${wordlist[@]}" -- "$curw"));
    return 0
}

complete -F _completemarks jump
complete -F _completemarks j

jump () { 
    cd -P "$MARKPATH/$1" 2> /dev/null || echo "No such mark: $1"
}

mark () { 
    mkdir -p "$MARKPATH";
    ln -s "$(pwd)" "$MARKPATH/$1"
}

marks () { 
    \ls -l "$MARKPATH" | sed 's/  / /g' | cut -d' ' -f9- | sed 's/ -/\t-/g' && echo
}

unmark () { 
    rm -i "$MARKPATH/$1"
}
