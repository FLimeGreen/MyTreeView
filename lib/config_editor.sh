# Config Editor
# Alle editierbaren Einstellungen mit Name, Wert und Handler-Funktion
declare -a config_keys=(
  "draw_length"
  "isorder"
  "show_single_dot_inventory"
  "show_dobble_dot_inventory"
)
declare -A config_labels=(
  ["draw_length"]="Anzahl angezeigte Zeilen"
  ["isorder"]="Ordner zuerst"
  ["show_single_dot_inventory"]="Zeigt den Ordner /.  an"
  ["show_dobble_dot_inventory"]="Zeigt den Ordner /.. an"
)
declare -A config_handlers=(
  ["draw_length"]="set_draw_length"
  ["isorder"]="set_isorder"
  ["show_single_dot_inventory"]="set_show_single_dot_inventory"
  ["show_dobble_dot_inventory"]="set_show_dobble_dot_inventory"
)

config_selected=0
config_input=""
config_editing=false

draw_config() {
  clear
  echo "─── Config Editor [↑↓/jk navigieren, Enter/l auswählen, ESC zurück] ───"
  echo ""
  for i in "${!config_keys[@]}"; do
    local key="${config_keys[$i]}"
    local label="${config_labels[$key]}"
    local value=$(load_value "${key}" "${!key}") # Wert der Variable mit diesem Namen

    if ((i == config_selected)); then
      if [[ "$config_editing" == true ]]; then
        echo -e "  \e[7m${label}\e[0m  >  ${config_input}_" # Eingabe anzeigen
      else
        echo -e "  \e[7m${label}  =  ${value}\e[0m"
      fi
    else
      echo "  ${label}  =  ${value}"
    fi
  done
  echo ""
}

run_config_editor() {
  config_selected=0
  config_editing=false
  config_input=""
  draw_config

  while true; do
    IFS= read -rsn1 key

    if [[ "$config_editing" == true ]]; then
      if [[ -z $key ]]; then
        config_editor_save_edited_changes # Enter
      else
        case "$key" in
        $'\x7f') config_editor_remove_one_letter ;;   # Backspace
        $'\x0c') config_editor_save_edited_changes ;; # Strg+L
        $'\e') config_editor_edit_abbrechen ;;        # ESC = abbrechen
        *) config_input+="$key" ;;                    # Zeichen anhängen
        esac
      fi
    else
      if [[ -z $key ]]; then
        config_editor_select_to_edit
      elif [[ $key == $'\e' ]]; then
        read -rsn5 -t 0.05 rest
        case "${key}${rest}" in
        $'\e[A') config_editor_move_up ;;
        $'\e[B') config_editor_move_down ;;
        $'\e') return ;; # Leave config Editor
        esac
      else
        case "$key" in
        "k") config_editor_move_up ;;
        "j") config_editor_move_down ;;
        "l") config_editor_select_to_edit ;; # l = Editing starten
        esac
      fi
    fi
    draw_config
  done
}

# Handler Funktionen
set_draw_length() {
  local val="$1"
  if [[ "$val" =~ ^[0-9]+$ ]] && ((val > 0)); then
    draw_length="$val"
    save_value "draw_length" "$val"
  else
    echo "Ungültiger Wert: muss eine positive Zahl sein"
    sleep 1
  fi
}

set_isorder() {
  local val="$1"
  if [[ "$val" == "true" || "$val" == "false" ]]; then
    isorder="$val"
    save_value "isorder" "$val"
    order_dir
  else
    echo "Ungültiger Wert: true oder false"
    sleep 1
  fi
}

set_show_single_dot_inventory() {
  local val="$1"
  if [[ "$val" == "true" || "$val" == "false" ]]; then
    show_single_dot_inventory="$val"
    save_value "show_single_dot_inventory" "$val"
    load_dir
  else
    echo "Ungültiger Wert: true oder false"
    sleep 1
  fi
}

set_show_dobble_dot_inventory() {
  local val="$1"
  if [[ "$val" == "true" || "$val" == "false" ]]; then
    show_dobble_dot_inventory="$val"
    save_value "show_dobble_dot_inventory" "$val"
    load_dir
  else
    echo "Ungültiger Wert: true oder false"
    sleep 1
  fi
}
