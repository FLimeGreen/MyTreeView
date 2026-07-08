move_up() {
  ((selected > 0)) && ((selected--))

  if ((selected < start_pos_draw)); then
    start_pos_draw=$((selected))
  fi
}

move_down() {
  ((selected < count - 1)) && ((selected++))

  if ((selected >= start_pos_draw + draw_length)); then
    start_pos_draw=$((selected - draw_length + 1))
  fi
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
