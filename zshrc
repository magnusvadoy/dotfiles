###################################
### ENV 
###################################
export PATH=/home/magnus/bin/:$PATH
source ~/.fdir

###################################
### MISC
###################################
# Fix for WSL
unsetopt BG_NICE

####################################
## ANTIGEN
####################################
source ~/dotfiles/antigen/antigen.zsh

# Load the oh-my-zsh's library.
antigen use oh-my-zsh

# Load bundles
antigen bundle git
antigen bundle heroku
antigen bundle zsh-users/zsh-completions
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle rupa/z

# Apply the theme
# antigen theme clean
antigen theme agnoster/agnoster-zsh-theme

# Apply antigen setup
antigen apply
export DOCKER_HOST=tcp://0.0.0.0:2375
