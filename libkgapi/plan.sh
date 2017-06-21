pkg_origin=

# include global config
source ../_buildscripts/${current_repo}-${_arch}-cfg.conf

pkg_name=libkgapi
pkg_version=${_kdever}
pkg_description="A KDE-based library for accessing various Google services via their public API"
pkg_upstream_url='https://github.com/KDE/libkgapi'
pkg_license=('GPL' 'LGPL' 'FDL')
pkg_deps=('kio' 'kwindowsystem' 'kcalcore' 'kcontacts' 'qtwebengine')
pkg_build_deps=('extra-cmake-modules' 'kdoctools' 'qt5-tools' 'boost')
pkg_source=($_mirror/${pkg_name}-${_kdever}.tar.xz
        "https://github.com/KDE/libkgapi/commit/68b89bce22d0da234345ccffb869ae6863592624.diff")
pkg_shasum=(`grep ${pkg_name}-${_kdever}.tar.xz ../kde-sc.md5 | cut -d" " -f1`
         '0ac22000072fa47d8632419cb3168504')

prepare () {
  cd ${pkg_name}-${pkg_version}
  # fix Google broke akonadi/IMAP functionality
  #patch -p1 -i $CACHE_PATH/68b89bce22d0da234345ccffb869ae6863592624.diff
}     

do_build() {
  mkdir -p build
  
  cd build 
  cmake ../${pkg_name}-${pkg_version} \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_SKIP_RPATH=ON \
    -DKDE_INSTALL_LIBDIR=lib \
    -DKDE_INSTALL_SYSCONFDIR=/etc \
    -DKDE_INSTALL_QMLDIR=/usr/lib/qt5/qml \
    -DKDE_INSTALL_PLUGINDIR=/usr/lib/qt5/plugins \
    -DKDE_INSTALL_USE_QT_SYS_PATHS=ON \
    -DBUILD_TESTING=ON 
  make 
}

do_package() {
  cd build
  
  make DESTDIR=${pkg_prefix} install
}

