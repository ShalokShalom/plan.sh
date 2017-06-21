pkg_origin=

pkg_name=basket
pkg_version=2.49.80
_commit=8de0345d99f3eb08d9406bd07e88b31afe46f315
pkg_description="BasKet Note Pads - A system for organizing information in KDE."
pkg_upstream_url="https://github.com/basket-notepads/basket"
pkg_license=('GPL')
pkg_deps=('karchive' 'kcompletion' 'kconfig' 'kconfigwidgets' 'kcoreaddons' 'kcrash'
         'kdbusaddons' 'kfilemetadata' 'kglobalaccel' 'kguiaddons' 'ki18n' 'kiconthemes'
         'kcmutils' 'kio' 'knotifications' 'kparts' 'kservice' 'ktextwidgets' 'kwidgetsaddons'
         'kwindowsystem' 'kxmlgui' 'gpgme')
pkg_build_deps=('extra-cmake-modules' 'kdoctools') 
pkg_source=("https://github.com/basket-notepads/basket/archive/${_commit}.zip")
pkg_shasum=('a273cfd653a31d6ead14fb2ec76e8109')

do_prepare() {
  cd basket-${_commit}
  sed -i -e 's|V4.2-Based Variant V1.1//EN" "dtd/kdex.dtd"|V4.5-Based Variant V1.1//EN" "dtd/kdedbx45.dtd"|' doc/en/index.docbook
}

do_build() {
  mkdir -p build
  cd build 
  
  cmake ../${pkg_name}-${_commit} \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DCMAKE_BUILD_TYPE=Release \
    -DKDE_INSTALL_LIBDIR=lib \
    -DKDE_INSTALL_SYSCONFDIR=/etc \
    -DKDE_INSTALL_QMLDIR=/usr/lib/qt5/qml \
    -DKDE_INSTALL_PLUGINDIR=/usr/lib/qt5/plugins \
    -DKDE_INSTALL_USE_QT_SYS_PATHS=ON \
    -DBUILD_TESTING=OFF 
  make 
}

do_package() {
  cd build
  
  make DESTDIR=${pkg_prefix} install
}
