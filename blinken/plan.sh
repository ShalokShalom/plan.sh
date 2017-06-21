pkg_origin=

# include global config
source ../_buildscripts/${current_repo}-${_arch}-cfg.conf

pkg_name=blinken
pkg_version=${_kdever}
pkg_description="Memory Enhancement Game"
pkg_upstream_url="http://kde.org/applications/education/blinken/"
pkg_license=('GPL' 'LGPL' 'FDL')
pkg_deps=('ki18n' 'kxmlgui' 'kguiaddons' 'kdbusaddons' 'phonon-qt5')
pkg_build_deps=('extra-cmake-modules' 'kdoctools')
pkg_source=("$_mirror/${pkg_name}-$_kdever.tar.xz")
pkg_shasum=(`grep ${pkg_name}-$_kdever.tar.xz ../kde-sc.md5 | cut -d" " -f1`)

do_build() {
  mkdir -p build
  cd build
  
  cmake ../${pkg_name}-$pkg_version \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DSYSCONF_INSTALL_DIR=/etc \
    -DPLUGIN_INSTALL_DIR=/usr/lib/qt5/plugins \
    -DKDE_INSTALL_USE_QT_SYS_PATHS=ON \
    -DLIB_INSTALL_DIR=lib \
    -DLIBEXEC_INSTALL_DIR=lib
  make
}

do_package() {
  cd build

  make DESTDIR=${pkg_prefix} install
}
