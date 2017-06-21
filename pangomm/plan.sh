pkg_origin=cosmos

pkgbase=pangomm
pkg_name=('pangomm' 'pangomm-docs')
pkg_version=2.40.1
_pkg_version=2.40
pkg_upstream_url="http://gtkmm.sourceforge.net/"
pkg_license=('LGPL')
pkg_build_deps=('pango' 'glibmm' 'glibmm-docs' 'cairomm' 'pkgconfig')
pkg_source=("https://ftp.gnome.org/pub/GNOME/sources/pangomm/${_pkg_version}/${pkg_name}-${pkg_version}.tar.xz")
pkg_shasum=('874eadd9434613dbacf0272c82c3ac23')

do_build() {
  
  ./configure --prefix=/usr
  make
}
package_pangomm() {
  pkg_description="C++ bindings for pango"
  pkg_deps=('pango' 'glibmm' 'cairomm')
  
  sed -i -e 's|^doc_subdirs|#doc_subdirs|' Makefile
  make DESTDIR=${pkg_prefix} install
}

package_pangomm-docs() {
  pkg_description="Developer documentation for pangomm"
  
  make DESTDIR=${pkg_prefix} install
}
