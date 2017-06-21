pkg_origin=cosmos

pkg_name=googletest
pkg_version=1.8.0
pkg_description='Googles C++ test framework'
pkg_upstream_url='https://github.com/google/googletest/'
pkg_license=('BSD')
pkg_deps=('gcc-libs' 'sh')
pkg_build_deps=('cmake' 'python2')
pkg_source=("https://github.com/google/googletest/archive/release-${pkg_version}.tar.gz")
pkg_shasum=('16877098823401d1bf2ed7891d7dce36')

do_build() {
  mkdir -p build
  
  cmake ../${pkg_name}-release-${pkg_version} \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DBUILD_SHARED_LIBS=ON \
    -DCMAKE_SKIP_RPATH=ON
  make
}

do_package() {
  make DESTDIR=${pkg_prefix} install
  
  install -Dm 644 ../${pkg_name}-release-${pkg_version}/googletest/LICENSE ${pkg_prefix}/usr/share/licenses/${pkg_name}
}

