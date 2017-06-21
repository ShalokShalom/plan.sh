pkg_origin=

# include global config
source ../_buildscripts/${current_repo}-${_arch}-cfg.conf

pkg_name=rocs
pkg_version=${_kdever}
pkg_description="Rocs Graph Theory"
pkg_upstream_url="https://kde.org/applications/education/rocs/"
pkg_license=('GPL' 'LGPL' 'FDL')
pkg_deps=('boost-libs' 'kconfig' 'kcoreaddons' 'kdeclarative' 'ki18n' 'kitemviews' 'ktexteditor' 'kxmlgui'
         'kservice' 'qt5-webkit' 'grantlee')
pkg_build_deps=('extra-cmake-modules' 'kdoctools' 'boost')
pkg_source=("$_mirror/${pkg_name}-$_kdever.tar.xz")
pkg_shasum=(`grep ${pkg_name}-$_kdever.tar.xz ../kde-sc.md5 | cut -d" " -f1`)

do_build() {
  mkdir -p build
  cd build
  
  cmake ../${pkg_name}-${pkg_version} \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DKDE_INSTALL_LIBDIR=lib \
    -DKDE_INSTALL_PLUGINDIR=/usr/lib/qt5/plugins \
    -DKDE_INSTALL_USE_QT_SYS_PATHS=ON \
    -DBUILD_TESTING=OFF 
  make
}

do_package() {
  cd build

  make DESTDIR=${pkg_prefix} install
}
