pkg_origin=

# include global config
source ../_buildscripts/${current_repo}-${_arch}-cfg.conf

pkg_name=kde-dev-utils
pkg_version=${_kdever}
pkg_description='Small utilities for developers using KDE/Qt libs/frameworks'
pkg_upstream_url='https://github.com/KDE/kde-dev-utils'
pkg_license=('GPL2' 'LGPL' 'FDL')
pkg_deps=('kcoreaddons' 'kjobwidgets' 'kio' 'ki18n' 'kparts' 'kwidgetsaddons')
pkg_build_deps=('extra-cmake-modules' 'qt5-tools')
pkg_source=("$_mirror/${pkg_name}-${_kdever}.tar.xz")
pkg_shasum=(`grep ${pkg_name}-${_kdever}.tar.xz ../kde-sc.md5 | cut -d" " -f1`)

do_build() {
  mkdir -p build
  cd build
  
  cmake ../${pkg_name}-${pkg_version} \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=/usr
  make
}

do_package() {
  cd build
  
  make DESTDIR=${pkg_prefix} install
}
