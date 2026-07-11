#!/bin/bash

echo "Building MyTree"
./build.sh

echo "Building installer"

OUT_INSTALLER="out/installer.sh"

# Create installer
cat installer/installer.stub >"$OUT_INSTALLER"
echo >>"$OUT_INSTALLER"
cat out/mytree >>"$OUT_INSTALLER"

chmod +x "$OUT_INSTALLER"

echo "installer build."
