pkg_origin=
 
pkg_name=med
pkg_version=3.2.0
pkg_description="Library to store and exchange meshed data or computation results"
pkg_upstream_url="http://www.salome-platform.org/"
pkg_license=('LGPL')
pkg_deps=('hdf5' 'openmpi')
pkg_build_deps=('cmake' 'coreutils' 'python2' 'swig')
pkg_source=("http://files.salome-platform.org/Salome/other/${pkg_name}-${pkg_version}.tar.gz"
        'build.patch')
pkg_shasum=('eb61df92f0624feb6328f517cd756a23'
         'a94c58f8f1dd354f081b154fb15c50e4')

do_prepare() {
  cd ${pkg_name}-${pkg_version}
  
  patch -p1 -i ${CACHE_PATH}/build.patch
}
         
do_build() {
  mkdir -p build
  cd build
  
  cmake ../${pkg_name}-${pkg_version} \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DMEDFILE_BUILD_FORTRAN=ON \
    -DMEDFILE_USE_MPI=OFF \
    -DMEDFILE_BUILD_STATIC_LIBS=OFF \
    -DMEDFILE_INSTALL_DOC=OFF \
    -DMEDFILE_BUILD_PYTHON=ON \
    -DMEDFILE_BUILD_TESTS=OFF 
  make
}
 
do_package() {
  cd build
  
  make DESTDIR=${pkg_prefix} install
}
