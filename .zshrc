# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH

# Theme
ZSH_THEME="robbyrussell"

# Path to your oh-my-zsh installation.
export ZSH="/Users/victorvialard/.oh-my-zsh"
source $ZSH/oh-my-zsh.sh

# You may need to manually set your language environment
export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
export EDITOR='vim'

# Compilation flags
export ARCHFLAGS="-arch x86_64"

plugins=(
        fzf
        aws
        brew
        docker
        fzf
        gcloud
        tmux
        git
        kubectl
        cargo
        pyenv
)

# Loading fzf completion
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Emacs
export EHSELL=/bin/zsh

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" 
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

export PATH=$PATH
export PATH=$PATH:/usr/local/go/bin

export XDG_CURRENT_DESKTOP=GNOME 

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin

# Private configuration
if [ -f ~/.zshrc.private ]; then
    source ~/.zshrc.private
else
    print "WARNING: private config .private.zshrc not found"
fi

[ -f "/home/sheepsody/.ghcup/env" ] && source "/home/sheepsody/.ghcup/env" # ghcup-env

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/victorvialard/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/victorvialard/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/victorvialard/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/victorvialard/google-cloud-sdk/completion.zsh.inc'; fi
