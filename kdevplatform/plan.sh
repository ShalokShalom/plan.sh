pkg_origin=

pkg_name=kdevplatform
pkg_version=5.1.1
_pkg_version=5.1.1
pkg_description="A C/C++ development platform for KDE"
pkg_upstream_url="https://www.kdevelop.org/"
pkg_license=('GPL')
pkg_deps=('karchive' 'kconfig' 'kwidgetsaddons' 'kiconthemes' 'kcmutils' 'kemoticons' 'kguiaddons' 'ki18n' 'kinit' 'kio'
         'kitemmodels' 'kitemviews' 'kjobwidgets' 'knewstuff' 'knotifications' 'knotifyconfig' 'kparts' 'kservice' 
         'ktexteditor' 'sonnet' 'threadweaver' 'kwindowsystem' 'kdeclarative' 'kxmlgui' 'plasma-framework' 
         'qt5-declarative' 'grantlee' 'konsole' 'libkomparediff2' 'subversion' 'qt5-webkit')
pkg_build_deps=('extra-cmake-modules' 'kdoctools' 'boost')
pkg_source=("https://download.kde.org/stable/kdevelop/${_pkg_version}/src/kdevplatform-${pkg_version}.tar.xz")
pkg_shasum=('bc865ca1354939228e00ba113bcebee1')

do_prepare() {
  cd ${pkg_name}-${pkg_version}
  
  #patch -Rp1 -i $CACHE_PATH/ref.diff
}

do_build() {
  mkdir -p build
  
  cd build 
  cmake ../${pkg_name}-${pkg_version} \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DCMAKE_BUILD_TYPE=Release \
    -DKDE_INSTALL_LIBDIR=lib \
    -DKDE_INSTALL_SYSCONFDIR=/etc \
    -DKDE_INSTALL_QMLDIR=/usr/lib/qt5/qml \
    -DKDE_INSTALL_PLUGINDIR=/usr/lib/qt5/plugins \
    -DBUILD_TESTING=OFF 
  make 
}

do_package() {
  cd build
  
  make DESTDIR=${pkg_prefix} install
}
