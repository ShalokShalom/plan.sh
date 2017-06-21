pkg_origin=

pkg_name=kdevelop
pkg_version=5.1.1
_pkg_version=5.1.1
pkg_description="A C/C++ development environment for KDE"
pkg_upstream_url="http://www.kdevelop.org/"
pkg_license=('GPL')
pkg_deps=('kdevplatform' 'kconfig' 'kdeclarative' 'kiconthemes' 'ki18n' 'kitemmodels' 'kitemviews'
         'kjobwidgets' 'kcmutils' 'kio' 'knewstuff' 'knotifyconfig' 'kparts' 'kservice' 'ktexteditor' 
         'threadweaver' 'kxmlgui' 'kwindowsystem' 'krunner' 'libksysguard' 'plasma-framework' 'okteta' 
         'kdevelop-pg-qt' 'clang' 'llvm' 'heaptrack')
pkg_build_deps=('extra-cmake-modules' 'kdoctools' 'perl' 'docbook-xsl')
pkg_source=("http://download.kde.org/stable/kdevelop/${_pkg_version}/src/kdevelop-${pkg_version}.tar.xz")      
pkg_shasum=('868dab514949996e8fdc66cc7f94cea6')

do_prepare() {
  cd ${pkg_name}-${pkg_version}
  
  #patch -p1 -i $CACHE_PATH/qt55.diff
}

do_build() {
  mkdir -p build
  cd build 
  
  cmake ../${pkg_name}-${pkg_version} \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_SKIP_RPATH=ON \
    -DKDE_INSTALL_LIBDIR=lib \
    -DKDE_INSTALL_SYSCONFDIR=/etc \
    -DKDE_INSTALL_QMLDIR=/usr/lib/qt5/qml \
    -DKDE_INSTALL_PLUGINDIR=/usr/lib/qt5/plugins \
    -DKDE_INSTALL_USE_QT_SYS_PATHS=ON \
    -DBUILD_TESTING=OFF 
  make 
}

do_package() {
  cd build
  
  make DESTDIR=${pkg_prefix} install
}
