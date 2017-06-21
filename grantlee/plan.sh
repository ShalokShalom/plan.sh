pkg_origin=

pkg_name=grantlee
pkg_version=5.1.0
pkg_description="A string template engine based on the Django template system and written in Qt"
pkg_upstream_url="https://github.com/steveire/grantlee"
pkg_license=('LGPL3')
pkg_deps=('qt5-base' 'qt5-script')
pkg_build_deps=('cmake' 'doxygen')
pkg_source=("http://downloads.grantlee.org/${pkg_name}-${pkg_version}.tar.gz")
pkg_shasum=('57989ae9f7c113e682ef1713a6f1e92a')

do_build() {
  mkdir build
  cd build
  
  cmake ../${pkg_name}-${pkg_version} \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DCMAKE_BUILD_TYPE=Release \
    -DBUILD_TESTS=OFF 
  make
}

do_package() {
  cd build
  
  make DESTDIR="${pkg_prefix}" install
}
