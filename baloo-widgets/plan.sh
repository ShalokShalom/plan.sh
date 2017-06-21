pkg_origin=

# include global config
source ../_buildscripts/${current_repo}-${_arch}-cfg.conf

pkg_name=baloo-widgets
pkg_version=${_kdever}
pkg_description="Widgets for the baloo framework for searching and managing metadata"
pkg_upstream_url='https://projects.kde.org/projects/kde/kdelibs/baloo'
pkg_license=('LGPL')
pkg_deps=('baloo' 'kdelibs4support' 'kemoticons')
pkg_build_deps=('extra-cmake-modules' 'kdoctools')
pkg_source=($_mirror/${pkg_name}-$_kdever.tar.xz)
pkg_shasum=(`grep ${pkg_name}-$_kdever.tar.xz ../kde-sc.md5 | cut -d" " -f1`)

do_prepare() {
  cd $_pkg_name
  #sed -i -e 's|#include <baloo/completionproposal.h>||' ${CACHE_PATH}/${_pkg_name}/src/querybuilder.cpp
}

do_build() {
  mkdir -p build
  cd build
  
  cmake ../${pkg_name}-${pkg_version} \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DSYSCONF_INSTALL_DIR=/etc \
    -DPLUGIN_INSTALL_DIR=/usr/lib/qt5/plugins \
    -DKDE_INSTALL_USE_QT_SYS_PATHS=ON \
    -DLIB_INSTALL_DIR=lib
  make
}

do_package() {
  cd build

  make DESTDIR=${pkg_prefix} install
}
