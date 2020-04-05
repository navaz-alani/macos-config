# user_config.sh contains any user specific settings that need to be loaded
quiet=

# load custom scripts
# custom functionality must be stored in this SC_DIR directory
CONF_DIR=$HOME/.config/$(whoami)_conf.d
SC_DIR=$CONF_DIR/scripts

load_scripts() {
  scripts=($(ls $SC_DIR/*.sh))
  for sc in "${scripts[@]}"; do
    source $sc;
    [[ -z $quiet ]] && echo "> Loaded $sc";
  done
}

# caffeine prevents the display from switching off
# due to inactivity. Checks for any existing instances
# of `caffeinate` and starts one if none is running.
caffeine() {
  arr=($(pgrep caffeinate));
  if [[ ${#arr} == "0" ]]; then 
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

# conventient aliases
alias d="docker"
alias dc="docker-compose"
alias bs="brew search"
alias bi="brew install"
alias bci="brew cask install"
