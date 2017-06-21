pkg_origin=

# include global config
source ../_buildscripts/${current_repo}-${_arch}-cfg.conf

pkg_name=kfourinline
pkg_version=${_kdever}
pkg_description="Four-in-a-row Board Game"
pkg_upstream_url='https://projects.kde.org/projects/kde/kdegames/kfourinline'
pkg_license=('GPL' 'LGPL' 'FDL')
pkg_deps=('libkdegames' 'kcoreaddons' 'kconfig' 'kitemmodels' 'kdbusaddons' 'kdeclarative' 'ki18n' 'kconfigwidgets'
         'kitemviews' 'kiconthemes' 'kcompletion' 'kxmlgui' 'kdnssd' 'kio' 'knotifyconfig' 'kdelibs4support')
pkg_build_deps=('pkg-config' 'extra-cmake-modules' 'kdoctools')
pkg_source=("$_mirror/${pkg_name}-$_kdever.tar.xz")
pkg_shasum=(`grep ${pkg_name}-$_kdever.tar.xz ../kde-sc.md5 | cut -d" " -f1`)

do_build() {
  mkdir build
  
  cd build 
  cmake ../${pkg_name}-${pkg_version} \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_SKIP_RPATH=ON \
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
