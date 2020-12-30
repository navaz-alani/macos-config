# user_config.sh contains any user specific settings that need to be loaded

# flag to supress output
quiet=

CONF_DIR="${HOME}/.config/$(whoami)_conf.d"
export CONF_DIR # child processes could need this...
# scripts dir - bash functions (to be sourced)
USER_SCRIPTS_DIR="${CONF_DIR}/scripts"
# configs dir - configurations (to be sourced)
USER_CONFIGS_DIR="${CONF_DIR}/configs"
# user executables - shell programs, binaries (any executables needed in path)
USER_BIN_DIR="${CONF_DIR}/bin"
# append to path
PATH="$PATH:${USER_BIN_DIR}"

# single_source sources a single file - ${1} and echoes ${2} if `quiet` is not
# set.
single_source() {
  if [[ -f ${1} ]]; then
    source ${1};
    [[ -z $quiet ]] && echo "> ${2}";
  fi
}

# bulk_source sources the files in directory ${1} which have the extension ${2}
# and echoes progress if `quiet` is not set.
bulk_source() {
  [[ -z ${quiet} ]] && echo "> Bulk loading ${1}/*${2}";
  for f in $(ls ${1}/*${2}); do
    source ${f};
    [[ -z ${quiet} ]] && echo "> Loaded ${f}";
  done
  [[ -z ${quiet} ]] && echo "> Bulk load complete\n";
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

[[ -z $quiet ]] && echo "Loading user configuration...";

# source user scripts
bulk_source   ${USER_SCRIPTS_DIR} ".sh"
# source user configs
bulk_source   ${USER_CONFIGS_DIR} ".conf.sh"
# source sensitive aliases
single_source "${CONF_DIR}/sensitive_aliases.sh" "Loaded sensitive aliases."

caffeine; # caffeinate system if not already done
cleanup;  # script to remove unwanted files from $HOME
clear;
USER_CONF_LOADED="true";
