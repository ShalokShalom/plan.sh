pkg_origin=cosmos

pkg_name=pkg-config
pkg_version=0.29.2
pkg_description="A system for managing library compile/link flags"
pkg_upstream_url="https://pkgconfig.freedesktop.org/wiki/"
pkg_license=('GPL')
pkg_deps=('glibc' 'glib2')
pkg_source=("https://pkg-config.freedesktop.org/releases/${pkg_name}-${pkg_version}.tar.gz")
pkg_shasum=('f6e931e319531b736fadc017f470e68a')

do_build() {
  cd ${pkg_name}-${pkg_version}

  ./configure --prefix=/usr
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
