pkg_origin=cosmos

pkg_name=qhull
pkg_version=2015.2
_pkg_version=2015-src-7.2.0
pkg_description="A general dimension code for computing convex hulls and related structures"
pkg_upstream_url="http://www.qhull.org/"
pkg_license=('custom')
pkg_deps=('glibc')
pkg_build_deps=('cmake')
pkg_source=("http://www.qhull.org/download/${pkg_name}-${_pkg_version}.tgz")
pkg_shasum=('e6270733a826a6a7c32b796e005ec3dc')

do_build() {
  mkdir -p build
  
  cmake ../${pkg_name}-${pkg_version} \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DCMAKE_CXX_FLAGS=-fPIC \
    -DCMAKE_C_FLAGS=-fPIC 
  make
}

do_package() { 
  make DESTDIR=$CACHE_PATH install

  install -Dm644 ${CACHE_PATH}/${pkg_name}-${pkg_version}/COPYING.txt ${CACHE_PATH}/usr/share/licenses/${pkg_name}/license.txt
}

