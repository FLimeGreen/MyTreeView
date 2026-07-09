config_editor_remove_one_letter() {
  config_input="${config_input%?}"
}

config_editor_save_edited_changes() {
  local cfg_key="${config_keys[$config_selected]}"
  local handler="${config_handlers[$cfg_key]}"
  $handler "$config_input" # Handler aufrufen
  config_editing=false
  config_input=""
}

config_editor_edit_abbrechen() {
  config_editing=false
  config_input=""
}
