######################################
##     macOS Related
######################################

if type brew &>/dev/null
then
  FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
fi

######################################
##     ANTIGEN
######################################

# Load the oh-my-zsh's library.
source ~/.zsh/antigen/antigen.zsh
antigen use oh-my-zsh
 
# Bundles from oh-my-zsh
antigen bundle git # git aliases
antigen bundle gitfast # faster completion for git
antigen bundle kubectl # adds some useful aliases and functions

# Bundles from other repos
antigen bundle zsh-users/zsh-completions # additonal completions
antigen bundle zsh-users/zsh-autosuggestions # fisk like autosuggestions based on history
antigen bundle zsh-users/zsh-syntax-highlighting # fish shell like syntax highlighting 
antigen bundle agkozak/zsh-z # jump quickly to recent directories
antigen bundle jeffreytse/zsh-vi-mode # vi mode
antigen bundle wfxr/forgit # git commands with fzf
antigen bundle MichaelAquilina/zsh-you-should-use # reminder to use aliases
antigen bundle agkozak/agkozak-zsh-prompt

# Apply antigen setup
antigen apply

#######################################
###     Config 
#######################################

# Customize the prompt
AGKOZAK_USER_HOST_DISPLAY=0
AGKOZAK_MULTILINE=0
AGKOZAK_PROMPT_CHAR="❯"

### History ###
export HISTFILE=~/.zsh_history
export HISTSIZE=50000
export SAVEHIST=10000
setopt HIST_IGNORE_ALL_DUPS # ignore duplicate commands
setopt SHARE_HISTORY # share history between sessions

### Aliases ###
alias cat="bat --paging=never"
alias dc="docker compose"
alias grpc="grpcurl -plaintext"

### Editor ###
export EDITOR="nvim"
alias vim="nvim"
alias vimdiff="nvim -d"

### PATH ###
export GOPATH=$HOME/go
export JAVA_HOME="`/usr/libexec/java_home -v '11'`"
export PATH="/opt/homebrew/opt/gnu-sed/libexec/gnubin:$PATH"
PATH+=":$GOPATH/bin"
PATH+=":$HOME/bin"
PATH+=":$HOME/Library/Application Support/Coursier/bin"

### FZF ###
export FZF_DEFAULT_COMMAND="fd --type file --follow --hidden --exclude '.git' --color=always"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type directory '' $HOME"
export FZF_CTRL_R_OPTS="--preview 'echo {}'"
export FZF_DEFAULT_OPTS="
--ansi 
--prompt ' '
--pointer ' '
--marker ' '
--layout reverse 
--preview 'bat --color=always {}'
--bind ctrl-u:preview-half-page-up,ctrl-d:preview-half-page-down,ctrl-f:preview-page-down,ctrl-b:preview-page-up
"

### EZA ###
export EZA_PARAMS=('--git' '--icons' 'group' '--time-style=long-iso')
alias ls='eza $EZA_PARAMS'
alias l='eza --git-ignore $EZA_PARAMS'
alias ll='eza --all --header --long $EZA_PARAMS'
alias llm='eza --all --header --long --sort=modified $EZA_PARAMS'
alias lt='eza --tree $EZA_PARAMS'

### Kubectl ###
[[ $commands[kubectl] ]] && source <(kubectl completion zsh)

### Zsh Vi Mode ###
# The plugin will auto execute this zvm_after_init function
function zvm_after_init() {
  [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
}
