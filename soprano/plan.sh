pkg_origin=

pkg_name=soprano
pkg_version=2.9.4
pkg_description='A library which provides a highly usable object-oriented C++/Qt4 framework for RDF data'
pkg_upstream_url='http://soprano.sourceforge.net/'
pkg_license=('GPL' 'LGPL')
pkg_deps=('qt' 'redland-storage-virtuoso' 'libiodbc' 'virtuoso>=6.1.3' 'clucene')
pkg_build_deps=('cmake' 'openjdk' 'doxygen')
pkg_source=("http://downloads.sourceforge.net/${pkg_name}/${pkg_name}-${pkg_version}.tar.bz2")
pkg_shasum=('91413e5783efeee0beb747ea4c5c9ef0')

do_build() {
  cd "${CACHE_PATH}"
  
  rm -rf build
  mkdir build
  cd build
  # we need the rpath
  cmake ../${pkg_name}-${pkg_version} \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_SKIP_RPATH=OFF \
    -DCMAKE_INSTALL_PREFIX=/usr 
  make
}

do_package() {
  cd "${CACHE_PATH}"/build
  
  make DESTDIR="${pkg_prefix}" install
}
