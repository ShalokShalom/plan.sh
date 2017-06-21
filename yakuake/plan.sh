pkg_origin=

pkg_name=yakuake
pkg_version=3.0.4
pkg_description="A KDE konsole application with the look and feel of that in the Quake engine, kf5 version"
pkg_upstream_url="http://yakuake.kde.org"
pkg_license=('GPL')
pkg_deps=('karchive' 'kconfig' 'kcoreaddons' 'kdbusaddons' 'kglobalaccel' 'ki18n' 'kiconthemes'
         'kio' 'knewstuff' 'knotifications' 'knotifyconfig' 'kparts' 'kwidgetsaddons' 
         'kwindowsystem' 'kwayland')
pkg_build_deps=('extra-cmake-modules')
pkg_source=("http://download.kde.org/stable/yakuake/${pkg_version}/src/${pkg_name}-${pkg_version}.tar.xz")
pkg_shasum=('f8f43f2f3d99925d8853879ff1eb5826')

do_prepare() {
  cd ${pkg_name}-${pkg_version}
  #sed -i -e 's|<default>default<default>|<default>breezeV1.0</default>|' ${CACHE_PATH}/${pkg_name}/app/config/yakuake.kcfg
  #patch -p1 -i $CACHE_PATH/default_skin.diff
  
}

do_build() {
  mkdir build
  cd build
  
  cmake ../${pkg_name}-${pkg_version} \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DKDE_INSTALL_LIBDIR=lib \
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
