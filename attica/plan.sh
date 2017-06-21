pkg_origin=cosmos
pkg_name=attica
pkg_version=0.4.2
pkg_description='A Qt library to access Open Collaboration Service providers'
pkg_upstream_url='http://www.kde.org'
pkg_license=('LGPL')
pkg_deps=('qt')
pkg_build_deps=('cmake')
pkg_source=("http://download.kde.org/stable/attica/${pkg_name}-${pkg_version}.tar.bz2")
pkg_shasum=('d62c5c9489a68432e8d990dde7680c24')

do_build() {
  mkdir build
  
  cmake ../${pkg_name}-${pkg_version} \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=/usr 
  make 
}

do_package() {
  
  make DESTDIR=${pkg_prefix} install
}
