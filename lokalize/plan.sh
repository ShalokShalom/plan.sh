pkg_origin=

# include global config
source ../_buildscripts/${current_repo}-${_arch}-cfg.conf

pkg_name=lokalize
pkg_version=${_kdever}
pkg_description="Computer-aided translation"
pkg_upstream_url="https://projects.kde.org/projects/kde/kdesdk/lokalize"
pkg_license=('LGPL')
pkg_deps=('hunspell' 'kconfig' 'kcoreaddons' 'ki18n' 'kio' 'knotifications' 'kross' 'kxmlgui' 'sonnet')
pkg_build_deps=('extra-cmake-modules' 'kdoctools')
pkg_source=("$_mirror/${pkg_name}-$_kdever.tar.xz")
pkg_shasum=(`grep ${pkg_name}-$_kdever.tar.xz ../kde-sc.md5 | cut -d" " -f1`)

do_prepare() {
  cd ${pkg_name}-${pkg_version}
  
  #sed -i 's|hunspell-1.2|hunspell-1.6|g' cmake/FindHUNSPELL.cmake
  
}

do_build() {
  mkdir build
  cd build
  
  cmake ../${pkg_name}-${pkg_version} \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_LIBDIR=lib \
    -DKDE_INSTALL_SYSCONFDIR=/etc \
    -DKDE_INSTALL_QMLDIR=/usr/lib/qt5/qml \
    -DKDE_INSTALL_PLUGINDIR=/usr/lib/qt5/plugins \
    -DKDE_INSTALL_USE_QT_SYS_PATHS=ON \
    -DBUILD_TESTING=OFF 
  make
}

do_package() {
  cd build
  
  make DESTDIR="$pkg_prefix" install
}
