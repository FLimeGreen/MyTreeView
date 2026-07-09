#!/bin/bash
# build.sh

echo "#!/bin/bash" >mytree.sh # Shebang einmal schreiben

cat lib/config.sh >>mytree.sh # config datei als erstes laden

for file in lib/*.sh; do
  [[ "$file" == "lib/config.sh" ]] && continue
  cat "$file" >>mytree.sh
done

cat Main.sh >>mytree.sh

chmod +x mytree.sh
