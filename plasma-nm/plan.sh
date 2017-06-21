pkg_origin=


# include global config
source ../_buildscripts/${current_repo}-${_arch}-cfg.conf

pkg_name=plasma-nm
pkg_version=${_plasmaver}
pkg_description="Plasma applet written in QML for managing network connections"
pkg_upstream_url="https://github.com/KDE/plasma-nm"
pkg_license=('GPL')
pkg_deps=('modemmanager-qt' 'networkmanager-qt' 'ki18n' 'kwindowsystem' 'kservice' 'kcompletion' 'kwidgetsaddons'
         'kio' 'kcoreaddons' 'kwallet' 'kitemviews' 'kxmlgui' 'kconfigwidgets' 'kiconthemes' 'solid'
         'kdbusaddons' 'knotifications' 'kdeclarative' 'kinit' 'kdelibs4support' 'plasma-framework' 
         'mobile-broadband-provider-info' 'openconnect' 'qca-qt5')
pkg_build_deps=('extra-cmake-modules' 'kdoctools' 'qt5-tools')
#pkg_source=("http://download.kde.org/stable/plasma/$pkg_version/$pkg_name-$pkg_version.tar.xz")
pkg_source=("${pkg_name}-${pkg_version}.tar.gz::https://github.com/KDE/${pkg_name}/archive/${_branch}.tar.gz")
pkg_shasum=(`grep ${pkg_name}-${_plasmaver}.tar.gz ../kf5.md5 | cut -d" " -f1`)

do_build() {
  cd ${pkg_name}-${__pkg_version}
  #patch -p1 -i ${CACHE_PATH}/c5eb19bb44c8b10d848628557405b597b680bbe8.diff
  sed -i 's|X-KDE-System-Settings-Parent-Category=network|X-KDE-System-Settings-Parent-Category=connectivity|' kcm/kcm_networkmanagement.desktop
  
  mkdir build
  
  cd build
  cmake -DCMAKE_INSTALL_PREFIX=/usr \
        -DCMAKE_BUILD_TYPE=Release \
        -DKDE_INSTALL_LIBDIR=lib \
        -DKDE_INSTALL_SYSCONFDIR=/etc \
        -DKDE_INSTALL_QMLDIR=/usr/lib/qt5/qml \
        -DKDE_INSTALL_PLUGINDIR=/usr/lib/qt5/plugins \
        -DBUILD_TESTING=OFF ..
  make
}

do_package() {
  cd ${pkg_name}-${__pkg_version}/build
  
  make DESTDIR=${pkg_prefix} install
}
