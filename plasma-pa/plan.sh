pkg_origin=

# include global config
source ../_buildscripts/${current_repo}-${_arch}-cfg.conf

pkg_name=plasma-pa
pkg_version=${_plasmaver}
pkg_description="PulseAudio based volume control Plasma widget."
pkg_upstream_url="https://projects.kde.org/projects/kdereview/plasma-pa"
pkg_license=('GPL' 'LGPL' 'FDL')
pkg_deps=('kconfigwidgets' 'kcoreaddons' 'ki18n' 'kdeclarative' 'plasma-framework' 'pulseaudio' 'glib2'
         'libcanberra' 'gconf')
pkg_build_deps=('pkg-config' 'extra-cmake-modules' 'kdoctools')
#pkg_source=($_mirror/${pkg_name}-${pkg_version}.tar.xz)
pkg_source=("${pkg_name}-${pkg_version}.tar.gz::https://github.com/KDE/${pkg_name}/archive/${_branch}.tar.gz"
        'pa-streams-applet.diff')
pkg_shasum=(`grep ${pkg_name}-${_plasmaver}.tar.gz ../kf5.md5 | cut -d" " -f1`
         '0b95d0c6577e976d391394bdfb74267f')

do_prepare() {
  cd ${pkg_name}-${__pkg_version}
  #patch -p1 -i ${CACHE_PATH}/pa-streams-applet.diff
  #sed -i -e 's|#include "ui_module.h"||' ${CACHE_PATH}/${pkg_name}/src/kcm/module.cpp
}

do_build() {
  mkdir -p build
  cd build 
  
  cmake ../${pkg_name}-${__pkg_version} \
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
