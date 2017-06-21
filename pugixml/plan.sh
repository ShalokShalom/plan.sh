pkg_origin=cosmos

pkg_name=pugixml
pkg_version=1.8.1
_pkg_version=1.8
pkg_description="Light-weight C++ XML processing library with XPath support"
pkg_upstream_url='http://pugixml.org'
pkg_license=('MIT')
pkg_build_deps=('cmake')
pkg_source=("http://github.com/zeux/pugixml/releases/download/v${pkg_version}/${pkg_name}-${pkg_version}.tar.gz")
pkg_shasum=('57acb4b1a9022975fdad456135903bee')

do_build() {
  mkdir -p build

  cmake ../${pkg_name}-${_pkg_version} \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DCMAKE_INSTALL_LIBDIR=lib \
    -DBUILD_SHARED_LIBS=ON
  make
}

do_package() {
  
  make DESTDIR=${CACHE_PATH} install
}
