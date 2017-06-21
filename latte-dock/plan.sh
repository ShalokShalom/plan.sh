pkg_origin=

pkg_name=latte-dock
_pkg_name=Latte-Dock
pkg_version=0.6.2
pkg_description="Dock based on plasma frameworks that provides an elegant and intuitive experience for your tasks and plasmoids"
pkg_upstream_url="https://store.kde.org/p/1169519/"
pkg_license=('GPL')
pkg_deps=('plasma-framework' 'kactivities' 'kcoreaddons' 'kdbusaddons' 'kdeclarative' 'kwayland'
         'kpackage' 'kxmlgui' 'kiconthemes' 'ki18n' 'karchive' 'knotifications' 'kglobalaccel'
         'kwindowsystem' 'qt5-x11extras')
pkg_build_deps=('extra-cmake-modules' 'kdoctools')
pkg_source=("https://github.com/psifidotos/Latte-Dock/archive/v${pkg_version}.tar.gz")
pkg_shasum=('8b7f07a3ba2a9296d6d7f83d7e83e7d1')

do_build() {
  cd ${_pkg_name}-${pkg_version}
  mkdir -p build
  cd build 
  
  cmake .. \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_LIBDIR=lib \
    -DKDE_INSTALL_QMLDIR=/usr/lib/qt5/qml \
    -DKDE_INSTALL_PLUGINDIR=/usr/lib/qt5/plugins 
  make -j1
}

do_package() {
  cd ${_pkg_name}-${pkg_version}/build
  make DESTDIR=${pkg_prefix} install
  
  install -D -m644 ../LICENSE ${pkg_prefix}/usr/share/licenses/${pkg_name}/LICENSE
}

