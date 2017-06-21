pkg_origin=cosmos

pkg_name=libdbusmenu-qt
pkg_version=0.9.2
pkg_description="A library that provides a Qt implementation of the DBusMenu spec"
pkg_upstream_url="https://launchpad.net/libdbusmenu-qt"
pkg_license=('GPL')
pkg_deps=('qt')
pkg_build_deps=('cmake' 'doxygen' 'qjson')
pkg_source=("http://launchpad.net/${pkg_name}/trunk/${pkg_version}/+download/${pkg_name}-${pkg_version}.tar.bz2")
pkg_shasum=('9a49484927669cd2ec91b3bf9ba8b79e')

do_build() {
  mkdir build
  
  cmake ../${pkg_name}-${pkg_version} \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DCMAKE_BUILD_TYPE=Release 
  make
}

do_package() {
  
  make DESTDIR="${pkg_prefix}" install
}
