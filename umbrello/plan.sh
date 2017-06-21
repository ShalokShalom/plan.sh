pkg_origin=

# include global config
source ../_buildscripts/${current_repo}-${_arch}-cfg.conf

pkg_name=umbrello
pkg_version=${_kdever}
pkg_description='UML modeling tool for KDE'
pkg_upstream_url='http://kde.org/applications/development/umbrello/'
pkg_license=('GPL' 'LGPL' 'FDL')
pkg_deps=('karchive' 'kauth' 'kcompletion' 'kconfig' 'kcoreaddons' 'kguiaddons' 'ki18n' 'kiconthemes' 'kinit'
         'kio' 'kparts' 'kservice' 'ktexteditor' 'kwindowsystem' 'kwidgetsaddons' 'kxmlgui' 'qt5-webkit')
pkg_build_deps=('extra-cmake-modules' 'kdoctools' 'boost') # 'clang')
pkg_source=("$_mirror/${pkg_name}-$_kdever.tar.xz")
pkg_shasum=(`grep ${pkg_name}-${_kdever}.tar.xz ../kde-sc.md5 | cut -d" " -f1`)

do_prepare() {
  cd ${pkg_name}-${pkg_version}
  sed -i -e 's|ecm_optional_add_subdirectory(unittests)|#ecm_optional_add_subdirectory(unittests)|' CMakeLists.txt
  # fix .desktop for 17.03.90
  sed -i -e 's|Exec=umbrello|Exec=umbrello5|' umbrello/umbrello.desktop
}

do_build() {
  mkdir -p build
  cd build
  
  cmake ../${pkg_name}-${pkg_version} \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DKDE_INSTALL_LIBDIR=lib \
    -DKDE_INSTALL_PLUGINDIR=/usr/lib/qt5/plugins \
    -DKDE_INSTALL_USE_QT_SYS_PATHS=ON \
    -DBUILD_TESTING=OFF \
    -DBUILD_UNITTESTS=0 \
    -DBUILD_KF5=ON
  make
}

do_package() {
  cd build

  make DESTDIR=${pkg_prefix} install
}

