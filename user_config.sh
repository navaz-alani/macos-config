# user_config.sh contains any user specific settings that need to be loaded
# flag to supress output
quiet=

# load custom scripts
# custom functionality must be stored in this SC_DIR directory
CONF_DIR="${HOME}/.config/$(whoami)_conf.d"
SC_DIR="${CONF_DIR}/scripts"
# todo: migrate programs from functions to scripts...
PATH=$PATH:/Users/navaz/.config/navaz_conf.d/bin

load_scripts() {
  for sc in $(ls $SC_DIR/*.sh); do
    source $sc;
    [[ -z $quiet ]] && echo "> Loaded $sc";
  done
}

# caffeine prevents the display from switching off
# due to inactivity. Checks for any existing instances
# of `caffeinate` and starts one if none is running.
caffeine() {
  arr=($(pgrep caffeinate));
  if [[ ${#arr} -eq 0 ]]; then 
    caffeinate -d &;
    disown;
    [[ -z $quiet ]] && echo "> Caffeinated system";
  fi
}

# load_sensitive_aliases loads some private aliases, 
# such as ssh shortcuts
load_sensitive_aliases() {
  sensitive=$CONF_DIR/sensitive_aliases.sh
  if [[ -f $sensitive ]]; then
    source $sensitive;
    [[ -z $quiet ]] && echo "> Loaded sensitive aliases";
  fi
}

[[ -z $quiet ]] && echo "Loading user configuration...";
load_scripts;
load_sensitive_aliases;
caffeine;
cleanup;
clear;
USER_CONF_LOADED="true";

# conventient aliases
## docker
alias d="docker"
alias dc="docker-compose"
## brew
alias bs="brew search"
alias bi="brew install"
alias bci="brew cask install"
## default editor
alias vi=nvim
alias vim=nvim
## wget
# redirect config file to keep home dir clean
alias wget="wget --hsts-file=~/.config/wget/.wget-hsts"

# CONFIG
EDITOR=nvim

