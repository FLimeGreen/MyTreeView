#!/bin/bash
# $1 = "dirs" oder "all"
# $2 = startverzeichnis

mode="${1:-all}"
startdir="${2:-.}"

if [[ "$mode" == "dirs" ]]; then
  # Nur Ordner
  result=$(find "$startdir" -mindepth 1 -type d 2>/dev/null | fzf --prompt="Ordner suchen: ")
else
  # Ordner und Dateien
  result=$(find "$startdir" -mindepth 1 2>/dev/null | fzf --prompt="Suchen: ")
fi

# Ergebnis ausgeben damit das Hauptprogramm es lesen kann
echo "$result"
