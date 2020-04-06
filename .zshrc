# This file mirrors my system's .zshrc

# Path to oh-my-zsh installation
export ZSH="/Users/$(whoami)/.oh-my-zsh"
# ZSH theme
ZSH_THEME=rkj-repos
# Use case-sensitive completion
CASE_SENSITIVE="true"

plugins=(
   git
   zsh-autosuggestions
   zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# set vim mode on
set -o vi
# read user config
[[ -z $USER_CONF_LOADED || $1 == "-f" ]] &&
source ~/.config/$(whoami)_conf.d/user_config.sh;
