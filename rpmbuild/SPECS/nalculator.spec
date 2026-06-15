Name:           nalculator
Version:        1.0.0
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
rm -rf $RPM_BUILD_ROOT
mkdir -p $RPM_BUILD_ROOT/usr/bin
mkdir -p $RPM_BUILD_ROOT/usr/share/nalculator
mkdir -p $RPM_BUILD_ROOT/usr/share/applications
mkdir -p $RPM_BUILD_ROOT/usr/share/icons/hicolor/scalable/apps

cp %{_builddir}/nalculator-%{version}/nalculator $RPM_BUILD_ROOT/usr/bin/
cp %{_builddir}/nalculator-%{version}/style.css $RPM_BUILD_ROOT/usr/share/nalculator/
cp %{_builddir}/nalculator-%{version}/nalculator.desktop $RPM_BUILD_ROOT/usr/share/applications/
cp %{_builddir}/nalculator-%{version}/nalculator.svg $RPM_BUILD_ROOT/usr/share/icons/hicolor/scalable/apps/

%files
/usr/bin/nalculator
/usr/share/nalculator/style.css
/usr/share/applications/nalculator.desktop
/usr/share/icons/hicolor/scalable/apps/nalculator.svg

%changelog
* Mon Jun 15 2026 Randy <randy@example.com> - 1.0.0-1
- Initial RPM release
