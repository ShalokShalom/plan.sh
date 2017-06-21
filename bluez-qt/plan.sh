pkg_origin=

# include global config
source ../_buildscripts/${current_repo}-${_arch}-cfg.conf

pkg_name=bluez-qt
pkg_version=${_kf5ver}
pkg_description="Qt wrapper for Bluez 5 DBus API"
pkg_upstream_url="https://projects.kde.org/projects/frameworks/bluezqt"
pkg_license=('GPL' 'LGPL' 'FDL')
pkg_deps=('qt5-declarative' 'bluez')
pkg_build_deps=('extra-cmake-modules')
pkg_source=($_mirror/${pkg_name}-$_kf5ver.tar.xz)
pkg_shasum=(`grep ${pkg_name}-$_kf5ver.tar.xz ../kf5.md5 | cut -d" " -f1`)

do_build() {
  mkdir -p build
  cd build

  cmake ../${pkg_name}-${pkg_version} \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DKDE_INSTALL_LIBDIR=lib \
    -DKDE_INSTALL_SYSCONFDIR=/etc \
    -DKDE_INSTALL_QMLDIR=/usr/lib/qt5/qml \
    -DKDE_INSTALL_PLUGINDIR=/usr/lib/qt5/plugins \
    -DKDE_INSTALL_USE_QT_SYS_PATHS=ON \
    -DUDEV_RULES_INSTALL_DIR=/usr/lib/udev/rules.d \
    -DBUILD_TESTING=OFF 
  make
}

do_package() {
  cd build

  make DESTDIR=${pkg_prefix} install
}
