#!/bin/bash

set -e

echo "Checking MyTree build"

PAYLOAD="out/mytree"
INSTALLER_TEMPLATE="installer/installer.template"
UNINSTALLER_TEMPLATE="installer/uninstaller.template"

OUT_INSTALLER="out/installer.sh"
OUT_UNINSTALLER="out/uninstaller.sh"

mkdir -p out

if [ ! -f "$PAYLOAD" ]; then
    echo "Missing build: $PAYLOAD"
    echo "Run ./build_mytree.sh first."
    exit 1
fi

echo "MyTree build found."


# --------------------
# Build installer
# --------------------

echo "Building installer"

if [ ! -f "$INSTALLER_TEMPLATE" ]; then
    echo "Missing template: $INSTALLER_TEMPLATE"
    exit 1
fi

printf '#!/bin/bash\n' > "$OUT_INSTALLER"

cat "$INSTALLER_TEMPLATE" >> "$OUT_INSTALLER"

# Payload anhängen
cat "$PAYLOAD" >> "$OUT_INSTALLER"

chmod +x "$OUT_INSTALLER"

echo "Installer built:"
echo "  $OUT_INSTALLER"


# --------------------
# Build uninstaller
# --------------------

echo "Building uninstaller"

if [ ! -f "$UNINSTALLER_TEMPLATE" ]; then
    echo "Missing template: $UNINSTALLER_TEMPLATE"
    exit 1
fi

printf '#!/bin/bash\n' > "$OUT_UNINSTALLER"

cat "$UNINSTALLER_TEMPLATE" >> "$OUT_UNINSTALLER"

chmod +x "$OUT_UNINSTALLER"

echo "Uninstaller built:"
echo "  $OUT_UNINSTALLER"


echo
echo "Build complete."
