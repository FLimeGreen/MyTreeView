#!/bin/bash
# build.sh

# config for output
OUT_DIR="./out"
OUT_FILE="./out/mytree"

# OUT_DIR anlegen, wenn noch nicht da
mkdir -p "$OUT_DIR"

# alte mytree löschen
rm -f "$OUT_FILE"

echo "#!/bin/bash" >"$OUT_FILE" # Shebang einmal schreiben

cat lib/config.sh >>"$OUT_FILE" # config datei als erstes laden

for file in lib/*.sh; do
  [[ "$file" == "lib/config.sh" ]] && continue
  cat "$file" >>"$OUT_FILE"
done

cat Main.sh >>"$OUT_FILE"

chmod +x "$OUT_FILE"

echo "Build erfolgreich: $OUT_FILE"
