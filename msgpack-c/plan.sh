pkg_origin=

pkg_name=msgpack-c
_pkg_name=msgpack
pkg_version=2.1.3
pkg_description="Efficient binary serialization format, which lets you exchange data among multiple languages like JSON"
pkg_upstream_url="https://github.com/msgpack/msgpack-c"
pkg_license=('GPL3')
pkg_deps=('gnutls' 'readline' 'python3-cython')
pkg_build_deps=('cmake')
pkg_source=("https://github.com/msgpack/msgpack-c/releases/download/cpp-${pkg_version}/${_pkg_name}-${pkg_version}.tar.gz")
pkg_shasum=('e604cee971f20f8b4f885163deca2062')

do_build() {
  mkdir -p build
  cd build

  cmake ../${_pkg_name}-${pkg_version} \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DMSGPACK_CXX11=ON \
    -DMSGPACK_BUILD_EXAMPLES=OFF
  make
}

do_package() {
  cd build
  
  make DESTDIR=${pkg_prefix} install
}
