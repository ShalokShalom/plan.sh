pkg_origin=

pkg_name=kdeconnect-kde
pkg_version=1.0.3
_pkg_version=1.0.3
epoch=1
pkg_description='KDE Connect adds communication between KDE and your smartphone'
pkg_upstream_url='https://github.com/KDE/kdeconnect-kde'
pkg_license=('GPL')
pkg_deps=('kcmutils' 'kconfigwidgets' 'kiconthemes' 'kdbusaddons' 'knotifications' 
         'kio' 'ki18n' 'kdeclarative' 'kwayland' 'qca-qt5' 'libfakekey'
         'qt5-quickcontrols' 'telepathy-qt5' 'kirigami')
pkg_build_deps=('extra-cmake-modules' 'kdoctools')
pkg_source=("http://download.kde.org/stable/kdeconnect/${_pkg_version}/src/${pkg_name}-${pkg_version}.tar.xz")
pkg_shasum=('085915477e922cf723d4f7454a0d3773')

do_prepare() {
  cd $pkg_name-${pkg_version}
  #sed -i -e 's|import QtQuick.Layouts 1.2|import QtQuick.Layouts 1.1|' ${CACHE_PATH}/${pkg_name}/app/qml/DeviceDelegate.qml
  #sed -i -e 's|import QtQuick.Layouts 1.2|import QtQuick.Layouts 1.1|' ${CACHE_PATH}/${pkg_name}/app/qml/mpris.qml
}

do_build() {
  mkdir -p build
  cd build 
  
  cmake ../${pkg_name}-${pkg_version} \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_SKIP_RPATH=ON \
    -DKDE_INSTALL_LIBDIR=lib \
    -DKDE_INSTALL_LIBEXECDIR=lib \
    -DKDE_INSTALL_SYSCONFDIR=/etc \
    -DKDE_INSTALL_USE_QT_SYS_PATHS=ON \
    -DBUILD_TESTING=OFF \
    -DEXPERIMENTALAPP_ENABLED=ON
  make 
}

do_package() {
  cd build
  
  make DESTDIR=${pkg_prefix} install
}
