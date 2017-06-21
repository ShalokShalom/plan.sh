pkg_origin=

# include global config
source ../_buildscripts/${current_repo}-${_arch}-cfg.conf

pkg_name=kaccounts-integration
pkg_version=${_kdever}
pkg_description="System to administer web accounts for the sites and services across the KDE desktop, 
        including: Google, Facebook, Owncloud, IMAP, Jabber and others"
pkg_upstream_url="https://projects.kde.org/projects/kdereview/kaccounts-integration"
pkg_license=('GPL')
pkg_deps=('kcmutils' 'kio' 'ki18n' 'kwidgetsaddons' 'kcoreaddons' 
         'kiconthemes' 'kconfig' 'kwallet' 'kdbusaddons' 'accountsqt' 'signonqt' 'akonadi')
pkg_build_deps=('extra-cmake-modules' 'kdoctools')
pkg_source=("$_mirror/${pkg_name}-${pkg_version}.tar.xz")
       #'createaccount.diff')
pkg_shasum=(`grep ${pkg_name}-$_kdever.tar.xz ../kde-sc.md5 | cut -d" " -f1`)

prepare () {
  cd ${CACHE_PATH}/${pkg_name}-${pkg_version}

  #patch -p1 -i ${CACHE_PATH}/createaccount.diff
}    

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
