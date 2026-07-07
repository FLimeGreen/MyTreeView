#!/bin/bash
# build.sh

echo "#!/bin/bash" >mytree.sh # Shebang einmal schreiben

cat lib/fzf_search.sh >>mytree.sh
cat Main.sh >>mytree.sh

chmod +x mytree.sh
