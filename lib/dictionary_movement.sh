move_up() {
  ((selected > 0)) && ((selected--))
}

move_down() {
  ((selected < count - 1)) && ((selected++))
}

dic_up() {
  cd ..
  load_dir
}

dic_down() {
  IFS='|' read -r rawline name <<<"${lines[$selected]}"
  if [[ "${rawline:0:1}" == "d" ]]; then
    cd "$name"
    load_dir
  fi
}
