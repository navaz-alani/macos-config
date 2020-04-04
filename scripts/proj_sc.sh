#! /bin/bash

# proj locates and navigates to a personal project directory
proj() {
  if [[ -z $1 || $1 == "-h" || $1 == "-help" ]]; then
    echo "proj locates and navigates to a personal project directory";
    echo "usage: proj <project name>";
    return 0;
  fi

  # search go projects
  go_proj_src=~/go/src/github.com/navaz-alani
  go_proj=$go_proj_src/$1
  if [[ -d $go_proj ]]; then
    cd $go_proj;
    echo "Switched to Golang Project '$1'";
    return;
  fi

  # search github projects
  git_proj_src=~/github.com/navaz-alani
  git_proj=$git_proj_src/$1
  if [[ -d $git_proj ]]; then
    cd $git_proj;
    echo "Switched to GitHub Project '$1'";
    return;
  fi

  echo "error: project not found";
  return 1;
}

