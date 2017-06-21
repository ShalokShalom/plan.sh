pkg_origin=

# include global config
source ../_buildscripts/${current_repo}-${_arch}-cfg.conf

pkg_name=kipi-plugins
#pkg_version=${_kdever}
pkg_version=4.80.14
pkg_description="Collection of plugins extending the KDE graphics and image applications as digiKam, Gwenview, and KPhotoalbum."
pkg_upstream_url="https://projects.kde.org/projects/extragear/graphics/kipi-plugins"
pkg_license=('GPL' 'LGPL' 'FDL')
pkg_deps=('kparts' 'kconfig' 'kiconthemes' 'kwindowsystem' 'kxmlgui' 'kio' 'kservice'
         'threadweaver' 'karchive' 'ki18n' 'libkexiv2' 'libkdcraw' 'libkipi' 'libkgeomap' 
         'libkvkontakte' 'libmediawiki' 'libtiff'
         'kcalcore' 'kwallet' 'phonon-qt5') # 'libkface') 
pkg_build_deps=('extra-cmake-modules' 'kdoctools' 'git' 'boost')
optpkg_deps=('enblend-enfuse: to work with the panorama tool')
install=${pkg_name}.install
#pkg_source=("$_mirror/${_pkg_name}-$_kdever.tar.xz")
#pkg_shasum=(`grep ${_pkg_name}-$_kdever.tar.xz ../kde-sc.md5 | cut -d" " -f1`)
pkg_source=("git://anongit.kde.org/kipi-plugins.git"
        'qt5.5.diff')
pkg_shasum=('SKIP'
         '52f868edadb83a19a81da93fdd8d3ec1')

do_prepare() {
  cd $pkg_name
  #patch -p1 -i $CACHE_PATH/qt5.5.diff
  #sed -i -e 's|#include <MediaWiki/Login>|#include <MediaWiki/login.h>|' ${CACHE_PATH}/${pkg_name}/mediawiki/plugin_wikimedia.h
}

do_build() {
  mkdir -p build
  cd build
  
  cmake ../${pkg_name} \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DLIB_INSTALL_DIR=lib \
    -DPLUGIN_INSTALL_DIR=/usr/lib/qt5/plugins \
    -DKDE_INSTALL_USE_QT_SYS_PATHS=ON \
    -DBUILD_TESTING=OFF 
  make
}

do_package() {
  cd build

  make DESTDIR=${pkg_prefix} install
}

