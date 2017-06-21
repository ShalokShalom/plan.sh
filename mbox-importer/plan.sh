pkg_origin=

# include global config
source ../_buildscripts/${current_repo}-${_arch}-cfg.conf

pkg_name=mbox-importer
pkg_version=${_kdever}
pkg_description="Wizard to assist with importing MBox email archives into Akonadi."
pkg_upstream_url='https://github.com/KDE/mbox-importer'
pkg_license=('LGPL')
pkg_deps=('kconfig' 'kservice' 'kcrash' 'kio'
         'akonadi' 'mailcommon' 'mailimporter')
pkg_build_deps=('extra-cmake-modules' 'kdoctools' 'boost')
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
