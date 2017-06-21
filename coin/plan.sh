pkg_origin=cosmos

pkg_name=coin
pkg_version=3.1.3
pkg_description='High-level 3D graphics toolkit on top of OpenGL'
pkg_upstream_url='https://bitbucket.org/Coin3D/coin/wiki/Home'
pkg_license=('GPL')
pkg_deps=('libgl' 'expat' 'openal' 'fontconfig' 'zlib' 'freetype2' 'js')
pkg_build_deps=('doxygen')
pkg_source=("https://bitbucket.org/Coin3D/coin/downloads/Coin-${pkg_version}.tar.gz"
        'memhandler.patch')
pkg_shasum=('1538682f8d92cdf03e845c786879fbea'
         '25897deed88fdaf6a4950fce79211f9f')

do_build() {

    #sed -i '/^#include "fonts\/freetype.h"$/i #include <cstdlib>\n#include <cmath>' src/fonts/freetype.cpp
    sed -i '/^#include <Inventor\/C\/basic.h>$/i #include <Inventor/C/errors/debugerror.h>' include/Inventor/SbBasic.h
    patch -p1 -i ${CACHE_PATH}/memhandler.patch

    ./configure \
        --prefix=/usr \
        --mandir=/usr/share/man \
        --enable-optimization \
        --enable-3ds-import \
        --enable-javascript-api \
        --enable-threadsafe \
        --enable-exceptions \
        --enable-man \
        --enable-html \
        --with-mesa \
        --disable-debug \
        --enable-shared \
        --disable-maintainer-mode \
        --disable-dependency-tracking \
        --enable-system-expat

    make
}

do_package() {
    make DESTDIR=${pkg_prefix} install

    rm -r ${pkg_prefix}/usr/share/man/man3
}

