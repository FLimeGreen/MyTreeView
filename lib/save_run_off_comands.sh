run_command() {
  local cmd="$1"
  local saved_tty
  saved_tty=$(stty -g)
  bash -c "$cmd"
  stty "$saved_tty"
}
