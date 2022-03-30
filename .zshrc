# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/home/sheepsody/.oh-my-zsh"

# Theme
ZSH_THEME="robbyrussell"

source $ZSH/oh-my-zsh.sh

# User configuration

# You may need to manually set your language environment
export LANG=en_US.UTF-8

# Compilation flags
export ARCHFLAGS="-arch x86_64"

plugins=(
        fzf
        git
        kubectl
        cargo
        docker
        zsh-pyenv
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
