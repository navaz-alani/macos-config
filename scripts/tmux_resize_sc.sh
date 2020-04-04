#! /bin/bash

rsz() {
  if [[ -z $1 || $1 == "-h" || $1 == "-help" || -z $2 ]]; then
    echo "rsz resizes the current tmux pane.";
    echo "usage: rsz <amt> <dir>";
    [[ -z $1 || -z $2 ]] && return 1;
    return 0;
  fi

  for i in {1..$1}; do
    tmux resize-pane -$2;
  done
}

