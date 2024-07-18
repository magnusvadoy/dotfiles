# Set PATH, MANPATH, etc., for Homebrew
set -gx HOMEBREW_PREFIX /opt/homebrew HOMEBREW_CELLAR /opt/homebrew/Cellar HOMEBREW_REPOSITORY /opt/homebrew

# Set PATH for Homebrew
set --prepend PATH /opt/homebrew/bin /opt/homebrew/sbin /opt/homebrew/opt/gnu-sed/libexec/gnubin

# Set MANPATH for Homebrew
if not set -q MANPATH
    set -gx MANPATH /opt/homebrew/share/man
end

# Set INFOPATH for Homebrew
if not set -q INFOPATH
    set -gx INFOPATH /opt/homebrew/share/info
end

# Set PATH for Go
set -gx GOPATH $HOME/go
set --prepend PATH $GOPATH/bin

# Set JAVA_HOME as default JDK
set -gx JAVA_HOME (/usr/libexec/java_home -v 11)

# Add Coursier bin to PATH
set --prepend PATH $HOME/Library/Application\ Support/Coursier/bin

# Add Mason executables to PATH
set --prepend PATH $HOME/.local/share/nvim/mason/bin

# Add custom executables
set --prepend PATH $HOME/bin

###################################
# Interactive mode configurations #
###################################
status is-interactive || exit

# Suppress the default login message
set -g fish_greeting

# Set default editor
set -x EDITOR nvim

# Enable vi key bindings
set fish_cursor_default     block      blink
set fish_cursor_insert      line       blink
set fish_cursor_replace_one underscore blink
set fish_cursor_visual      block
fish_vi_key_bindings

# fzf
set -x FZF_DEFAULT_COMMAND 'fd --type file --follow --hidden --exclude ".git"'
set -x FZF_CTRL_T_COMMAND $FZF_DEFAULT_COMMAND
set -x FZF_ALT_C_COMMAND 'fd --type directory '' $HOME'
set -x FZF_CTRL_R_OPTS '--preview "echo {}"'
set -x FZF_DEFAULT_OPTS '
--cycle
--height "90%"
--layout "reverse" 
--prompt " "
--pointer " "
--marker " "
--preview-window "wrap"
--bind ctrl-u:preview-half-page-up,ctrl-d:preview-half-page-down,ctrl-f:preview-page-down,ctrl-b:preview-page-up
'

fzf --fish | source

# eza 
set -x EZA_PARAMS '--git' '--icons' '--group' '--time-style=long-iso'
alias ls 'eza $EZA_PARAMS'
alias l 'eza --git-ignore $EZA_PARAMS'
alias ll 'eza --all --header --long $EZA_PARAMS'
alias llm 'eza --all --header --long --sort=modified $EZA_PARAMS'
alias lt 'eza --tree $EZA_PARAMS'

# zoxide
zoxide init fish | source

# Aliases
alias vim 'nvim'
alias vimdiff 'nvim -d'
alias cat 'bat --paging=never'

# Abbreviations
abbr -a d 'docker'
abbr -a dc 'docker compose'
abbr -a grpc 'grpcurl -plaintext'

# secrets
source ~/.secrets.fish
