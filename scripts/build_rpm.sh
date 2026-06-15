#!/bin/bash
set -e

VERSION="1.0.0"
RPM_DIR="$(pwd)/rpmbuild"

echo "Building Nalculator for RPM packaging..."
# Patch CSS path for system installation
sed -i 's|"src/gui/style.css"|"/usr/share/nalculator/style.css"|g' src/main.npk
/home/randy/Workspace/REPOS/nitpick-build/build/npkbld build nalculator
# Revert CSS path
sed -i 's|"/usr/share/nalculator/style.css"|"src/gui/style.css"|g' src/main.npk

echo "Preparing RPM build directory structure..."
mkdir -p "$RPM_DIR"/{BUILD,RPMS,SOURCES,SPECS,SRPMS}
mkdir -p "$RPM_DIR/BUILD/nalculator-$VERSION"

# Copy sources to BUILD
cp .nitpick_make/build/nalculator "$RPM_DIR/BUILD/nalculator-$VERSION/"
cp src/gui/style.css "$RPM_DIR/BUILD/nalculator-$VERSION/"
cp assets/nalculator.desktop "$RPM_DIR/BUILD/nalculator-$VERSION/"
cp assets/nalculator.svg "$RPM_DIR/BUILD/nalculator-$VERSION/"

# Create SPEC file
cat << EOF > "$RPM_DIR/SPECS/nalculator.spec"
Name:           nalculator
Version:        $VERSION
Release:        1%{?dist}
Summary:        A fast, native calculator powered by GTK4 and Nitpick

License:        GPL
URL:            https://example.com/nalculator
BuildArch:      x86_64
Requires:       gtk4

%description
Nalculator is a lightning-fast, minimalist calculator built from scratch using the Nitpick programming language and GTK4.

%prep
# Nothing to prep, we copy built files manually.

%build
# Nothing to build, binaries are already built by npkbld.

%install
rm -rf \$RPM_BUILD_ROOT
mkdir -p \$RPM_BUILD_ROOT/usr/bin
mkdir -p \$RPM_BUILD_ROOT/usr/share/nalculator
mkdir -p \$RPM_BUILD_ROOT/usr/share/applications
mkdir -p \$RPM_BUILD_ROOT/usr/share/icons/hicolor/scalable/apps

cp %{_builddir}/nalculator-%{version}/nalculator \$RPM_BUILD_ROOT/usr/bin/
cp %{_builddir}/nalculator-%{version}/style.css \$RPM_BUILD_ROOT/usr/share/nalculator/
cp %{_builddir}/nalculator-%{version}/nalculator.desktop \$RPM_BUILD_ROOT/usr/share/applications/
cp %{_builddir}/nalculator-%{version}/nalculator.svg \$RPM_BUILD_ROOT/usr/share/icons/hicolor/scalable/apps/

%files
/usr/bin/nalculator
/usr/share/nalculator/style.css
/usr/share/applications/nalculator.desktop
/usr/share/icons/hicolor/scalable/apps/nalculator.svg

%changelog
* Mon Jun 15 2026 Randy <randy@example.com> - $VERSION-1
- Initial RPM release
EOF

echo "Building RPM package..."
rpmbuild --define "_topdir $RPM_DIR" -bb "$RPM_DIR/SPECS/nalculator.spec"

echo "Success! Packages located in $RPM_DIR/RPMS/x86_64/"
