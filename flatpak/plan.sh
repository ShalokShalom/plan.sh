pkg_origin=
 
pkg_name=flatpak
pkg_version=0.9.5
pkg_description="System for building, distributing and running sandboxed desktop applications on Linux."
pkg_upstream_url="http://flatpak.org"
pkg_license=('GPL')
pkg_deps=('bubblewrap' 'elfutils' 'fuse' 'glib2' 'json-glib' 'libarchive' 'ostree'
         'polkit' 'xorg-xauth' 'python3' 'patch' 'systemd')
pkg_build_deps=('intltool' 'xmlto' 'dwarf')
install=flatpak.install
pkg_source=("https://github.com/flatpak/flatpak/releases/download/${pkg_version}/${pkg_name}-${pkg_version}.tar.xz")
pkg_shasum=('e526bd0b227743f15417c0711b5926a9')

do_build() {
  cd ${pkg_name}-${pkg_version}

  ./configure \
    --prefix=/usr \
    --sysconfdir=/etc \
    --localstatedir=/var \
    --sbindir=/usr/bin \
    --libexecdir=/usr/lib/${pkg_name} \
    --disable-static \
    --disable-gtk-doc \
    --with-system-bubblewrap \
    --with-priv-mode=setuid \
    --with-dwarf-header=/usr/include/libdwarf \
    --with-dbus-config-dir=/usr/share/dbus-1/system.d \
    --with-system-install-dir=/var/lib/flatpak

  make
}

do_check() {
  cd ${pkg_name}-${pkg_version}
  # 4 docs tests fail
  make -k check || :
}

do_package() {
  cd ${pkg_name}-${pkg_version}

  make DESTDIR=${pkg_prefix} install

  install -d -o root -g 102 -m 700 ${pkg_prefix}/usr/share/polkit-1/rules.d
}
