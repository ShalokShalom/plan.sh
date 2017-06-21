pkg_origin=

# include global config
source ../_buildscripts/${current_repo}-${_arch}-cfg.conf

pkg_name=kshisen
pkg_version=${_kdever}
pkg_description="Shisen-Sho Tile Game"
pkg_upstream_url='http://www.kde.org'
pkg_license=('GPL' 'LGPL' 'FDL')
pkg_deps=('libkdegames' 'libkmahjongg' 'phonon-qt5')
pkg_build_deps=('pkg-config' 'extra-cmake-modules' 'kdoctools')
pkg_source=("$_mirror/${pkg_name}-$_kdever.tar.xz")
pkg_shasum=(`grep ${pkg_name}-$_kdever.tar.xz ../kde-sc.md5 | cut -d" " -f1`)

do_build() {
  cd ${CACHE_PATH}
  
  mkdir build
  cd build
  
  cmake ../${pkg_name}-${pkg_version} \
    -DCMAKE_BUILD_TYPE=RelWithDebInfo \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DCMAKE_INSTALL_LIBDIR=lib \
    -DPLUGIN_INSTALL_DIR=/usr/lib/qt5/plugins \
    -DKDE_INSTALL_USE_QT_SYS_PATHS=ON 
  make
}

do_package() {
  cd ${CACHE_PATH}/build
  
  make DESTDIR=${pkg_prefix} install
}
