pkg_origin=

pkg_name=jsoncpp
pkg_version=1.8.0
pkg_description="A JSON C++ library"
pkg_upstream_url='https://github.com/open-source-parsers/jsoncpp'
pkg_license=('custom:Public_Domain')
pkg_deps=('gcc-libs' 'python2')
pkg_build_deps=('cmake')
pkg_source=("https://github.com/open-source-parsers/jsoncpp/archive/${pkg_version}.tar.gz")
pkg_shasum=('6d6cbd82b5fe4a9cbae4ffef01f9e9fc')

do_build() {
  mkdir -p build
  cd build
  
  cmake ../${pkg_name}-${pkg_version} \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DCMAKE_INSTALL_LIBDIR=lib \
    -DBUILD_SHARED_LIBS=ON 
  make
}

do_package() {
  cd build
  make DESTDIR=${pkg_prefix} install
  
  cd ../${pkg_name}-${pkg_version}
  install -Dm644 LICENSE ${pkg_prefix}/usr/share/licenses/${pkg_name}/LICENSE
}
