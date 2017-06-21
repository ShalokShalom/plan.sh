pkg_origin=cosmos

pkgbase=gtkmm
pkg_name=('gtkmm' 'gtkmm-docs')
pkg_version=2.24.5
_pkg_version=2.24
pkg_upstream_url="http://www.gtkmm.org/"
pkg_build_deps=('gtk2' 'pangomm' 'atkmm' 'glibmm-docs')
pkg_license=('LGPL')
pkg_source=("https://ftp.gnome.org/pub/GNOME/sources/gtkmm/${_pkg_version}/${pkgbase}-${pkg_version}.tar.xz")
pkg_shasum=('6c59ae8bbff48fad9132f23af347acf1')

do_build() {

  ./configure --prefix=/usr
  make
}

package_gtkmm() {
  pkg_description="C++ bindings for gtk2"
  pkg_deps=('gtk2' 'pangomm' 'atkmm')

  sed -i -e 's|^doc_subdirs|#doc_subdirs|' Makefile

  make DESTDIR=${pkg_prefix} install
}

package_gtkmm-docs() {
  pkg_description="Developer documentation for gtkmm v2"

  make -C docs DESTDIR=${pkg_prefix} install
}
