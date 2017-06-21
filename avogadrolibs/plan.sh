pkg_origin=

pkg_name=avogadrolibs
pkg_version=1.90.0
pkg_description="Libraries providing 3D rendering, visualization, analysis and data processing useful in computational chemistry and related areas."
pkg_upstream_url="http://www.openchemistry.org/projects/avogadro2/"
pkg_license=('GPL2')
pkg_deps=('qt5-base' 'glew' 'hdf5' 'jsoncpp' 'spglib')
pkg_build_deps=('cmake' 'boost' 'eigen3')
pkg_source=("https://github.com/OpenChemistry/avogadrolibs/archive/${pkg_version}.tar.gz")
pkg_shasum=('f2b7014f48da5b2a72d49c01dafaf225')

do_prepare() {
  cd ${pkg_name}-${pkg_version}
  #patch -p1 -i ${CACHE_PATH}/boost.patch
  sed -i 's|NAMES spglib|NAMES symspg|' cmake/FindSpglib.cmake
}

do_build() {
  mkdir build
  cd build
  
  cmake ../${pkg_name}-${pkg_version} \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DCMAKE_INSTALL_LIBDIR=lib \
    -DUSE_BOOST_PYTHON=OFF \
    -DUSE_MOLEQUEUE=OFF \
    -DUSE_OPENGL=ON \
    -DUSE_QT=ON \
    -DUSE_HDF5=ON \
    -DUSE_VTK=OFF
  make
}

do_package() {
  cd build
  make DESTDIR=${pkg_prefix} install
  
  # use system jsoncpp
  rm ${pkg_prefix}/usr/lib/libjsoncpp.a
  
  install -Dm644 ../${pkg_name}-${pkg_version}/COPYING ${pkg_prefix}/usr/share/licenses/${pkg_name}/LICENSE
}
