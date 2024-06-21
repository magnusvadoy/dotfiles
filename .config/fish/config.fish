# Add custom executables 
set --prepend PATH '$HOME/bin'

# Set PATH, MANPATH, etc., for Homebrew
set -gx HOMEBREW_PREFIX /opt/homebrew
set -gx HOMEBREW_CELLAR /opt/homebrew/Cellar
set -gx HOMEBREW_REPOSITORY /opt/homebrew
set -gx PATH /opt/homebrew/bin /opt/homebrew/sbin $PATH
set -q MANPATH; or set MANPATH ''
set -gx MANPATH /opt/homebrew/share/man $MANPATH
set -q INFOPATH; or set INFOPATH ''
set -gx INFOPATH /opt/homebrew/share/info $INFOPATH

# Set PATH's for Go
set -x GOPATH $HOME/go
set --append PATH $GOPATH/bin

# Java 11 as default JDK
set -x JAVA_HOME (/usr/libexec/java_home -v 11)

# Add Coursier bin to PATH
set --append PATH $HOME/Library/Application\ Support/Coursier/bin

###################################
# Interactive mode configurations #
###################################
status is-interactive || exit

# Suppress the default login message
set -g fish_greeting

# Set default editor
set -x EDITOR nvim

# Enable vi key bindings
fish_vi_key_bindings

# tide prompt
set --global tide_left_prompt_items pwd git character 
set --global tide_right_prompt_items status cmd_duration context jobs go java node rustc python ruby 

# fzf
set -x FZF_DEFAULT_COMMAND 'fd --type file --follow --hidden --exclude '.git' --color=always'
set -x FZF_CTRL_T_COMMAND $FZF_DEFAULT_COMMAND
set -x FZF_ALT_C_COMMAND 'fd --type directory '' $HOME'
set -x FZF_CTRL_R_OPTS '--preview "echo {}"'
set -x FZF_DEFAULT_OPTS '
--ansi 
--prompt " "
--pointer " "
--marker " "
--layout reverse 
--preview "bat --color=always {}"
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

# Aliases
alias vim 'nvim'
alias vimdiff 'nvim -d'
alias g 'git'
alias d 'docker'
alias dc 'docker compose'
alias cat 'bat --paging=never'
alias grpc 'grpcurl -plaintext'

source ~/.secrets.fish
