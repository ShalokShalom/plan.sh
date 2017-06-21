pkg_origin=

# include global config
source ../_buildscripts/${current_repo}-${_arch}-cfg.conf

pkg_name=konqueror
pkg_version=${_kdever}
pkg_description="KDE File Manager & Web Browser"
pkg_upstream_url='https://github.com/KDE/konqueror'
pkg_license=('LGPL')
pkg_deps=('kparts' 'kcmutils' 'khtml' 'kdelibs4support' 'karchive' 'kcrash' 'kded' 'kactivities'
         'kwidgetsaddons' 'kiconthemes' 'kdesu' 'kio' 'ki18n' 'kfind' 'kdialog' 'keditbookmarks' 'kguiaddons'
         'tidyhtml' 'qtwebengine' 'qt5-location')
pkg_build_deps=('extra-cmake-modules' 'kdoctools')
pkg_source=("$_mirror/${pkg_name}-${_kdever}.tar.xz")
pkg_shasum=(`grep ${pkg_name}-${_kdever}.tar.xz ../kde-sc.md5 | cut -d" " -f1`)

do_prepare() {
  cd ${pkg_name}-${pkg_version}
  
  sed -i -e 's|#include <buffio.h>|#include <tidybuffio.h>|' plugins/validators/tidy_validator.cpp
  # fix browser crash with qtwebengine backend
  #patch -p1 -i ${CACHE_PATH}/4c6575a9852e3dfcf85bd849fa953dcc083029d9.diff
}

do_build() {
  mkdir -p build
  cd build
  
  cmake ../${pkg_name}-${pkg_version} \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DKDE_INSTALL_SYSCONFDIR=/etc \
    -DKDE_INSTALL_PLUGINDIR=/usr/lib/qt5/plugins \
    -DKDE_INSTALL_USE_QT_SYS_PATHS=ON \
    -DKDE_INSTALL_LIBDIR=lib
  make
}

do_package() {
  cd build

  make DESTDIR=${pkg_prefix} install
}
