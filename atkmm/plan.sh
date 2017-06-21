pkg_origin=cosmos

pkgbase=atkmm
pkg_name=('atkmm' 'atkmm-docs')
pkg_version=2.24.2
_pkg_version=2.24
pkg_build_deps=('atk' 'glibmm' 'glibmm-docs' 'libsigc++')
pkg_license=('LGPL')
pkg_upstream_url="http://gtkmm.sourceforge.net/"
pkg_source=("http://ftp.gnome.org/pub/GNOME/sources/atkmm/${_pkg_version}/${pkgbase}-${pkg_version}.tar.xz")
pkg_shasum=('d53b60b0f1be597e86070954a49cf0c3')

do_build() {
  
  ./configure --prefix=/usr
  make
}

package_atkmm() {
  pkg_description="C++ bindings for atk"
  pkg_deps=('atk' 'glibmm' 'libsigc++')

  sed -i -e 's|^doc_subdirs|#doc_subdirs|' Makefile
  make DESTDIR=${pkg_prefix} install
}

package_atkmm-docs() {
  pkg_description="Developer documentation for atkmm"
  make -C doc DESTDIR=${pkg_prefix} install
}
