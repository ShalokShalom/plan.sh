pkg_origin=

# include global config
source ../_buildscripts/${current_repo}-${_arch}-cfg.conf

pkg_name=akonadi-contacts
pkg_version=${_kdever}
pkg_description="Libraries and daemons to implement Contact Management in Akonadi."
pkg_upstream_url='https://github.com/KDE/akonadi-contacts'
pkg_license=('LGPL')
pkg_deps=('kio' 'kcompletion' 'kcodecs' 'grantlee' 'kcontacts' 'kcalcore' 
         'kmime' 'akonadi-mime' 'akonadi' 'prison' 'qtwebengine' 'qt5-location')
pkg_build_deps=('extra-cmake-modules' 'kdoctools' 'boost')
pkg_source=($_mirror/${pkg_name}-${_kdever}.tar.xz)
pkg_shasum=(`grep ${pkg_name}-${_kdever}.tar.xz ../kde-sc.md5 | cut -d" " -f1`)

do_prepare() {
  cd $pkg_name-${pkg_version}
  #sed -i -e 's/${DATA_INSTALL_DIR}/${KXMLGUI_INSTALL_DIR}/' ${CACHE_PATH}/${pkg_name}/src/CMakeLists.txt
}

do_build() {
  cd ${CACHE_PATH}

  mkdir build
  
  cd build 
  cmake ../${pkg_name}-${pkg_version} \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_SKIP_RPATH=ON \
    -DCMAKE_INSTALL_LIBDIR=lib \
    -DKDE_INSTALL_USE_QT_SYS_PATHS=ON \
    -DKDE_INSTALL_QMLDIR=/usr/lib/qt5/qml \
    -DKDE_INSTALL_PLUGINDIR=/usr/lib/qt5/plugins \
    -DBUILD_TESTING=OFF 
  make 
}

do_package() {
  cd ${CACHE_PATH}/build
  
  make DESTDIR=${pkg_prefix} install
}
