pkg_origin=

# include global config
source ../_buildscripts/${current_repo}-${_arch}-cfg.conf

pkg_name=korganizer
pkg_version=${_kdever}
pkg_description="Organizational assistant, providing calendars and other similar functionality to help you organize your life."
pkg_upstream_url='https://github.com/KDE/korganizer'
pkg_license=('LGPL')
pkg_deps=('knewstuff' 'kcmutils' 'kconfig' 'kservice' 'kdbusaddons' 'kcodecs' 'kcrash'  
         'kpimtextedit' 'akonadi' 'kcontacts' 'kcalcore' 'akonadi-contacts' 'kidentitymanagement'
         'kmailtransport' 'akonadi-mime' 'kcalutils' 'kholidays' 'kldap' 'akonadi-calendar' 'kontactinterface'
         'kmime' 'akonadi-notes' 'kdepim-apps-libs' 'pimcommon' 'libkdepim' 'incidenceeditor' 'calendarsupport'
         'eventviews' 'akonadi-search' 'kdepim-runtime'
         'phonon-qt5' 'qt5-x11extras' 'kdepim-addons'
         'akonadi-import-wizard' 'pim-data-exporter')
pkg_build_deps=('extra-cmake-modules' 'kdoctools' 'boost' 'qt5-tools')
pkg_source=($_mirror/${pkg_name}-${_kdever}.tar.xz)
pkg_shasum=(`grep ${pkg_name}-${_kdever}.tar.xz ../kde-sc.md5 | cut -d" " -f1`)

do_prepare() {
  cd $pkg_name-${pkg_version}
  #sed -i -e 's/${DATA_INSTALL_DIR}/${KXMLGUI_INSTALL_DIR}/' ${CACHE_PATH}/${pkg_name}/src/CMakeLists.txt
}

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
