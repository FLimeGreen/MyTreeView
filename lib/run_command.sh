declare -A dictionary_run_commands

# Save and load
save_dic_run_commands() {
  for dir in "${!dictionary_run_commands[@]}"; do
    save_value "run_dic_cmd:${dir}" "${dictionary_run_commands[$dir]}"
  done
}

delete_dic_run_value() {
  local key="$1"
  sed -i "/^${key}|/d" "$config_file" # Zeile mit diesem Key löschen
}

load_dic_run_commands() {
  while IFS='|' read -r key value; do
    if [[ "$key" == run_dic_cmd:* ]]; then
      dir="${key#run_dic_cmd:}" # Prefix entfernen
      dictionary_run_commands["$dir"]="$value"
    fi
  done <"$config_file"
}

# Aktionen
load_dic_run_commands

run_dir() {
  local pwd_now
  pwd_now=$(pwd)
  if [[ -n "${dictionary_run_commands[$pwd_now]+x}" ]]; then # key existiert?
    echo "run: ${dictionary_run_commands[$pwd_now]}"
    bash -c "${dictionary_run_commands[$pwd_now]}"
  else
    set_new_dir_run_command "$pwd_now"
  fi
}

set_new_dir_run_command() {
  local dir="$1"
  local cmd
  read -rp "Befehl für $dir: " cmd
  if [[ -z "${cmd// /}" ]]; then
    if [[ -n "${dictionary_run_commands[$dir]+x}" ]]; then # $ und +x für Key-Existenz
      unset "dictionary_run_commands[$dir]"                # Key wirklich löschen
      delete_dic_run_value "run_cmd:${dir}"                # aus config entfernen
      echo "Befehl gelöscht"
    else
      echo "Kein Befehl eingegeben"
    fi
  else
    dictionary_run_commands["$dir"]="$cmd"
    save_dic_run_commands
  fi
}
