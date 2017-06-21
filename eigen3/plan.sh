pkg_origin=cosmos

pkg_name=eigen3
pkg_version=3.3.3
pkg_description="Lightweight C++ template library for vector and matrix math, a.k.a. linear algebra."
pkg_upstream_url='http://eigen.tuxfamily.org'
pkg_license=('GPL3' 'LGPL2.1' 'BSD' 'custom:MPL2' 'custom:MINPACK')
pkg_deps=('fftw' 'freeglut')
pkg_build_deps=('cmake' 'pkg-config')
pkg_source=("${pkg_name}-${pkg_version}.tar.bz2::http://bitbucket.org/eigen/eigen/get/${pkg_version}.tar.bz2")
pkg_shasum=('b2ddade41040d9cf73b39b4b51e8775b')

do_build() {
  mkdir -p build

  cmake ../eigen-eigen-* \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DCMAKE_INSTALL_DATADIR=lib
}

do_package() {
  make DESTDIR=${pkg_prefix} install

  install -Dm644 ../eigen-eigen-*/COPYING.MPL2 ${pkg_prefix}/usr/share/licenses/${pkg_name}/LICENSE
  install -Dm644 ../eigen-eigen-*/COPYING.BSD ${pkg_prefix}/usr/share/licenses/${pkg_name}/LICENSE
  install -Dm644 ../eigen-eigen-*/COPYING.MINPACK ${pkg_prefix}/usr/share/licenses/${pkg_name}/LICENSE
}
