pkg_origin=

pkg_name=knights
pkg_version=2.5.85
_commit=d2496a97f8854ceebd242a487665ebbb14f55996
pkg_description="Chess board for KDE with XBoard protocol support"
pkg_upstream_url="https://www.linux-apps.com/content/show.php/Knights?content=122046"
pkg_license=('GPL')
pkg_deps=('kcoreaddons' 'kconfig' 'kwidgetsaddons' 'kdbusaddons' 'ki18n' 'kconfigwidgets'
         'ktextwidgets' 'kxmlgui' 'kio' 'plasma-framework' 'kplotting' 'knotifyconfig'
         'kwallet' 'kcompletion' 'libkdegames' 'gnuchess' 'qt5-speech')
pkg_build_deps=('extra-cmake-modules' 'kdoctools' 'clang')
pkg_source=("https://github.com/KDE/knights/archive/${_commit}.zip"
        'historywidget.diff')
pkg_shasum=('f79e841dad0743a58f6c5a5a1c3b5c33'
         '4ad894eb4ab4f0a362b2a0fd77d89c31')

do_prepare() {
  cd $pkg_name-${_commit}
  
  patch -p1 -i $CACHE_PATH/historywidget.diff
}

do_build() {
  mkdir -p build
  cd build 
  
  export CC=/usr/bin/clang
  export CXX=/usr/bin/clang++
  
  cmake ../${pkg_name}-${_commit} \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_SKIP_RPATH=ON \
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
