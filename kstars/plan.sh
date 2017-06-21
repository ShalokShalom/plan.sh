pkg_origin=

# include global config
source ../_buildscripts/${current_repo}-${_arch}-cfg.conf

pkg_name=kstars
pkg_version=${_kdever}
pkg_description="Desktop Planetarium"
pkg_upstream_url="http://kde.org/applications/education/kstars/"
pkg_upstream_url='http://www.kde.org'
pkg_license=('GPL' 'LGPL' 'FDL')
pkg_deps=('kconfig' 'kwidgetsaddons' 'kguiaddons' 'knewstuff' 'kdbusaddons' 'ki18n' 'ktexteditor' 
         'kxmlgui' 'kwindowsystem' 'kinit' 'kdeclarative' 'kplotting' 'kjobwidgets' 'kio' 'kiconthemes'
         'cfitsio' 'wcslib' 'xplanet' 'qt5-multimedia' 'libindi')
pkg_build_deps=('extra-cmake-modules' 'kdoctools' 'eigen3')
pkg_source=("$_mirror/${pkg_name}-$_kdever.tar.xz"
        'isnan.diff')
pkg_shasum=(`grep ${pkg_name}-$_kdever.tar.xz ../kde-sc.md5 | cut -d" " -f1`
         '132dfb3da1d339b9990d55aae0fa148e')

do_prepare() {
  cd ${CACHE_PATH}/${pkg_name}-${pkg_version} 
  #sed -i -e 's|add_subdirectory(doc)|#add_subdirectory(doc)|' ${CACHE_PATH}/${pkg_name}/CMakeLists.txt
  #patch -p1 -i $CACHE_PATH/isnan.diff 
}

do_build() {
 mkdir -p build
  cd build

  cmake ../${pkg_name}-${pkg_version} \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DLIB_INSTALL_DIR=lib \
    -DSYSCONF_INSTALL_DIR=/etc \
    -DQML_INSTALL_DIR=/usr/lib/qt5/qml \
    -DPLUGIN_INSTALL_DIR=/usr/lib/qt5/plugins \
    -DBUILD_TESTING=OFF 
  make
}

do_package() {
  cd build

  make DESTDIR=${pkg_prefix} install
}
