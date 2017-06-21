pkg_origin=cosmos

pkgbase=libsigc++
pkg_name=('libsigc++' 'libsigc++-docs')
pkg_version=2.10.0
pkg_license=('LGPL')
pkg_upstream_url="http://libsigc.sourceforge.net/"
pkg_build_deps=('gcc-libs')
pkg_source=("https://ftp.gnome.org/pub/GNOME/sources/libsigc++/2.10/libsigc++-${pkg_version}.tar.xz")
pkg_shasum=('70bcbde2c900e4925d6ef4bf50954195')

do_build() {
  
  ./configure --prefix=/usr 
  make 
}

package_libsigc++() {
  pkg_description="Libsigc++ implements a full callback system for use in widget libraries - V2."
  pkg_deps=('gcc-libs')

  sed -i -e 's/^doc_subdirs/#doc_subdirs/' Makefile 
  make DESTDIR=${pkg_prefix} install 
}

package_libsigc++-docs() {
  pkg_description="Developer documentation for libsigc++"

  make DESTDIR=${pkg_prefix} install 
}

