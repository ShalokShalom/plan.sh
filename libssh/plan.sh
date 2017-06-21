pkg_origin=cosmos

pkg_name=libssh
pkg_version=0.7.5
pkg_description="Library for accessing ssh client services through C libraries"
pkg_upstream_url="https://www.libssh.org/"
pkg_license=('LGPL')
pkg_deps=('openssl')
pkg_build_deps=('cmake' 'doxygen')
pkg_source=("https://red.libssh.org/attachments/download/218/${pkg_name}-${pkg_version}.tar.xz")
pkg_shasum=('d3fc864208bf607ad87cdee836894feb')

do_build() {
  mkdir -p build
  cd build
  
  cmake ../${pkg_name}-${pkg_version} \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DCMAKE_BUILD_TYPE=Release
  make
}

do_package(){
  cd build
  
  make DESTDIR=${pkg_prefix} install
}
