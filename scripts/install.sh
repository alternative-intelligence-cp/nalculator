#!/bin/bash
set -e

echo "Building Nalculator..."
# Patch CSS path for system installation
sed -i 's|"src/gui/style.css"|"/usr/share/nalculator/style.css"|g' src/main.npk

/home/randy/Workspace/REPOS/nitpick-build/build/npkbld build nalculator

# Revert CSS path
sed -i 's|"/usr/share/nalculator/style.css"|"src/gui/style.css"|g' src/main.npk

echo "Installing Nalculator..."
sudo mkdir -p /usr/local/bin
sudo mkdir -p /usr/share/nalculator
sudo mkdir -p /usr/share/applications
sudo mkdir -p /usr/share/icons/hicolor/scalable/apps

sudo cp .nitpick_make/build/nalculator /usr/local/bin/
sudo cp src/gui/style.css /usr/share/nalculator/
sudo cp assets/nalculator.desktop /usr/share/applications/
sudo cp assets/nalculator.svg /usr/share/icons/hicolor/scalable/apps/

echo "Updating desktop database..."
sudo update-desktop-database /usr/share/applications || true
sudo gtk-update-icon-cache /usr/share/icons/hicolor || true

echo "Installation complete! You can now run 'nalculator' from the terminal or launcher."
