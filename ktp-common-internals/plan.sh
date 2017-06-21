pkg_origin=

# include global config
source ../_buildscripts/${current_repo}-${_arch}-cfg.conf

pkg_name=ktp-common-internals
pkg_version=${_kdever}
pkg_description="Common libraries for telepathy-kde"
pkg_upstream_url="https://projects.kde.org/projects/extragear/network/telepathy/ktp-common-internals"
pkg_license=('GPL')
pkg_deps=('kcmutils' 'knotifyconfig' 'ktexteditor' 'kwallet' 'kconfig' 'kdelibs4support'
         'telepathy-qt5' 'telepathy-mission-control' 'kpeople' 'kcontacts' 'kaccounts-integration'
         'libotr' 'telepathy-logger-qt5' 'telepathy-accounts-signon')
pkg_build_deps=('extra-cmake-modules' 'kdoctools' 'git' 'boost')
pkg_source=("$_mirror/${pkg_name}-$_kdever.tar.xz")
pkg_shasum=(`grep ${pkg_name}-$_kdever.tar.xz ../kde-sc.md5 | cut -d" " -f1`)

do_build() {
  cd ${CACHE_PATH}
  
  mkdir -p build
  cd build

  cmake ../${pkg_name}-${pkg_version} \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DKDE_INSTALL_LIBDIR=lib \
    -DKDE_INSTALL_LIBEXECDIR=lib \
    -DKDE_INSTALL_SYSCONFDIR=/etc \
    -DKDE_INSTALL_QMLDIR=/usr/lib/qt5/qml \
    -DKDE_INSTALL_PLUGINDIR=/usr/lib/qt5/plugins \
    -DBUILD_TESTING=OFF 
  make
}

do_package() {
  cd build

  make DESTDIR=${pkg_prefix} install
}
