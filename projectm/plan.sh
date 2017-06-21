pkg_origin=cosmos
# $Id: PKGBUILD 78581 2010-04-26 20:01:05Z andrea $
# Maintainer:
# Contributor: Alexander Baldeck <alexander@archlinux.org>

pkg_name=projectm
pkg_version=2.0.1
pkg_description="A music visualizer which uses 3D accelerated iterative image based rendering"
pkg_upstream_url="http://projectm.sourceforge.net/"
pkg_license=('LGPL')
pkg_deps=('gcc-libs' 'ftgl' 'glew' 'gtkglext')
pkg_build_deps=('pkgconfig' 'cmake')
pkg_source=(http://downloads.sourceforge.net/${pkg_name}/projectM-${pkg_version}-Source.tar.gz)
pkg_shasum=('f8bf795878cdbbef54784cf2390b4c89')

do_build() {
#  sed -i 's|FTGL/FTGL.h|FTGL/ftgl.h|' Renderer.hpp || return 1
#  sed -i "s|#include <iostream>|#include <cstdio>\n#include <iostream>|" BuiltinParams.cpp || return 1
  mkdir build
  cmake ../projectM-${pkg_version}-Source \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DCMAKE_BUILD_TYPE=Release || return 1
  make || return 1
}

do_package() {
  make DESTDIR=${pkg_prefix} install || return 1
}
