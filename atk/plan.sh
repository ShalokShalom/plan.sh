pkg_origin=cosmos

pkg_name=atk
pkg_version=2.24.0
_pkg_version=2.24
pkg_description="A library providing a set of interfaces for accessibility"
pkg_upstream_url='https://www.gtk.org/'
pkg_license=('LGPL')
pkg_deps=('glib2')
pkg_build_deps=('gobject-introspection')
pkg_source=("https://ftp.gnome.org/pub/gnome/sources/atk/${_pkg_version}/${pkg_name}-${pkg_version}.tar.xz")
pkg_shasum=('3747a80089dfa3c0bbcf21adfff9968b')

do_build() {
  
  ./configure --prefix=/usr
  make
}

do_package() {
  
  make DESTDIR=${pkg_prefix} install
}
