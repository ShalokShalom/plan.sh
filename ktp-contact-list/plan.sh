pkg_origin=

# include global config
source ../_buildscripts/${current_repo}-${_arch}-cfg.conf

pkg_name=ktp-contact-list
pkg_version=${_kdever}
pkg_description="Telepathy contact list application "
pkg_upstream_url="http://www.kde.org"
pkg_license=('GPL')
pkg_deps=('kdbusaddons' 'kio' 'kcmutils' 'knotifyconfig' 'kdelibs4support' 'ktp-common-internals'
         'telepathy-qt5' 'kpeople')
pkg_build_deps=('extra-cmake-modules' 'kdoctools' 'git' 'boost')
#pkg_source=("ftp://mirrors.mit.edu/kde/stable/kde-telepathy/${pkg_version}/src/${pkg_name}-${pkg_version}.tar.bz2")
pkg_source=("$_mirror/${pkg_name}-$_kdever.tar.xz")
pkg_shasum=(`grep ${pkg_name}-$_kdever.tar.xz ../kde-sc.md5 | cut -d" " -f1`)

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
