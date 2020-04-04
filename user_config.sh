# user_config.sh contains any user specific settings that need to be loaded

# load custom scripts
# custom functionality must be stored in this SC_DIR directory
SC_DIR=$HOME/.config/$(whoami)_conf.d/scripts

load_scripts() {
  scripts=($(ls $SC_DIR/*.sh))
  
  for sc in "${scripts[@]}"; do
    source $sc
  done
}

# caffeine prevents the display from switching off
# due to inactivity. Checks for any existing instances
# of `caffeinate` and starts one if none is running.
caffeine() {
  arr=($(pgrep caffeinate));
  if [[ ${#arr} == "0" ]]; then 
    caffeinate -d &
    clear
  fi
}

load_scripts
caffeine

# custom functionality

# cleanup cleans up temporary files from the
# home directory.
cleanup() {
  toDel=(
    ~/.pylint.d
    ~/.node_repl_history
    ~/.DS_Store
  )

  for f in "${toDel[@]}"; do
    if [[ -f "$f" || -d "$f" ]]; then
      rm -rf $f
      echo "Deleted $f"
    fi
  done
  #rm -rf $toDel;
}

# aliases
alias d="docker-compose"
alias bs="brew search"
alias bi="brew install"
alias bci="brew cask install"

# sensitive contains some private aliases, such as ssh shortcuts
sensitive=sensitive_aliases.sh;
[[ -f $sensitive ]] && source $sensitive;

