#!/bin/bash
#!/bin/bash

# Liest Dateien/Verzeichnisse aus `ls -la` in ein Array
# und lässt den User mit den Pfeiltasten durch die Zeilen navigieren

declare -a lines
selected=0

# ls -la einlesen (ohne Headerzeile "total N")
SkipFirstLine=true
while IFS= read -r line; do
  if [[ $SkipFirstLine == true ]]; then
    SkipFirstLine=false
  else
    lines+=("$line")
  fi
done < <(ls -la)

count=${#lines[@]}

draw() {
  clear
  echo "─── ls -la  [↑↓ navigieren, ESC beenden] ───"
  echo "insgesamt: ${count}"
  for i in "${!lines[@]}"; do
    if [ "$i" -eq "$selected" ]; then
      echo -e "  \e[7m${lines[$i]}\e[0m" # invertiert = markiert
    else
      echo "  ${lines[$i]}"
    fi
  done
  echo ""
}

draw

while true; do
  # Liest bis zu 3 Bytes (für Escape-Sequenzen wie ^[[A)
  IFS= read -rsn1 key
  if [[ $key == $'\e' ]]; then
    read -rsn2 -t 0.05 rest
    case "$rest" in
    '[A') # Pfeil hoch
      ((selected > 0)) && ((selected--))
      ;;
    '[B') # Pfeil runter
      ((selected < count - 1)) && ((selected++))
      ;;
    '') # ESC ohne weitere Bytes → beenden
      echo -e "\nBeendet."
      break
      ;;
    esac
    draw
  fi
done
