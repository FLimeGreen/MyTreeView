isorder=false

order_dir() {
  if [[ "$isorder" == true ]]; then
    local -a dirlist
    local -a itemlist

    for item in "${lines[@]}"; do         # [@] für Array-Iteration
      if [[ "${item:0:1}" == "d" ]]; then # $ und Anführungszeichen
        dirlist+=("$item")                # Klammern beim Anhängen
      else
        itemlist+=("$item")
      fi
    done

    lines=("${dirlist[@]}" "${itemlist[@]}") # Arrays zusammenfügen
  fi
}

toggle_order_dir() {
  if [[ "$isorder" == true ]]; then
    isorder=false
  else
    isorder=true
  fi

  load_dir # Aktuallisiere ansicht.
}
