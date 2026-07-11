#!/bin/bash

set -e

echo "Checking MyTree build"

PAYLOAD="out/mytree"
TEMPLATE="installer/installer.template"
OUT_INSTALLER="out/installer.sh"

if [ ! -f "$PAYLOAD" ]; then
    echo "Missing build: $PAYLOAD"
    echo "Run ./build_mytree.sh first."
    exit 1
fi

echo "MyTree build found."

echo "Building installer"

if [ ! -f "$TEMPLATE" ]; then
    echo "Missing template: $TEMPLATE"
    exit 1
fi

mkdir -p out

# Installer Header + Template
cat > "$OUT_INSTALLER" <<EOF
#!/bin/bash
EOF

cat "$TEMPLATE" >> "$OUT_INSTALLER"

# Payload anhängen
cat "$PAYLOAD" >> "$OUT_INSTALLER"

chmod +x "$OUT_INSTALLER"

echo "Installer built:"
echo "  $OUT_INSTALLER"
