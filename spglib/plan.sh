pkg_origin=
 
pkg_name=spglib
pkg_version=1.9.9
pkg_description="Library for finding and handling crystal symmetries written in C."
pkg_upstream_url="http://atztogo.github.io/spglib/"
pkg_license=('custom')
pkg_deps=('glibc')
pkg_build_deps=('cmake')
pkg_source=("https://github.com/atztogo/spglib/archive/v${pkg_version}.tar.gz")
pkg_shasum=('6bbf2cb37a2294f26f2324e1142ab7d8')

prepare () {
  cd ${pkg_name}-${pkg_version}
  
  sed -i 's|${PROJECT_SOURCE_DIR}/lib|${pkg_prefix}/usr/lib|' CMakeLists.txt
  sed -i 's|${PROJECT_SOURCE_DIR}/include|${pkg_prefix}/usr/include/spglib|' CMakeLists.txt
}      

do_build() {
  mkdir -p build
  cd build
  
  cmake ../${pkg_name}-${pkg_version} \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=/usr 
  make
}

do_package() {
  cd build
  make DESTDIR=${pkg_prefix} install
  
  install -Dm644 ${CACHE_PATH}/${pkg_name}-${pkg_version}/COPYING ${pkg_prefix}/usr/share/licenses/${pkg_name}/LICENSE
}
