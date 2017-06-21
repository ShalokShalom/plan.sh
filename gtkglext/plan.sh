pkg_origin=cosmos
# $Id: PKGBUILD 78325 2010-04-20 22:14:28Z ibiru $
# Maintainer: damir <damir@archlinux.org>
# Contributor: Ben <ben@benmazer.net>

pkg_name=gtkglext
pkg_version=1.2.0
pkg_description="opengl extensions for gtk2"
pkg_upstream_url="http://gtkglext.sourceforge.net/"
pkg_license=('LGPL')
pkg_deps=('gtk2' 'mesa' 'libxmu')
pkg_build_deps=('gcc')
pkg_source=("http://downloads.sourceforge.net/sourceforge/gtkglext/${pkg_name}-${pkg_version}.tar.bz2"
	gtk2.20.patch)
pkg_shasum=('ed7ba24ce06a8630c07f2d0ee5f04ab4'
         'e5a87ec3f2d0e616c6f32f90c3f7237f')

do_build() {
  patch -Np1 -i ${CACHE_PATH}/gtk2.20.patch
  sed '/AC_PATH_XTRA/d' -i configure.in
  autoreconf --force --install
  ./configure -prefix=/usr --disable-static
  make
}

do_package() {
  make DESTDIR=${pkg_prefix} install
}
