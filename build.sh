#!/bin/bash
# build.sh

echo "#!/bin/bash" >mytree.sh # Shebang einmal schreiben

cat lib/config.sh >>mytree.sh # config datei als erstes laden

cat lib/fzf_search.sh >>mytree.sh

cat lib/dictionary_movement.sh >>mytree.sh
cat lib/dictionary_order.sh >>mytree.sh
cat lib/dictionary_draw.sh >>mytree.sh

cat lib/run_command.sh >>mytree.sh
cat lib/save_run_off_comands.sh >>mytree.sh

cat Main.sh >>mytree.sh

chmod +x mytree.sh
