# Liest Dateien/Verzeichnisse aus `ls -la` in ein Array
# und lässt den User mit den Pfeiltasten durch die Zeilen navigieren

declare -a lines
selected=0

load_dir() {
  lines=()
  # ls -la einlesen (ohne Headerzeile "total N")
  SkipFirstLine=true
  while IFS= read -r line; do
    if [[ $SkipFirstLine == true ]]; then
      SkipFirstLine=false
    else
      if [[ "$line" =~ [A-Za-z]{3}\ +[0-9]+\ [0-9]{2}:[0-9]{2}\ (.*) ]]; then
        name="${BASH_REMATCH[1]}"
        if [[ $name != ".." ]]; then
          lines+=("$line|$name")
        fi
      fi
    fi
  done < <(LC_ALL=C ls -la)

  order_dir

  # Reset Selection
  selected=0
  start_pos_draw=0
  count=${#lines[@]}
}

load_dir
draw

while true; do
  IFS= read -rsn1 key
  if [[ $key == $'\e' ]]; then # Pfeiltasten Steuerung und ESC
    read -rsn2 -t 0.05 rest
    case "$rest" in
    '[A') move_up ;;
    '[B') move_down ;;
    '[C') dic_down ;;
    '[D') dic_up ;;
    '')
      echo -e "\nBeendet."
      break
      ;;
    esac
  else
    case $key in                                 # Tasten Funktionen
    "k") move_up ;;                              # Pfeil hoch
    "j") move_down ;;                            # Pfeil runter
    "l") dic_down ;;                             # Pfeil rechts
    "h") dic_up ;;                               # Pfeil links
    "n") nvim ;;                                 # Neovim
    "s") search_dic ;;                           # Search dic
    "S") search_all ;;                           # Search dic and fils
    "o") toggle_order_dir ;;                     # Order sortieren
    "r") run_dir ;;                              # führt dic run befehl aus
    $'\x12') set_new_dir_run_command "$(pwd)" ;; # Strg+R - Edit dic run

    esac
  fi

  draw
done
