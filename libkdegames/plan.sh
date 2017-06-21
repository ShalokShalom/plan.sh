pkg_origin=

# include global config
source ../_buildscripts/${current_repo}-${_arch}-cfg.conf

pkg_name=libkdegames
pkg_version=${_kdever}
pkg_description="Shared libraries for KDE games"
pkg_upstream_url='http://www.kde.org'
pkg_license=('GPL' 'LGPL' 'FDL')
pkg_deps=('kcoreaddons' 'kwidgetsaddons' 'kcodecs' 'karchive' 'kconfig' 'kdbusaddons' 'kdnssd' 'kdeclarative'
         'ki18n' 'kguiaddons' 'kservice' 'kconfigwidgets' 'kitemviews' 'kiconthemes' 'kcompletion' 'kjobwidgets'
         'ktextwidgets' 'kglobalaccel' 'kxmlgui' 'kcrash' 'kbookmarks' 'kio' 'knewstuff' 'kdelibs4support'
         'libsndfile' 'openal')
pkg_build_deps=('pkg-config' 'extra-cmake-modules' 'kdoctools' 'git')
	   'kdegames-bomber'
	   'kdegames-kapman'
	   'kdegames-katomic'
	   'kdegames-kblackbox'
	   'kdegames-kblocks'
	   'kdegames-kbreakout'
	   'kdegames-kdiamond'
	   'kdegames-kigo'
	   'kdegames-kgoldrunner'
	   'kdegames-killbots'
	   'kdegames-kjumpingcube'
	   'kdegames-klickety'
	   'kdegames-klines'
	   'kdegames-knetwalk'
	   'kdegames-kolf'
	   'kdegames-kollision'
	   'kdegames-konquest'
	   'kdegames-kreversi'
	   'kdegames-kshisen'
	   'kdegames-ksirk'
	   'kdegames-kspaceduel'
	   'kdegames-ksquares'
	   'kdegames-ksudoku'
	   'kdegames-ksnakeduel'
	   'kdegames-kubrick'
	   'kdegames-lskat'
	   'kdegames-palapeli'
	   'kdegames-picmi')
	   'kdegames-libkmahjongg'
	   'kdegames-bomber'
	   'kdegames-kapman'
	   'kdegames-katomic'
	   'kdegames-kblackbox'
	   'kdegames-kblocks'
	   'kdegames-kbreakout'
	   'kdegames-kdiamond'
	   'kdegames-kigo'
	   'kdegames-kgoldrunner'
	   'kdegames-killbots'
	   'kdegames-kjumpingcube'
	   'kdegames-klickety'
	   'kdegames-klines'
	   'kdegames-knetwalk'
	   'kdegames-kolf'
	   'kdegames-kollision'
	   'kdegames-konquest'
	   'kdegames-kreversi'
	   'kdegames-kshisen'
	   'kdegames-ksirk'
	   'kdegames-kspaceduel'
	   'kdegames-ksquares'
	   'kdegames-ksudoku'
	   'kdegames-ksnakeduel'
	   'kdegames-kubrick'
	   'kdegames-lskat'
	   'kdegames-palapeli'
	   'kdegames-picmi')
pkg_source=("$_mirror/${pkg_name}-$_kdever.tar.xz")
pkg_shasum=(`grep ${pkg_name}-$_kdever.tar.xz ../kde-sc.md5 | cut -d" " -f1`)

do_build() {
  cd ${CACHE_PATH}
  #sed -e "s/Qt5::core/Qt5::core KF5::KWidgetsAddons/" -i ${CACHE_PATH}/$pkg_name/libkdegames/CMakeLists.txt
  
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
