pkg_origin=

# include global config
source ../_buildscripts/${current_repo}-${_arch}-cfg.conf

pkg_name=akonadi-import-wizard
pkg_version=${_kdever}
pkg_description="Assistant to import PIM data from other applications into Akonadi for use in KDE PIM applications."
pkg_upstream_url='https://github.com/KDE/akonadi-import-wizard'
pkg_license=('LGPL')
pkg_deps=('kwallet' 'kconfig' 'kdbusaddons' 'kauth' 'kcrash' 'kio'
         'akonadi' 'kcontacts' 'kidentitymanagement' 'kmailtransport' 'mailcommon'
         'mailimporter' 'messagelib' 'pimcommon' 'libkdepim')
pkg_build_deps=('extra-cmake-modules' 'kdoctools' 'boost')
install=${pkg_name}.install
pkg_source=($_mirror/${pkg_name}-${_kdever}.tar.xz)
pkg_shasum=(`grep ${pkg_name}-${_kdever}.tar.xz ../kde-sc.md5 | cut -d" " -f1`)

do_build() {
  mkdir -p build
  cd build 
  
  cmake ../${pkg_name}-${pkg_version} \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_LIBDIR=lib \
    -DKDE_INSTALL_USE_QT_SYS_PATHS=ON \
    -DKDE_INSTALL_QMLDIR=/usr/lib/qt5/qml \
    -DKDE_INSTALL_PLUGINDIR=/usr/lib/qt5/plugins \
    -DBUILD_TESTING=OFF 
  make 
}

do_package() {
  cd build
  
  make DESTDIR=${pkg_prefix} install
}
