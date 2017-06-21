pkg_origin=

# include global config
source ../_buildscripts/${current_repo}-${_arch}-cfg.conf

pkg_name=plasma-framework
pkg_version=${_kf5ver}
pkg_description='Plasma library and runtime components based upon KF5 and Qt5'
pkg_upstream_url='https://github.com/KDE/plasma-framework'
pkg_license=('LGPL')
pkg_deps=('kactivities' 'karchive' 'kconfig' 'kconfigwidgets' 'kcoreaddons' 'kdbusaddons' 'kdeclarative' 'kglobalaccel'
         'kguiaddons' 'ki18n' 'kiconthemes' 'kio' 'kservice' 'kwindowsystem' 'kxmlgui' 'knotifications' 'kpackage'
         'kwayland' 'qt5-quickcontrols')
pkg_build_deps=('extra-cmake-modules' 'kdoctools')
pkg_source=("http://download.kde.org/stable/frameworks/5.19/${pkg_name}-${pkg_version}.tar.xz")
pkg_shasum=(`grep ${pkg_name}-${_kf5ver}.tar.xz ../kf5.md5 | cut -d" " -f1`)

do_prepare() {
  cd ${pkg_name}-${pkg_version}
  # https://bugs.kde.org/show_bug.cgi?id=377441
  #patch -p1 -i ${CACHE_PATH}/547a34d346695295ce05499ae355203414412993.diff
}

do_build() {
  mkdir -p build
  cd build
  
  cmake ../${pkg_name}-${pkg_version} \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DKDE_INSTALL_LIBDIR=lib \
    -DKDE_INSTALL_QMLDIR=/usr/lib/qt5/qml \
    -DKDE_INSTALL_PLUGINDIR=/usr/lib/qt5/plugins \
    -DBUILD_TESTING=OFF
  make
}

do_package() {
  cd build
  
  make DESTDIR=${pkg_prefix} install
}
