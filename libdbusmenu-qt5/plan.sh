pkg_origin=cosmos

pkg_name=libdbusmenu-qt5
pkg_version=0.9.3+16.04.20160218
pkg_description="Library that provides a Qt implementation of the DBusMenu spec"
pkg_upstream_url="https://launchpad.net/libdbusmenu-qt"
pkg_license=('GPL')
pkg_deps=('qt5-base')
pkg_build_deps=('cmake')
pkg_source=("http://archive.ubuntu.com/ubuntu/pool/main/libd/libdbusmenu-qt/libdbusmenu-qt_${pkg_version}.orig.tar.gz")
pkg_shasum=('8b90312bd8654e026d814d4db986ce5e')


do_build() {
  mkdir -p build
  
  cmake ../libdbusmenu-qt-${pkg_version} \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DCMAKE_BUILD_TYPE=Release \
    -DUSE_QT5=On \
    -DCMAKE_INSTALL_LIBDIR=lib \
    -DWITH_DOC=Off
  make
}

do_package() {
  
  make DESTDIR="${pkg_prefix}" install
}
