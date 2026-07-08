declare -A dictionary_run_commands

# Save and load
save_dic_run_commands() {
  for dir in "${!dictionary_run_commands[@]}"; do
    save_value "run_dic_cmd:${dir}" "${dictionary_run_commands[$dir]}"
  done
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
    bash -c "${dictionary_run_commands[$pwd_now]}"
  else
    set_new_dir_run_command "$pwd_now"
  fi
}

set_new_dir_run_command() {
  local dir="$1"
  local cmd
  read -rp "Befehl für $dir: " cmd
  dictionary_run_commands["$dir"]="$cmd"
  save_dic_run_commands
}
