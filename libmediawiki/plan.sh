pkg_origin=

# include global config
source ../_buildscripts/${current_repo}-${_arch}-cfg.conf

pkg_name=libmediawiki
#pkg_version=${_kdever}
pkg_version=0.1.0
_commit=3df0a45d1d60a8045b46e4b3158ca60470268f45
pkg_description="KDE C++ interface for MediaWiki based web service as wikipedia.org"
pkg_upstream_url="https://github.com/KDE/libmediawiki"
pkg_license=('GPL' 'LGPL' 'FDL')
pkg_deps=('kcoreaddons')
pkg_build_deps=('extra-cmake-modules' 'kdoctools')
#pkg_source=("$_mirror/${_pkg_name}-$_kdever.tar.xz")
#pkg_shasum=(`grep ${_pkg_name}-$_kdever.tar.xz ../kde-sc.md5 | cut -d" " -f1`)
pkg_source=("https://github.com/KDE/libmediawiki/archive/${_commit}.zip")
pkg_shasum=('8ccf5ea1c50f67707a297c15eaa5239b')

do_prepare() {
  cd ${pkg_name}-${_commit}
  #patch -p1 -i $CACHE_PATH/qt5.5.diff
  #sed -i -e 's|#include <libkdcraw/kdcraw.h|#include <kdcraw.h|' ${CACHE_PATH}/${pkg_name}/panorama/tasks/preprocesstask.h
}

do_build() {
  mkdir -p build
  cd build
  
  cmake ../${pkg_name}-${_commit} \
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

