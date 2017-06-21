pkg_origin=

# include global config
source ../_buildscripts/${current_repo}-${_arch}-cfg.conf

pkg_name=kmail-account-wizard
pkg_version=${_kdever}
pkg_description="Application which assists you with the configuration of accounts in KMail."
pkg_upstream_url='https://github.com/KDE/kmail-account-wizard'
pkg_license=('LGPL')
pkg_deps=('kwallet' 'kcmutils' 'knotifyconfig' 'kconfig' 'kservice' 'kdbusaddons' 'ktexteditor' 'kcodecs' 
         'kcrash' 'knotifications' 'kross' 'knewstuff'
         'kpimtextedit' 'akonadi' 'kcontacts' 'akonadi-contacts' 'kidentitymanagement' 'kldap'
         'kmailtransport' 'mailcommon' 'messagelib' 'pimcommon' 'libkdepim' 'libkleo')
pkg_build_deps=('extra-cmake-modules' 'kdoctools' 'boost' 'qt5-tools')
pkg_source=($_mirror/${pkg_name}-${_kdever}.tar.xz)
pkg_shasum=(`grep ${pkg_name}-${_kdever}.tar.xz ../kde-sc.md5 | cut -d" " -f1`)

do_build() {
  mkdir -p build
  cd build 
  
  cmake ../${pkg_name}-${pkg_version} \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_LIBDIR=lib \
    -DKDE_INSTALL_USE_QT_SYS_PATHS=ON \
    -DKDE_INSTALL_QMLDIR=/usr/lib/qt5/qml \
    -DKDE_INSTALL_PLUGINDIR=/usr/lib/qt5/plugins \
    -DBUILD_TESTING=OFF 
  make 
}

do_package() {
  cd build
  
  make DESTDIR=${pkg_prefix} install
}
