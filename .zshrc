# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:/opt/homebrew/bin/:$PATH

# Theme
ZSH_THEME="robbyrussell"

# Path to your oh-my-zsh installation.
export ZSH="/Users/sheepsody/.oh-my-zsh"
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
        gcloud
        tmux
        git
        kubectl
        cargo
        pyenv
	    conda
)

# Loading fzf completion
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_OPTS=" \
    --color=bg+:#ccd0da,bg:#eff1f5,spinner:#dc8a78,hl:#d20f39 \
    --color=fg:#4c4f69,header:#d20f39,info:#8839ef,pointer:#dc8a78 \
    --color=marker:#dc8a78,fg+:#4c4f69,prompt:#8839ef,hl+:#d20f39"

# Emacs
export EHSELL=/bin/zsh

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" 
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

export PATH=$PATH
export PATH=$PATH:/usr/local/go/bin

export XDG_CURRENT_DESKTOP=GNOME 

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
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"



# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/opt/homebrew/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/opt/homebrew/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/opt/homebrew/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/opt/homebrew/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

autoload -Uz compinit && compinit

# Rust
export PATH=$PATH:$HOME/.cargo/bin
