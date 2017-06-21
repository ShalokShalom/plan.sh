pkg_origin=

pkg_name=kdev-go
pkg_version=1.90.90
_commit=28b68c0f20fc5c2d977aa682a8a201b789ce0e9b
pkg_description='Go language support for KDevelop'
pkg_upstream_url="http://www.kdevelop.org/"
pkg_license=('GPL')
pkg_deps=('kdevelop' 'kitemmodels' 'threadweaver' 'ktexteditor' 'ki18n')
pkg_build_deps=('extra-cmake-modules')
pkg_source=("https://github.com/KDE/kdev-go/archive/${_commit}.zip")
pkg_shasum=('ba322113be55daabb441a4ce7303aadc')

do_build() {
  mkdir -p build
  cd build 
  
  cmake ../${pkg_name}-${_commit} \
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
