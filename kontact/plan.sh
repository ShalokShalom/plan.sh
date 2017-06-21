pkg_origin=

# include global config
source ../_buildscripts/${current_repo}-${_arch}-cfg.conf

pkg_name=kontact
pkg_version=${_kdever}
pkg_description="Container application to unify several major PIM applications within one application."
pkg_upstream_url='https://github.com/KDE/kontacts'
pkg_license=('LGPL')
pkg_deps=('kdbusaddons' 'kcmutils' 'kcrash' 'kwindowsystem' 'kiconthemes' 
         'kpimtextedit' 'akonadi' 'kontactinterface' 'mailcommon' 'libkdepim' 'grantleetheme' 'kdepim-apps-libs'
         'qtwebengine'
         'akonadi-import-wizard' 'pim-data-exporter')
pkg_build_deps=('extra-cmake-modules' 'kdoctools' 'boost')
pkg_source=($_mirror/${pkg_name}-${_kdever}.tar.xz)
pkg_shasum=(`grep ${pkg_name}-${_kdever}.tar.xz ../kde-sc.md5 | cut -d" " -f1`)

do_build() {
  mkdir build
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
