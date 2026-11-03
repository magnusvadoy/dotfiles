source "$HOME/.config/zsh/plugins/autopair.zsh"
setopt NO_BANG_HIST
zmodload zsh/complist
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'l:|=* r:|=*'
bindkey -M viins '^I' menu-complete
bindkey -M viins '^[[Z' reverse-menu-complete

# Expand only command-position abbreviations; quoted arguments stay untouched.
_abbr_expand() {
    local -a words
    words=(${(z)LBUFFER})
    (( $#words )) || return 0
    local word=$words[-1] expansion=${ZSH_ABBREVIATIONS[$words[-1]]}
    [[ -n $expansion && $LBUFFER == *"$word" ]] || return 0
    if (( $#words == 1 )) || [[ $words[-2] == (';'|'|'|'&&'|'||'|'&') ]]; then
        LBUFFER=${LBUFFER[1,$(( ${#LBUFFER} - ${#word} ))]}$expansion
    fi
}
_abbr_expand_space() { _abbr_expand; zle self-insert; }
_abbr_expand_enter() { _abbr_expand; zle .accept-line; }
zle -N _abbr_expand_space
zle -N accept-line _abbr_expand_enter
bindkey -M viins ' ' _abbr_expand_space
bindkey -M viins '^[y' forward-word
autoload -Uz history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey -M viins '^[[A' history-beginning-search-backward-end
bindkey -M viins '^[[B' history-beginning-search-forward-end

_zsh_vi_cursor() {
    case ${KEYMAP:-viins} in
        vicmd) printf '\e[1 q' ;;
        visual) printf '\e[2 q' ;;
        *) printf '\e[5 q' ;;
    esac
    _zsh_vi_mode_prompt
}
_zsh_vi_mode_prompt() {
    local mode=I color=cyan
    if [[ ${KEYMAP:-viins} == visual ]] || (( REGION_ACTIVE )); then
        mode=V color=magenta
    elif [[ ${KEYMAP:-viins} == vicmd ]]; then
        mode=N color=green
    fi
    local next_prompt='%F{yellow}%1~%f ❯ '
    if [[ $PROMPT != $next_prompt ]]; then
        PROMPT=$next_prompt
        zle reset-prompt
    fi
    local next_rprompt="${_zsh_git_prompt:+${_zsh_git_prompt} }%F{$color}[$mode]%f"
    if [[ $RPROMPT != $next_rprompt ]]; then
        RPROMPT=$next_rprompt
        zle reset-prompt
    fi
}
autoload -Uz add-zle-hook-widget
add-zle-hook-widget line-init _zsh_vi_cursor
add-zle-hook-widget keymap-select _zsh_vi_cursor
# Visual selection changes REGION_ACTIVE without switching away from vicmd.
add-zle-hook-widget line-pre-redraw _zsh_vi_mode_prompt
