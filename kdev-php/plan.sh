pkg_origin=

pkg_name=kdev-php
pkg_version=5.1.1
_pkg_version=5.1.1
pkg_description="PHP plugin for Kdevelop"
pkg_upstream_url="http://www.kdevelop.org/"
pkg_license=('GPL')
pkg_deps=('kdevelop' 'kdevelop-pg-qt' 'threadweaver' 'ktexteditor' 'ki18n')
pkg_build_deps=('extra-cmake-modules' 'kdoctools' 'git')
pkg_source=("http://download.kde.org/stable/kdevelop/${_pkg_version}/src/${pkg_name}-${pkg_version}.tar.xz")
pkg_shasum=('79db9b196690a19bf4c8ddcc73e4230a')

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
