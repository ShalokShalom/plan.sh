pkg_origin=

# include global config
source ../_buildscripts/${current_repo}-${_arch}-cfg.conf

pkg_name=kio-extras
pkg_version=${_kdever}
pkg_description='Additional components to increase the functionality of KIO'
pkg_upstream_url='https://github.com/KDE/kio-extras'
pkg_license=('LGPL')
pkg_deps=('exiv2' 'karchive' 'kconfig' 'kconfigwidgets' 'kcoreaddons' 'kdbusaddons' 'kdnssd' 'kiconthemes' 'ki18n'
         'kio' 'kdelibs4support' 'kpty' 'solid' 'kbookmarks' 'kguiaddons' 'kactivities' 
         'libmtp' 'libssh' 'openexr' 'samba' 'qtwebengine' 'qt5-location')
pkg_build_deps=('extra-cmake-modules' 'kdoctools' 'openslp' 'khtml' 'gperf')
pkg_source=("http://download.kde.org/stable/applications/${pkg_version}/src/${pkg_name}-${pkg_version}.tar.xz")
pkg_shasum=(`grep ${pkg_name}-$_kdever.tar.xz ../kde-sc.md5 | cut -d" " -f1`)

do_prepare() {
  cd ${pkg_name}-${pkg_version}
  # fix mtp device detection, window phones in particular
  #patch -p1 -i ${CACHE_PATH}/cba927613b6da1b36ecbd5cfadfff3bff8729f86.diff
}

do_build() {
  mkdir -p build
  cd build
  
  cmake ../${pkg_name}-${pkg_version} \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DKDE_INSTALL_LIBDIR=lib \
    -DKDE_INSTALL_SYSCONFDIR=/etc \
    -DKDE_INSTALL_PLUGINDIR=/usr/lib/qt5/plugins \
    -DKDE_INSTALL_USE_QT_SYS_PATHS=ON \
    -DBUILD_TESTING=OFF
  make
}

do_package() {
  cd build
  
  make DESTDIR=${pkg_prefix} install
}
