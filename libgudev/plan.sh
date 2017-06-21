pkg_origin=cosmos

pkg_name=libgudev
pkg_version=231
pkg_description="UDev GObject bindings"
pkg_license=('LGPL')
pkg_upstream_url="https://git.gnome.org/browse/libgudev"
pkg_deps=('systemd' 'glib2')
pkg_build_deps=('gobject-introspection')
pkg_source=("https://ftp.gnome.org/pub/gnome/sources/libgudev/${pkg_version}/${pkg_name}-${pkg_version}.tar.xz")
#pkg_source=("https://github.com/systemd-devs/libgudev/archive/$pkg_name-$pkg_version.tar.gz")
pkg_shasum=('916c10c51ec61131e244c3936bbb2e0c')

do_build() {
  cd ${pkg_name}-${pkg_version}

  ./configure --prefix=/usr --disable-umockdev
  make
}

do_check() {
  cd ${pkg_name}-${pkg_version}

  make check
}

do_package() {
  cd ${pkg_name}-${pkg_version}

  make DESTDIR=${pkg_prefix} install
}
