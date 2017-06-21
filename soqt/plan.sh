pkg_origin=cosmos

pkg_name=soqt
pkg_version=1.5.0
pkg_description='A library which provides the glue between Coin and Qt'
pkg_upstream_url='http://www.coin3d.org/lib/soqt/'
pkg_license=('GPL')
pkg_deps=('coin' 'qt')
pkg_build_deps=('doxygen')
pkg_source=("https://bitbucket.org/Coin3D/coin/downloads/SoQt-${pkg_version}.tar.gz")
pkg_shasum=('9f1e582373d66f556b1db113a93ac68e')

do_build() {

  ./configure --prefix=/usr \
    --enable-optimization \
    --enable-man \
    --enable-exceptions \
    --disable-debug \
    --disable-maintainer-mode \
    --disable-dependency-tracking \
    --enable-shared \
    --disable-static \
    --with-qt=/usr

  make
}

do_package() {

  make DESTDIR=${CACHE_PATH} install
}

