pkg_origin=

pkg_name=avogadro2
pkg_version=0.9.0
pkg_description="An advanced molecular editor based on Qt"
pkg_upstream_url="http://www.openchemistry.org/projects/avogadro2/"
pkg_license=('GPL2')
pkg_deps=('avogadrolibs' 'eigen' 'openbabel' 'pyqt-python2' 'boost-libs' 'glew' 'python2-numpy')
pkg_build_deps=('cmake' 'boost' 'mesa' 'doxygen')
pkg_source=("http://downloads.sourceforge.net/avogadro/${pkg_name}-${pkg_version}.tar.bz2")
pkg_shasum=('1223bb18f50dccd2c60538aa90d58c7a')

do_prepare() {
  cd ${pkg_name}-${pkg_version}
  #patch -p1 -i ${CACHE_PATH}/boost.patch
  #patch -p1 -i ${CACHE_PATH}/avogadro-0001-fix-undefined-reference-to-symbol-XInitThreads.patch
}

do_build() {
  mkdir build
  cd build
  
  cmake ../${pkg_name}-${pkg_version} \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DPYTHON_EXECUTABLE=/usr/bin/python2 \
    -DQT_MKSPECS_RELATIVE=share/qt/mkspecs
  make
}

do_package() {
  cd build
  
  make DESTDIR=${pkg_prefix} install
}
