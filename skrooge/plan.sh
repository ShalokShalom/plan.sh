pkg_origin=

pkg_name=skrooge
pkg_version=2.8.1
pkg_description="Allows you to manage your personal finances in KDE"
pkg_upstream_url="http://skrooge.org"
pkg_license=('GPL')
pkg_deps=('grantlee' 'karchive' 'kcoreaddons' 'kconfig' 'ki18n' 'kitemviews' 'kwidgetsaddons' 
         'kwindowsystem' 'kcompletion' 'kjobwidgets' 'kconfigwidgets' 'kiconthemes' 'kio'
         'knewstuff' 'kparts' 'kwallet' 'kxmlgui' 'plasma-workspace' # 'aqbanking' 
         'boost-libs' 'libofx' 'qca-qt5' 'kactivities' 'sqlcipher' 'qtwebkit-tp')
pkg_build_deps=('extra-cmake-modules' 'kdoctools' 'docbook-xsl' 'boost' 'clang')
pkg_source=("http://download.kde.org/stable/skrooge/${pkg_name}-${pkg_version}.tar.xz"
        'sqlite3.patch')
pkg_shasum=('7617285a39fc172e1c88b4302cbed968'
         '5e98360d8ce1c90baef8ed7bd881d884')

do_prepare() {
  cd ${pkg_name}-${pkg_version}
  #sed -e "s/FIND_PACKAGE(KActivities)/FIND_PACKAGE(KF5Activities)/" -i ${CACHE_PATH}/$pkg_name/skgbasegui/CMakeLists.txt
  #patch -p1 -i ${CACHE_PATH}/sqlite3.patch
}
         
do_build() {
  mkdir -p build
  cd build
  
  export CC=/usr/bin/clang
  export CXX=/usr/bin/clang++

  cmake ../${pkg_name}-${pkg_version} \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DKDE_INSTALL_LIBDIR=lib \
    -DKDE_INSTALL_SYSCONFDIR=/etc \
    -DKDE_INSTALL_QMLDIR=/usr/lib/qt5/qml \
    -DKDE_INSTALL_PLUGINDIR=/usr/lib/qt5/plugins \
    -DKDE_INSTALL_USE_QT_SYS_PATHS=ON \
    -DSKG_BUILD_TEST=OFF \
    -DSKG_DESIGNER=OFF
  make
}

do_package() {
  cd build

  make DESTDIR=${pkg_prefix} install
}
