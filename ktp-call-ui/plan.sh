pkg_origin=

# include global config
source ../_buildscripts/${current_repo}-${_arch}-cfg.conf

pkg_name=ktp-call-ui
pkg_version=${_kdever}
pkg_description="Telepathy call handler "
pkg_upstream_url="http://www.kde.org"
pkg_license=('GPL')
pkg_deps=('kconfig' 'kdeclarative' 'kiconthemes' 'ki18n' 'knotifications' 'kxmlgui' 'kcmutils'
         'ktp-common-internals' 'telepathy-farstream'
         'telepathy-mission-control' 'telepathy-gabble' 'gst-plugins-base'
         'gst-plugins-good' 'qt5-gstreamer' 'gst-libav')
pkg_build_deps=('boost' 'extra-cmake-modules' 'kdoctools')
pkg_source=("$_mirror/${pkg_name}-${_kdever}.tar.xz")
pkg_shasum=(`grep " ${pkg_name}-${_kdever}.tar.xz" ../kde-sc.md5 | cut -d" " -f1`)

do_prepare() {
  cd $pkg_name-${pkg_version}
  #sed -i -e 's|#include <phonon/Global>|#include <phonon4qt5/phonon/Global>|' ${CACHE_PATH}/${pkg_name}/libktpcall/private/phonon-integration.h
  #sed -i -e 's|#include <phonon/ObjectDescription>|#include <phonon4qt5/phonon/ObjectDescription>|' ${CACHE_PATH}/${pkg_name}/libktpcall/private/phonon-integration.h
}

do_build() {
  mkdir -p build
  cd build

  cmake ../${pkg_name}-${pkg_version} \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DKDE_INSTALL_LIBDIR=lib \
    -DKDE_INSTALL_LIBEXECDIR=lib \
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
