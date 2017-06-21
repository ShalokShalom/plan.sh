pkg_origin=cosmos

pkg_name=eigen
pkg_version=2.0.17
pkg_description="A lightweight C++ template library for vector and matrix math, a.k.a. linear algebra"
pkg_upstream_url='http://eigen.tuxfamily.org/index.php?title=Main_Page'
pkg_license=('GPL' 'LGPL3')
pkg_build_deps=('cmake' 'pkg-config')
pkg_source=("http://bitbucket.org/eigen/eigen/get/${pkg_version}.tar.bz2")
pkg_shasum=('2dfd1e2765d82c306adbfcd6a0eb324b')

do_build() {
  mkdir build
  
  cmake ../eigen-eigen-b23437e61a07 \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=/usr
  make
}

do_package() {
  
  make DESTDIR="${pkg_prefix}" install
}
