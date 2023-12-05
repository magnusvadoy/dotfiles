#######################################
###     ANTIGEN 
#######################################

# Load the oh-my-zsh's library.
source ~/.zsh/antigen/antigen.zsh
antigen use oh-my-zsh
 
# Bundles from oh-my-zsh
antigen bundle git # adds some useful aliases and functions
antigen bundle gitfast # faster completion for git
antigen bundle kubectl # adds some useful aliases and functions
antigen bundle kubectx # adds kubectx_prompt_info()
antigen bundle fzf # enabled fzf's key bindings and auto-completion
antigen bundle history-substring-search # fish shell history search feature

# Bundles from other repos
antigen bundle zsh-users/zsh-completions # additonal completions
antigen bundle zsh-users/zsh-autosuggestions # fisk like autosuggestions based on history
antigen bundle zsh-users/zsh-syntax-highlighting # fish shell like syntax highlighting 
antigen bundle agkozak/zsh-z # jump quickly to recent directories

# Theme: https://github.com/yardnsm/blox-zsh-theme
antigen bundle yardnsm/blox-zsh-theme
BLOX_CONF__ONELINE=false
BLOX_CONF__BLOCK_SEPARATOR=' '
BLOX_BLOCK__CWD_TRUNC=3

BLOX_SEG__UPPER_LEFT=( host cwd git exec_time )
BLOX_SEG__UPPER_RIGHT=( bgjobs nodejs time )
BLOX_SEG__LOWER_LEFT=( symbol )
BLOX_SEG__LOWER_RIGHT=( )

# Apply antigen setup
antigen apply

#######################################
###     Aliases 
#######################################

alias vim="nvim"
alias vi="vim"
alias cat="bat"

#######################################
###     Functions 
#######################################

function descpod() {
    if echo $1 | grep -q "ai-" > /dev/null; then
        tmpnamespace=$1
    else 
        tmpnamespace="ai-$1"
    fi

    tmppodname=$2
    if echo $2 | grep -q "ai-" > /dev/null; then
        :
    else
        if echo $2 | grep -q 'api\-\|proj\-\|etl\-\|ci\-\|tools\-\|fallback\-\|bitbucket\-' > /dev/null; then
            :
        else
            tmppodname="api-$tmppodname"
        fi
        tmppodname="ai-$tmppodname"
    fi
    tmppodlist=($(kubectl get pods -n $tmpnamespace -o=name | grep $tmppodname | sed -e "s/^pod\/\($tmppodname-[a-z0-9]*-[a-z0-9]*\).*$/\1/"))

    echo 'Write a number to select a pod'
    select tmppod in "${tmppodlist[@]}"; do
        tmppod=$(echo $tmppod | sed -e "s/^\($tmppodname-[a-z0-9]*-[a-z0-9]*\).*$/\1/")
        kubectl describe pod "$tmppod" -n $tmpnamespace
        break
    done
}

function prevlogs() {
    if echo $1 | grep -q "ai-" > /dev/null; then
        tmpnamespace=$1
    else 
        tmpnamespace="ai-$1"
    fi

    tmppodname=$2
    if echo $2 | grep -q "ai-" > /dev/null; then
        :
    else
        if echo $2 | grep -q 'api\-\|proj\-\|etl\-\|ci\-\|tools\-\|fallback\-\|bitbucket\-' > /dev/null; then
            :
        else
            tmppodname="api-$tmppodname"
        fi
        tmppodname="ai-$tmppodname"
    fi
    tmppodlist=($(kubectl get pods -n $tmpnamespace -o=name | grep $tmppodname | sed -e "s/^pod\/\($tmppodname-[a-z0-9]*-[a-z0-9]*\).*$/\1/"))

    echo 'Write a number to select a pod'
    tail=$3
    if [ -z "$tail" ]; then
        tail=20
    fi
    select tmppod in "${tmppodlist[@]}"; do
        tmppod=$(echo $tmppod | sed -e "s/^\($tmppodname-[a-z0-9]*-[a-z0-9]*\).*$/\1/")
        kubectl logs "$tmppod" -n $tmpnamespace --previous --tail=$tail
        break
    done
}

function kafkafetch() {
    if [ $# -ge 1 ]; then
        env=$1
    else 
        env="dev"
    fi

    # Check environment to set username and password
    if [ $env = "dev" ]; then
        user=$TEST_KAFKA_GCP_USERNAME
        pass=$(security find-generic-password -a "$USER" -s "test_kafka_aiven_password" -w)
    elif [ $env = "stage" ]; then
        user=$STAGE_KAFKA_GCP_USERNAME
        pass=$(security find-generic-password -a "$USER" -s "stage_kafka_aiven_password" -w)
    elif [ $env = "prod" ]; then
        user=$PROD_KAFKA_GCP_USERNAME
        pass=$(security find-generic-password -a "$USER" -s "prod_kafka_aiven_password" -w)
    else
        echo "Please provide a valid environment as the first argument"
        return
    fi

    #Path to fetch script
    ~/Documents/tv2/ai-tools-docker-compose/kafka/fetch.sh -p "$pass" -u "$user" "${@:2}"
}

#######################################
###     Bindings 
#######################################

# bind UP and DOWN arrow keys to history search
zmodload zsh/terminfo
bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down
bindkey "^[[1;3C" forward-word
bindkey "^[[1;3D" backward-word

#######################################
###     Environment 
#######################################

export EDITOR="nvim"
export GOPATH=$HOME/go

# Mac specific things
if type brew &>/dev/null; then
  # Configure Completions
  FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"

  # Configure PATH
  export PATH="/usr/local/bin:/Users/mavad725/go/bin:$PATH"

  [[ $commands[kubectl] ]] && source <(kubectl completion zsh)
fi

#######################################
###     MISC 
#######################################

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/mavad725/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/mavad725/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/mavad725/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/mavad725/google-cloud-sdk/completion.zsh.inc'; fi
