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

draw() {
  clear
  echo "─── $(pwd)  [↑↓ navigieren, → rein, ← raus, ESC beenden] ───"
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
    '[A')
      ((selected > 0)) && ((selected--))
      ;;
    '[B')
      ((selected < count - 1)) && ((selected++))
      ;;
    '[C')
      IFS='|' read -r rawline name <<<"${lines[$selected]}"
      if [[ "${rawline:0:1}" == "d" ]]; then
        cd "$name"
        load_dir
      fi
      ;;
    '[D')
      cd ..
      load_dir
      ;;
    '')
      echo -e "\nBeendet."
      break
      ;;
    esac
  elif [[ $key == "n" ]]; then # Tasten Funktionen
    nvim
  fi

  draw
done
