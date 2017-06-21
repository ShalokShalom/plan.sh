pkg_origin=cosmos

pkg_name=libproxy
pkg_version=0.4.14
pkg_description="A library that provides automatic proxy configuration management"
pkg_upstream_url="http://libproxy.github.io/libproxy"
pkg_license=('LGPL')
pkg_deps=('gcc-libs')
pkg_build_deps=('cmake' 'networkmanager' 'python2' 'perl')
pkg_deps=('networkmanager: NetworkManager configuration module'
            'perl: Perl bindings'
            'python2: Python bindings')
pkg_source=("https://github.com/libproxy/libproxy/archive/${pkg_version}.tar.gz")
pkg_shasum=('272dc378efcc3335154cef30d171e84a')

do_build() {
  mkdir build
  
  cmake -DCMAKE_INSTALL_PREFIX=/usr \
    -DLIBEXEC_INSTALL_DIR=/usr/lib/libproxy \
    -DCMAKE_SKIP_RPATH=ON \
    -DPERL_VENDORINSTALL=yes \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_CXX_FLAGS="${CXXFLAGS}" \
    -DCMAKE_C_FLAGS="${CFLAGS}" \
    ..
  make
}

do_package() {
  
  make DESTDIR="${pkg_prefix}" install
}
