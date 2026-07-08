# In dieser Datei werden alle Parameter und benutzer preferenzen und eingaben gespeicher.
config_file="$HOME/.config/mytree/config"

save_value() {
  local key="$1"
  local value="$2"

  mkdir -p "$(dirname "$config_file")"
  touch "$config_file"

  if grep -q "^${key}|" "$config_file"; then
    # Zeile existiert — ersetzen
    sed -i "s|^${key}|.*|${key}|${value}|" "$config_file"
  else
    # Zeile existiert nicht — anhängen
    echo "${key}|${value}" >>"$config_file"
  fi
}

load_value() {
  local key="$1"
  if grep -q "^${key}|" "$config_file"; then
    grep "^${key}|" "$config_file" | cut -d'|' -f2
  fi
}
