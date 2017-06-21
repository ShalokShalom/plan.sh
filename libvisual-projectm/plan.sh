pkg_origin=cosmos
# $Id: PKGBUILD 61635 2009-12-20 18:28:33Z andrea $
# Contributor: Alexander Baldeck <alexander@archlinux.org>

pkg_name=libvisual-projectm
pkg_version=2.0.1
pkg_description="ProjectM XMMS plugin"
pkg_upstream_url="http://projectm.sourceforge.net/"
pkg_license=('GPL')
pkg_deps=('projectm>=2.0.1' 'libvisual' 'sdl')
pkg_build_deps=('pkgconfig' 'cmake' 'libxext')
pkg_source=(http://downloads.sourceforge.net/projectm/projectM_libvisual-${pkg_version}-Source.tar.gz)
pkg_shasum=('35e09b09210d48b437e3574bd00b15a8')

do_build() {
  mkdir build
  cmake ../projectM_libvisual-${pkg_version}-Source \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DCMAKE_BUILD_TYPE=Release || return 1
  make || return
  make DESTDIR=${pkg_prefix} install || return
}
