pkg_origin=cosmos

pkgbase=glibmm
pkg_name=('glibmm' 'glibmm-docs')
pkg_version=2.50.1
_pkg_version=2.50
pkg_upstream_url="http://gtkmm.sourceforge.net/"
pkg_license=('LGPL')
pkg_build_deps=('glib2' 'libsigc++' 'pkgconfig')
pkg_source=("https://ftp.gnome.org/pub/GNOME/sources/${pkg_name}/${_pkg_version}/${pkg_name}-${pkg_version}.tar.xz")
pkg_shasum=('a5b915dc42fc62983fa78ca8486f4391')

do_build() {
  
  ./configure --prefix=/usr
  make
}

package_glibmm() {
  pkg_description="Glib-- (glibmm) is a C++ interface for glib"
  pkg_deps=('glib2' 'libsigc++')
  
  sed -i -e 's|^doc_subdirs|#doc_subdirs|' Makefile
  make DESTDIR=${pkg_prefix} install
}

package_glibmm-docs() {
  pkg_description="Developer documentation for glibmm"
  
  make DESTDIR=${pkg_prefix} install
}
