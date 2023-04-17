# Path to your oh-my-zsh installation.
export ZSH=/usr/share/oh-my-zsh

ZSH_CACHE_DIR="$HOME/.cache/oh-my-zsh"
if [[ ! -d $ZSH_CACHE_DIR ]]; then
    mkdir $ZSH_CACHE_DIR
fi

source $ZSH/oh-my-zsh.sh
source /usr/share/zinit/zinit.sh

zinit light zdharma-continuum/fast-syntax-highlighting
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-completions

# User configurations
# .bin folder
export PATH=$PATH:$HOME/.bin/cli

# NVM
source /usr/share/nvm/init-nvm.sh

# Starship startup
eval "$(starship init zsh)"

