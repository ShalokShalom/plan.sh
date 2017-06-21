pkg_origin=

# include global config
source ../_buildscripts/${current_repo}-${_arch}-cfg.conf

pkg_name=ktp-text-ui
pkg_version=${_kdever}
pkg_description="Telepathy text chat handler"
pkg_upstream_url="http://www.kde.org"
pkg_license=('GPL')
pkg_deps=('ktp-common-internals' 'kpeople' 'qtwebengine' 'qt5-location')
pkg_build_deps=('extra-cmake-modules' 'kdoctools' 'boost')
pkg_source=("$_mirror/${pkg_name}-$_kdever.tar.xz"
        '0001-Port-to-QWebEngine.patch')
pkg_shasum=(`grep ${pkg_name}-$_kdever.tar.xz ../kde-sc.md5 | cut -d" " -f1`
         'ceb8d4d058efa368a531757985a90785')
         
do_prepare() {
  cd ${pkg_name}-${pkg_version}
  
  #patch -p1 -i $CACHE_PATH/0001-Port-to-QWebEngine.patch
}

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
    -DKDE_INSTALL_LIBEXECDIR=lib \
    -DBUILD_TESTING=OFF 
  make
}

do_package() {
  cd build

  make DESTDIR=${pkg_prefix} install
}
