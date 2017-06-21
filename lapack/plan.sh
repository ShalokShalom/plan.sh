pkg_origin=cosmos

pkg_name=lapack
pkg_version=3.7.0
pkg_upstream_url="http://www.netlib.org/lapack"
pkg_description="Linear Algebra PACKage"
pkg_deps=('gcc-libs')
pkg_build_deps=('gcc' 'cmake')
pkg_license=("custom")
pkg_source=("http://www.netlib.org/lapack/${pkg_name}-${pkg_version}.tgz")
pkg_shasum=('697bb8d67c7d336a0f339cc9dd0fa72f')

do_build() {

  install -d build
  cmake ../${pkg_name}-${pkg_version} \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_SKIP_RPATH=ON \
    -DBUILD_SHARED_LIBS=ON \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DCMAKE_INSTALL_LIBDIR=lib \
    -DCMAKE_Fortran_COMPILER=gfortran \
    -DLAPACKE=ON 
  make
}

do_package() {
  make DESTDIR=$pkg_prefix install
  
  # install the test bin options
  install -m755 -d ${pkg_prefix}/usr/bin
  install -m755 ${CACHE_PATH}/build/bin/* ${pkg_prefix}/usr/bin
  
  install -m755 -d ${pkg_prefix}/usr/share/licenses/lapack
  install -m644 ${CACHE_PATH}/${pkg_name}-${pkg_version}/LICENSE  ${pkg_prefix}/usr/share/licenses/lapack/
}

