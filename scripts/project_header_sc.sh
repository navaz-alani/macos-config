#! /bin/bash

name=$(git config --global user.name)
email=$(git config --global user.email)

help=(
  "header: print a header for source code."
  "        Uses name and contact from global"
  "        Git configuration."
  "usage: header <proj name>"
  "              [copyright start year]"
)

_raw_header() {
  figlet $1

  yr=$(date +"%Y")
  if [[ -z $2 ]]; then
    echo "© $yr $name"
  else
    echo "© $2 - $yr $name"
  fi
  echo "Contact : $email"
}

# header prints a header for a project given the
# project's name and the user's Git name and
# email.
header() {
  if [[ $1 == "-h" || $1 == "-help" ]]; then
    for line in "${help[@]}"; do
      print $line
    done
    return 0
  elif [[ -z $1 ]]; then
    echo "error: expected PROJECT NAME"
    return 1
  elif [[ -z $name || -z $email ]]; then
    echo "error: git config username and email not set!"
    return 1
  fi

  _raw_header $1 $2
}
