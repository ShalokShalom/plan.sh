pkg_origin=

# include global config
source ../_buildscripts/${current_repo}-${_arch}-cfg.conf

pkg_name=libkmahjongg
pkg_version=${_kdever}
pkg_description="Common code, backgrounds and tile sets for games using Mahjongg tiles"
pkg_upstream_url='https://projects.kde.org/projects/kde/kdegames/libkmahjongg'
pkg_license=('GPL' 'LGPL' 'FDL')
pkg_deps=('kwidgetsaddons' 'ki18n' 'kcompletion' 'kconfig' 'kconfigwidgets' 'qt5-svg')
pkg_build_deps=('pkg-config' 'extra-cmake-modules')
pkg_source=("$_mirror/${pkg_name}-$_kdever.tar.xz")
pkg_shasum=(`grep ${pkg_name}-$_kdever.tar.xz ../kde-sc.md5 | cut -d" " -f1`)

do_build() {
  cd ${CACHE_PATH}
  
  mkdir -p build
  cd build

  cmake ../${pkg_name}-${pkg_version} \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DLIB_INSTALL_DIR=lib \
    -DSYSCONF_INSTALL_DIR=/etc \
    -DQML_INSTALL_DIR=/usr/lib/qt5/qml \
    -DPLUGIN_INSTALL_DIR=/usr/lib/qt5/plugins \
    -DKDE_INSTALL_USE_QT_SYS_PATHS=ON \
    -DBUILD_TESTING=OFF 
  make
}

do_package() {
  cd build

  make DESTDIR=${pkg_prefix} install
}

