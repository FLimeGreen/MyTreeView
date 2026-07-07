# $1 = "dirs" oder "all"
# $2 = startverzeichnis

search_dic() {
  result=$(search "dirs" "$(pwd)")
  if [[ -n "$result" && -d "$result" ]]; then
    cd "$result"
    load_dir
  fi
}

search_all() {
  result=$(search "all" "$(pwd)")
  if [[ -n "$result" ]]; then
    cd "$(dirname "$result")"
    load_dir
  fi
}

search() {
  local mode="${1:-all}"
  local startdir="${2:-.}"
  local result

  if [[ "$mode" == "dirs" ]]; then
    result=$(find "$startdir" -mindepth 1 -type d 2>/dev/null | fzf --prompt="Ordner suchen: " --layout=reverse)
  else
    result=$(find "$startdir" -mindepth 1 2>/dev/null | fzf --prompt="Suchen: " --layout=reverse)
  fi

  echo "$result"
}
