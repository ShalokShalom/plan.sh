pkg_origin=cosmos

pkg_name=quazip
pkg_version=0.7.3
pkg_description="Simple C++ wrapper over Gilles Vollant's ZIP/UNZIP package that can be used to access ZIP archives"
pkg_upstream_url="http://quazip.sourceforge.net/"
pkg_license=('LGPL')
pkg_deps=('qt5-base')
pkg_build_deps=('cmake')
pkg_source=("http://downloads.sourceforge.net/quazip/${pkg_name}-${pkg_version}.tar.gz")
pkg_shasum=('2ba7dd8b1d6dd588374c9fab5c46e76e')

do_build() {
  mkdir -p build
  
  cmake ../${pkg_name}-${pkg_version} \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DCMAKE_CXX_FLAGS="$CFLAGS -fPIC -std=c++11" 
  make
}

do_package() {
  
  make DESTDIR=${CACHE_PATH} install
}
