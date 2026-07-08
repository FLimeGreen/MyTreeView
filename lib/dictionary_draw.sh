start_pos_draw=0
draw_length=20

draw() {
  clear
  echo "─── $(pwd) ───"
  echo "  insgesamt: ${count}"

  # Start und Ende berechnen
  local end=$((start_pos_draw + draw_length))
  if ((end > count)); then
    end=$count
  fi

  for ((i = start_pos_draw; i < end; i++)); do
    IFS='|' read -r rawline name <<<"${lines[$i]}"
    local filetype="${rawline:0:1}"
    local prefix=" "
    if [[ "$filetype" == "d" ]]; then
      prefix="/"
    fi
    if ((i == selected)); then
      echo -e "\e[7m${prefix} ${name}\e[0m"
    else
      echo "${prefix} ${name}"
    fi
  done
  echo ""
}
