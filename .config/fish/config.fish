# Homebrew environment
set -gx HOMEBREW_PREFIX /opt/homebrew
set -gx HOMEBREW_CELLAR /opt/homebrew/Cellar
set -gx HOMEBREW_REPOSITORY /opt/homebrew

set -gx GOPATH $HOME/go

# Keep PATH entries unique when this configuration is sourced again.
fish_add_path --global --path $HOME/.local/bin $HOME/.docker/bin \
    $GOPATH/bin \
    /opt/homebrew/bin /opt/homebrew/sbin \
    /opt/homebrew/opt/gnu-sed/libexec/gnubin \
    /Applications/Ghostty.app/Contents/MacOS

if not set -q MANPATH
    set -gx MANPATH /opt/homebrew/share/man ''
end

if not set -q INFOPATH
    set -gx INFOPATH /opt/homebrew/share/info
end

# Set the editor for interactive shells and commands launched through fish.
set -gx EDITOR nvim

###################################
# Interactive mode configurations #
###################################
status is-interactive || return

# Suppress the default login message
set -g fish_greeting

# Enable vi key bindings
set fish_cursor_default block blink
set fish_cursor_insert line blink
set fish_cursor_replace_one underscore blink
set fish_cursor_visual block
function fish_user_key_bindings
    # Move forward one word with Alt+Y
    bind -M insert \ey forward-word
end

fish_vi_key_bindings
fish_user_key_bindings

# fzf
set -x FZF_DEFAULT_COMMAND 'fd --type file --follow --hidden --exclude ".git"'
set -x FZF_CTRL_T_COMMAND $FZF_DEFAULT_COMMAND
set -x FZF_ALT_C_COMMAND 'fd --type directory "" $HOME'
set -x FZF_CTRL_R_OPTS ''

set -x FZF_DEFAULT_OPTS '
--cycle
--layout "reverse"
--prompt " "
--pointer " "
--marker " "
--bind ctrl-u:preview-half-page-up,ctrl-d:preview-half-page-down,ctrl-f:preview-page-down,ctrl-b:preview-page-up
'

if type -q fzf
    fzf --fish | source
end

# eza 
set -x EZA_PARAMS --git --icons --group '--time-style=long-iso'
alias ls 'eza $EZA_PARAMS'
alias l 'eza --git-ignore $EZA_PARAMS'
alias ll 'eza --all --header --long $EZA_PARAMS'
alias llm 'eza --all --header --long --sort=modified $EZA_PARAMS'
alias lt 'eza --tree $EZA_PARAMS'

# zoxide
if type -q zoxide
    zoxide init fish | source
end

# direnv
if type -q direnv
    direnv hook fish | source
end

# ripgrep
set -x RIPGREP_CONFIG_PATH ~/.config/ripgrep/ripgrep.conf

# paimon
set -x PAIMON_WAREHOUSE_PATH ~/code/data

# Aliases
alias vim nvim
alias vimdiff 'nvim -d'
alias cat 'bat --paging=never'
alias kcat 'kcat -X security.protocol=sasl_ssl -X sasl.mechanism=PLAIN -X sasl.username=$KAFKA_SASL_USERNAME -X sasl.password=$KAFKA_SASL_PASSWORD'

# Abbreviations
abbr -a d docker
abbr -a dc 'docker compose'
abbr -a grpc 'grpcurl -plaintext'

# secrets
if test -r ~/.secrets.fish
    source ~/.secrets.fish
end
