pkg_origin=cosmos

pkg_name=taglib
pkg_version=1.11.1
pkg_description="A Library for reading and editing the meta-data of several popular audio formats"
pkg_upstream_url="http://taglib.github.io/"
pkg_license=('GPL2')
pkg_deps=('sh' 'zlib' 'gcc-libs')
pkg_build_deps=('cmake' 'pkg-config' 'boost')
pkg_source=("http://taglib.github.io/releases/$pkg_name-$pkg_version.tar.gz")
pkg_shasum=('cee7be0ccfc892fa433d6c837df9522a')

do_build() {
  mkdir build
  
  cmake ../${pkg_name}-${pkg_version} \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DCMAKE_BUILD_TYPE=Release \
    -DWITH_MP4=ON \
    -DWITH_ASF=ON \
    -DBUILD_SHARED_LIBS=ON
  make
}

do_package() {
  
  make DESTDIR="${CACHE_PATH}" install
}
