pkg_origin=

# include global config
source ../_buildscripts/${current_repo}-${_arch}-cfg.conf

pkg_name=okteta
pkg_version=${_kdever}
pkg_description="KDE hex editor for viewing and editing the raw data of files"
pkg_upstream_url="https://projects.kde.org/projects/kde/kdesdk/okteta"
pkg_license=('LGPL')
pkg_deps=('kcmutils' 'kcodecs' 'kcompletion' 'kconfigwidgets' 'kdbusaddons' 'ki18n' 'knewstuff' 
         'kparts' 'kservice' 'kwidgetsaddons' 'kxmlgui' 'qca-qt5' 'qt5-tools')
pkg_build_deps=('extra-cmake-modules' 'kdoctools')
pkg_source=("$_mirror/${pkg_name}-$_kdever.tar.xz")
pkg_shasum=(`grep ${pkg_name}-$_kdever.tar.xz ../kde-sc.md5 | cut -d" " -f1`)

do_build() {
  cd $pkg_name-${pkg_version}
  mkdir build
  
  cd build
  cmake -DCMAKE_INSTALL_PREFIX=/usr \
        -DCMAKE_BUILD_TYPE=Release \
        -DKDE_INSTALL_LIBDIR=lib \
        -DKDE_INSTALL_SYSCONFDIR=/etc \
        -DKDE_INSTALL_QMLDIR=/usr/lib/qt5/qml \
        -DKDE_INSTALL_PLUGINDIR=/usr/lib/qt5/plugins \
        -DKDE_INSTALL_USE_QT_SYS_PATHS=ON \
        -DBUILD_TESTING=OFF ..
  make
}

do_package() {
  cd $pkg_name-${pkg_version}/build
  
  make DESTDIR=${pkg_prefix} install
}
