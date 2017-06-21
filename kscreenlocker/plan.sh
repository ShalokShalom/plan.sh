pkg_origin=

# include global config
source ../_buildscripts/${current_repo}-${_arch}-cfg.conf

pkg_name=kscreenlocker
pkg_version=${_plasmaver}
pkg_description="Library and components for secure lock screen architecture."
pkg_upstream_url="https://projects.kde.org/projects/kde/workspace/kscreenlocker"
pkg_license=('GPL' 'LGPL' 'FDL')
pkg_deps=('plasma-framework' 'kcmutils' 'kdeclarative' 'kidletime' 'kdelibs4support' 'kcrash'
         'kglobalaccel' 'kwayland')
pkg_build_deps=('extra-cmake-modules' 'kdoctools')
#pkg_source=("http://download.kde.org/stable/plasma/${pkg_version}/${pkg_name}-${pkg_version}.tar.xz")
pkg_source=("${pkg_name}-${pkg_version}.tar.gz::https://github.com/KDE/${pkg_name}/archive/${_branch}.tar.gz"
        'locker.diff')
pkg_shasum=(`grep ${pkg_name}-${_plasmaver}.tar.gz ../kf5.md5 | cut -d" " -f1`
         '3681afa59a52f9b17345bf9345c8cef6')

do_prepare() {
  cd $pkg_name-${__pkg_version}
  #sed -i -e 's|#include "ui_module.h"||' ${CACHE_PATH}/${pkg_name}/src/kcm/module.cpp
  #patch -p1 -i ${CACHE_PATH}/locker.diff
}

do_build() {
  mkdir build
  
  cd build 
  cmake ../${pkg_name}-${__pkg_version} \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_SKIP_RPATH=ON \
    -DKDE_INSTALL_LIBDIR=lib \
    -DKDE_INSTALL_LIBEXECDIR=/usr/lib \
    -DKDE_INSTALL_QMLDIR=/usr/lib/qt5/qml \
    -DKDE_INSTALL_PLUGINDIR=/usr/lib/qt5/plugins \
    -DBUILD_TESTING=OFF 
  make 
}

do_package() {
  cd build
  
  make DESTDIR=${pkg_prefix} install
}
