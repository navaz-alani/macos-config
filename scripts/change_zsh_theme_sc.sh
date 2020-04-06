zsh_theme() {
  if [[ -z $1 || $1 == "-h" || $1 == "-help" ]]; then
    echo "usage: zsh_theme <theme name>";
    [[ -z $1 ]] && return 1;
    return 0;
  fi

  theme=$1;
  zshrc=$HOME/.config/zsh/.zshrc;
  [[ ! -f $zshrc ]] && echo "error: $zshrc doesn't exist" && return 1;

  new_zshrc=$(sed "s/ZSH_THEME=.*/ZSH_THEME=$theme/" $zshrc);
  echo "$new_zshrc" > $zshrc;
  echo "$zshrc modified! Please source it.";
}
