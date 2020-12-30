# gpg tty variable - essential for gpg to work!!!
GPG_TTY=$(tty)

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.config/zsh/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Path to oh-my-zsh installation
export ZSH="/Users/$(whoami)/.config/zsh/.oh-my-zsh"
# ZSH theme
ZSH_THEME="powerlevel10k/powerlevel10k"
# To customize prompt, run `p10k configure` or edit ~/.config/zsh/.p10k.zsh.
[[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh

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
