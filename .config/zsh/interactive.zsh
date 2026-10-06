source "$HOME/.config/zsh/plugins/autosuggestions.zsh"
source "$HOME/.config/zsh/plugins/autopair.zsh"
ZSH_AUTOSUGGEST_STRATEGY=(history completion)
setopt NO_BANG_HIST
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' 'r:|[._-]=* r:|=*'
zmodload zsh/complist

# Expand only command-position abbreviations; quoted arguments stay untouched.
_fish_expand_abbreviation() {
    local -a words
    words=(${(z)LBUFFER})
    (( $#words )) || return 0
    local word=$words[-1] expansion=${FISH_ABBREVIATIONS[$words[-1]]}
    [[ -n $expansion && $LBUFFER == *"$word" ]] || return 0
    if (( $#words == 1 )) || [[ $words[-2] == (';'|'|'|'&&'|'||'|'&') ]]; then
        LBUFFER=${LBUFFER[1,$(( ${#LBUFFER} - ${#word} ))]}$expansion
    fi
}
_fish_abbreviation_space() { _fish_expand_abbreviation; zle self-insert; }
_fish_abbreviation_enter() { _fish_expand_abbreviation; zle .accept-line; }
_fish_accept_execute() { zle autosuggest-accept; _fish_abbreviation_enter; }
zle -N _fish_abbreviation_space
zle -N accept-line _fish_abbreviation_enter
zle -N _fish_accept_execute
bindkey -M viins ' ' _fish_abbreviation_space
bindkey -M viins '^Y' _fish_accept_execute
bindkey -M viins '^[y' forward-word
bindkey -M viins '^[[A' history-beginning-search-backward
bindkey -M viins '^[[B' history-beginning-search-forward

_fish_cursor() {
    case ${KEYMAP:-viins} in
        vicmd) printf '\e[1 q' ;;
        visual) printf '\e[2 q' ;;
        *) printf '\e[5 q' ;;
    esac
    _zsh_vi_mode_prompt
}
_zsh_vi_mode_prompt() {
    local mode=I color=cyan
    if (( REGION_ACTIVE )); then
        mode=V color=magenta
    elif [[ ${KEYMAP:-viins} == vicmd ]]; then
        mode=N color=green
    fi
    local next_prompt="%F{$color}$mode%f %F{yellow}%~%f ❯ "
    if [[ $PROMPT != $next_prompt ]]; then
        PROMPT=$next_prompt
        zle reset-prompt
    fi
}
autoload -Uz add-zle-hook-widget
add-zle-hook-widget line-init _fish_cursor
add-zle-hook-widget keymap-select _fish_cursor
add-zle-hook-widget line-pre-redraw _zsh_vi_mode_prompt
