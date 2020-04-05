git_rename() {
  if [[ $1 == "-h" || $1 == "--help" ]]; then
    echo "git_rename renames a git branch (loacal/remote)"
    echo "Usage: git_rename <option> <old_branch_name> <new_branch_name>"
    echo "Options:"
    echo "  -l or --local     Rename just locally (not committed yet)"
    echo "  -r or --remote    Rename both locally and remote"
    return 0
  elif [[ ( $1 != "-l" && $1 != "--local" ) && ( $1 != "-r" && $1 != "--remote" ) ]]; then
    echo "error: unspecied protocol; -l (--local) or -r (--remote)"
    return 1
  elif [[ -z $2 ]]; then
    echo "error: old branch name unspecified"
    return 1
  elif [[ -z $3 ]]; then
    echo "error: new branch name unspecified"
    return 1
  fi
  
  git checkout $2
  git branch -m $3
  
  if [[ $1 == "-r" || $1 == "--remote" ]]; then
    git push origin -u $3
    git push origin --delete $2
  fi
}