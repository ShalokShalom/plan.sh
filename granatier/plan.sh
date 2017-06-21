pkg_origin=

# include global config
source ../_buildscripts/${current_repo}-${_arch}-cfg.conf

pkg_name=granatier
pkg_version=${_kdever}
pkg_description="Granatier is a clone of the classic Bomberman game, inspired by the work of the Clanbomber clone"
pkg_upstream_url='https://projects.kde.org/projects/kde/kdegames/granatier'
pkg_license=('GPL' 'LGPL' 'FDL')
pkg_deps=('libkdegames' 'kcoreaddons' 'kconfig' 'kwidgetsaddons' 'ki18n' 'kguiaddons' 'kconfigwidgets' 'kitemviews'
         'kiconthemes' 'kxmlgui' 'kio' 'knewstuff' 'knotifyconfig')
pkg_build_deps=('pkg-config' 'extra-cmake-modules' 'kdoctools')
pkg_source=("$_mirror/${pkg_name}-$_kdever.tar.xz")
pkg_shasum=(`grep ${pkg_name}-$_kdever.tar.xz ../kde-sc.md5 | cut -d" " -f1`)
#pkg_source=("git://anongit.kde.org/granatier#branch=frameworks")
#pkg_shasum=('SKIP')

do_build() {
  mkdir -p build
  cd build

  cmake ../${pkg_name}-${pkg_version} \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DLIB_INSTALL_DIR=lib \
    -DSYSCONF_INSTALL_DIR=/etc \
    -DQML_INSTALL_DIR=/usr/lib/qt5/qml \
    -DPLUGIN_INSTALL_DIR=/usr/lib/qt5/plugins \
    -DBUILD_TESTING=OFF 
  make
}

do_package() {
  cd build

  make DESTDIR=${pkg_prefix} install
}
