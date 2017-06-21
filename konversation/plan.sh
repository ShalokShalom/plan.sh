pkg_origin=


pkg_name=konversation
pkg_version=1.7.2
_pkg_version=1.7.2
pkg_description="A user friendly IRC client for KDE"
pkg_upstream_url="http://konversation.kde.org"
pkg_license=('GPL2' 'FDL')
pkg_deps=('kfilemetadata' 'kidletime' 'kcmutils' 'krunner' 'kemoticons' 
         'knotifyconfig' 'phonon-qt5' 'baloo-widgets' 'qca-qt5')
pkg_build_deps=('extra-cmake-modules' 'kdoctools')
pkg_source=("https://download.kde.org/stable/${pkg_name}/${_pkg_version}/src/${pkg_name}-${_pkg_version}.tar.xz")
pkg_shasum=('4a9ddf5730a3e7a9bedcbb7a1b01b5db')

do_prepare() {
  cd ${pkg_name}-${_pkg_version}
  # set default channel to KaOS
  sed -i -e 's|setName(QStringLiteral("#konversation")|setName(QStringLiteral("#kaosx")|' src/config/preferences.cpp
}

do_build() {
  mkdir -p build
  cd build
  
  cmake ../${pkg_name}-${_pkg_version} \
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
