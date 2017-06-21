pkg_origin=

# include global config
source ../_buildscripts/${current_repo}-${_arch}-cfg.conf

pkg_name=knavalbattle
pkg_version=${_kdever}
#pkg_version=15.07.70
pkg_description="Naval Battle"
pkg_upstream_url='http://www.kde.org'
pkg_license=('GPL' 'LGPL' 'FDL')
pkg_deps=('libkdegames' 'kcoreaddons' 'kconfig' 'kwidgetsaddons' 'kcodecs' 'karchive' 'kdbusaddons'
         'kdnssd' 'kdeclarative' 'ki18n' 'kguiaddons' 'kservice' 'kconfigwidgets' 'kitemviews' 'kiconthemes'
         'kcompletion' 'kjobwidgets' 'ktextwidgets' 'kglobalaccel' 'kxmlgui' 'kcrash' 'kbookmarks' 'kio'
         'knotifyconfig' 'knewstuff' 'kdelibs4support' 'phonon-qt5')
pkg_build_deps=('pkg-config' 'extra-cmake-modules' 'kdoctools')
pkg_source=("$_mirror/${pkg_name}-$_kdever.tar.xz")
pkg_shasum=(`grep ${pkg_name}-$_kdever.tar.xz ../kde-sc.md5 | cut -d" " -f1`)
#pkg_source=("git://anongit.kde.org/knavalbattle#branch=frameworks")
#pkg_shasum=('SKIP')

do_build() {
  cd ${CACHE_PATH}
  #sed -e "s/kdegames/KF5KDEGames/" -i ${CACHE_PATH}/$pkg_name/src/CMakeLists.txt
  
  mkdir -p build
  cd build

  cmake ../${pkg_name}-${pkg_version} \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DLIB_INSTALL_DIR=lib \
    -DSYSCONF_INSTALL_DIR=/etc \
    -DQML_INSTALL_DIR=/usr/lib/qt5/qml \
    -DKDE_INSTALL_USE_QT_SYS_PATHS=ON \
    -DBUILD_TESTING=OFF 
  make
}

do_package() {
  cd build

  make DESTDIR=${pkg_prefix} install
}
