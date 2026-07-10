config_editor_move_up() {
  ((config_selected > 0)) && ((config_selected--))
}

config_editor_move_down() {
  ((config_selected < ${#config_keys[@]} - 1)) && ((config_selected++))
}

config_editor_select_to_edit() {
  config_editing=true
  local cfg_key="${config_keys[$config_selected]}"
  config_input=$(load_value "${cfg_key}" "${!cfg_key}") # aktuellen Wert als Startwert
}
