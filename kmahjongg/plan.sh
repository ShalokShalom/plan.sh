pkg_origin=

# include global config
source ../_buildscripts/${current_repo}-${_arch}-cfg.conf

pkg_name=kmahjongg
pkg_version=${_kdever}
#pkg_version=15.11.72
pkg_description="Tile matching game for one or two players"
pkg_upstream_url='https://projects.kde.org/projects/kde/kdegames/kmahjongg'
pkg_license=('GPL' 'LGPL' 'FDL')
pkg_deps=('kcoreaddons' 'kxmlgui' 'kconfig' 'kio' 'kdnssd' 'knewstuff' 'kdeclarative'
         'kdelibs4support' 'libkdegames' 'libkmahjongg')
pkg_build_deps=('pkg-config' 'extra-cmake-modules' 'kdoctools' 'git')
pkg_source=("$_mirror/${pkg_name}-${_kdever}.tar.xz")
pkg_shasum=(`grep " ${pkg_name}-${_kdever}.tar.xz" ../kde-sc.md5 | cut -d" " -f1`)
#pkg_source=("git://anongit.kde.org/kmahjongg.git")
#pkg_shasum=('SKIP')

do_build() {
  cd ${CACHE_PATH}
  
  mkdir -p build
  cd build

  cmake ../${pkg_name}-${pkg_version} \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DLIB_INSTALL_DIR=lib \
    -DSYSCONF_INSTALL_DIR=/etc \
    -DQML_INSTALL_DIR=/usr/lib/qt5/qml \
    -DPLUGIN_INSTALL_DIR=/usr/lib/qt5/plugins \
    -DKDE_INSTALL_USE_QT_SYS_PATHS=ON \
    -DBUILD_TESTING=OFF 
  make
}

do_package() {
  cd build

  make DESTDIR=${pkg_prefix} install
}
