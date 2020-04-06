# cleanup cleans up temporary files from the
# home directory.
cleanup() {
  toDel=(
    ~/.pylint.d
    ~/.node_repl_history
    ~/.DS_Store
    ~/.lesshst
  );

  for f in "${toDel[@]}"; do
    if [[ -f "$f" || -d "$f" ]]; then
      rm -rf $f;
      [[ -z $quiet ]] && echo "Deleted $f";
    fi
  done
}
