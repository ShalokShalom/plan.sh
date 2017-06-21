pkg_origin=

pkg_name=kdsoap
pkg_version=1.6.0
pkg_description="Qt-based client-side and server-side SOAP component."
pkg_upstream_url="http://www.kdab.com/products/kd-soap"
pkg_license=('GPL3' 'LGPL')
pkg_deps=('qt5-base')
pkg_build_deps=('cmake')
pkg_source=("https://github.com/KDAB/KDSoap/releases/download/kdsoap-${pkg_version}/${pkg_name}-${pkg_version}.tar.gz")
pkg_shasum=('d51412e286003b5b03f0ab933d1e4436')

do_build() {
  mkdir -p build
  cd build
  
  cmake ../${pkg_name}-${pkg_version} \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DCMAKE_BUILD_TYPE=Release \
    -DINSTALL_LIBRARY_DIR=lib
    
  make
}

do_package() {
  cd build
  
  make DESTDIR=${pkg_prefix} install
}
