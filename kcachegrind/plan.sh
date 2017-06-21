pkg_origin=

# include global config
source ../_buildscripts/${current_repo}-${_arch}-cfg.conf

pkg_name=kcachegrind
pkg_version=${_kdever}
pkg_description='Visualization of Performance Profiling Data'
pkg_upstream_url='http://kde.org/applications/development/kcachegrind/'
pkg_license=('GPL' 'LGPL' 'FDL')
pkg_deps=('kcoreaddons' 'kwidgetsaddons' 'kxmlgui' 'ki18n' 'kconfig' 'kio')
pkg_build_deps=('extra-cmake-modules' 'kdoctools' 'qt5-tools')
optpkg_deps=('php: PHP support')
pkg_source=("$_mirror/${pkg_name}-${_kdever}.tar.xz")
pkg_shasum=(`grep ${pkg_name}-${_kdever}.tar.xz ../kde-sc.md5 | cut -d" " -f1`)

do_build() {
  mkdir -p build
  
  cd build 
  cmake ../${pkg_name}-${pkg_version} \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_SKIP_RPATH=ON \
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
