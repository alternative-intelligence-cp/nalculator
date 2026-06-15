#!/bin/bash
set -e

VERSION="1.0.0"
ARCH="amd64"
PKG_NAME="nalculator_${VERSION}_${ARCH}"

echo "Building Nalculator for Debian packaging..."
# Patch CSS path for system installation
sed -i 's|"src/gui/style.css"|"/usr/share/nalculator/style.css"|g' src/main.npk
/home/randy/Workspace/REPOS/nitpick-build/build/npkbld build nalculator
# Revert CSS path
sed -i 's|"/usr/share/nalculator/style.css"|"src/gui/style.css"|g' src/main.npk

echo "Preparing DEB staging directory..."
mkdir -p "$PKG_NAME/DEBIAN"
mkdir -p "$PKG_NAME/usr/bin"
mkdir -p "$PKG_NAME/usr/share/nalculator"
mkdir -p "$PKG_NAME/usr/share/applications"
mkdir -p "$PKG_NAME/usr/share/icons/hicolor/scalable/apps"

# Copy files
cp .nitpick_make/build/nalculator "$PKG_NAME/usr/bin/"
cp src/gui/style.css "$PKG_NAME/usr/share/nalculator/"
cp assets/nalculator.desktop "$PKG_NAME/usr/share/applications/"
cp assets/nalculator.svg "$PKG_NAME/usr/share/icons/hicolor/scalable/apps/"

# Create control file
cat << EOF > "$PKG_NAME/DEBIAN/control"
Package: nalculator
Version: $VERSION
Section: utils
Priority: optional
Architecture: $ARCH
Depends: libgtk-4-1
Maintainer: Randy <randy@example.com>
Description: A fast, native calculator powered by GTK4 and Nitpick.
 Nalculator is a lightning-fast, minimalist calculator built from scratch
 using the Nitpick programming language and GTK4.
EOF

echo "Building DEB package..."
dpkg-deb --build "$PKG_NAME"

echo "Success! Created $PKG_NAME.deb"
# Clean up staging directory
rm -rf "$PKG_NAME"
