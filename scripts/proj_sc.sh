proj() {
  if [[ -z $1 || $1 == "-h" || $1 == "-help" ]]; then
    echo "proj locates and navigates to a personal project directory";
    echo "usage: proj <project name>";
  fi

  # search golang projects
  go_proj_src=~/go/src/github.com/navaz-alani
  go_proj=$go_proj_src/$1
  if [[ -d $go_proj ]]; then
    cd $go_proj;
    echo "Switched to Golang Project '$1'";
    return 0;
  fi

  # search projects directory
  proj_src=~/projects
  proj=$proj_src/$1
  if [[ -d $proj ]]; then
    cd $proj;
    echo "Switched to Project '$1'";
    return 0;
  fi

  echo "error: project not found";
  return 1;
}
