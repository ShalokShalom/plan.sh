pkg_origin=

# include global config
source ../_buildscripts/${current_repo}-${_arch}-cfg.conf

pkg_name=libkgeomap
pkg_version=${_kdever}
#pkg_version=4.9.90
pkg_description="Wrapper around different world-map components, to browse and arrange photos over a map"
pkg_upstream_url='https://projects.kde.org/projects/extragear/libs/libkgeomap'
pkg_license=('GPL' 'LGPL' 'FDL')
pkg_deps=('ki18n' 'kconfig' 'kio' 'khtml' 'kparts' 'libkexiv2' 'marble' 'qt5-webkit')
pkg_build_deps=('extra-cmake-modules' 'kdoctools' 'pkg-config')
pkg_source=("$_mirror/${pkg_name}-$_kdever.tar.xz")
pkg_shasum=(`grep ${pkg_name}-$_kdever.tar.xz ../kde-sc.md5 | cut -d" " -f1`)
#pkg_source=("git://anongit.kde.org/libkgeomap.git")
#pkg_shasum=('SKIP')

do_prepare() {
   cd $pkg_name-${pkg_version}
   #patch -p1 -i ${CACHE_PATH}/CMakeLists.diff
   #sed -i -e 's|FIND_LIBRARY( MARBLE_LIBRARIES NAMES marblewidget-qt5 )|FIND_LIBRARY( MARBLE_LIBRARIES NAMES marblewidget )|' ${CACHE_PATH}/${pkg_name}/cmake/modules/FindMarble.cmake
   #sed -i -e 's|find_dependency(F5Config)||' ${CACHE_PATH}/${pkg_name}/cmake/templates/KF5KGeoMapConfig.cmake.in
}

do_build() {
  mkdir -p build
  cd build
  
  cmake ../${pkg_name}-${pkg_version} \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DLIB_INSTALL_DIR=lib \
    -DPLUGIN_INSTALL_DIR=/usr/lib/qt5/plugins \
    -DKDE_INSTALL_USE_QT_SYS_PATHS=ON \
    -DBUILD_TESTING=OFF 
  make
}

do_package() {
  cd build

  make DESTDIR=${pkg_prefix} install
}
