pkg_origin=cosmos

pkg_name=clucene
pkg_version=2.3.3.4
pkg_description="CLucene is a C++ port of Lucene: A high-performance, full-featured text search engine."
pkg_upstream_url="http://clucene.sourceforge.net"
pkg_license=('APACHE' 'LGPL')
pkg_deps=('gcc-libs' 'zlib' 'boost-libs')
pkg_build_deps=('cmake' 'boost')
pkg_source=("https://downloads.sourceforge.net/clucene/$pkg_name-core-$pkg_version.tar.gz"
        'clucene-core-2.3.3.4-install_contribs_lib.patch'
        'clucene-core-2.3.3.4-pkgconfig.patch'
        'fix_zlib_detections.diff')
pkg_shasum=('48d647fbd8ef8889e5a7f422c1bfda94'
         '7e8004510b0cdeec29bbecb36307669b'
         '28faf56ff95eb1f5239885ad5060e28f'
         'f9bce8197704b1d2ebd47c37648f1a17')

do_build() {
   # Fedora patches needed by Libre 3.6
  patch -p1 -i ${CACHE_PATH}/clucene-core-2.3.3.4-install_contribs_lib.patch
  patch -p1 -i ${CACHE_PATH}/clucene-core-2.3.3.4-pkgconfig.patch
  # one upstream postrelease commit for proper zlib detection
  patch -p1 -i ${CACHE_PATH}/fix_zlib_detections.diff
  mkdir build
  pushd build
  cmake .. \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DENABLE_ASCII_MODE=OFF \
    -DENABLE_PACKAGING=OFF \
    -DBUILD_CONTRIBS_LIB:BOOL=ON \
    -DLIB_DESTINATION:PATH=/usr/lib \
    -DLUCENE_SYS_INCLUDES:PATH=/usr/lib \
    -DDISABLE_MULTITHREADING=OFF
  popd
  make -C build
}

do_package() {
  make DESTDIR="$pkg_prefix" install -C build
  rm -rf $pkg_prefix/usr/lib/CLuceneConfig.cmake
}
