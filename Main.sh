#!/bin/bash

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
        lines+=("$line|$name")
      fi
    fi
  done < <(LC_ALL=C ls -la)

  # Reset Selection
  selected=0
  count=${#lines[@]}
}

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

draw() {
  clear
  echo "─── $(pwd) ───"
  echo "  insgesamt: ${count}"
  for i in "${!lines[@]}"; do
    IFS='|' read -r rawline name <<<"${lines[$i]}"
    filetype="${rawline:0:1}"
    prefix=" "
    if [[ "$filetype" == "d" ]]; then
      prefix="/"
    fi
    if [ "$i" -eq "$selected" ]; then
      echo -e "\e[7m${prefix} ${name}\e[0m"
    else
      echo "${prefix} ${name}"
    fi
  done
  echo ""
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
    case $key in      # Tasten Funktionen
    "k") move_up ;;   # Pfeil hoch
    "j") move_down ;; # Pfeil runter
    "l") dic_down ;;  # Pfeil rechts
    "h") dic_up ;;    # Pfeil links
    "n") nvim ;;      # Neovim

    esac
  fi

  draw
done
