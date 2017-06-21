pkg_origin=cosmos

pkg_name=glew
pkg_version=2.0.0
pkg_description="A cross-platform C/C++ extension loading library"
pkg_upstream_url="http://glew.sourceforge.net"
pkg_license=('BSD' 'MIT' 'GPL')
pkg_deps=('libxmu' 'libxi' 'mesa' 'glu')
pkg_build_deps=('cmake' 'python2')
pkg_source=("http://downloads.sourceforge.net/glew/${pkg_name}-${pkg_version}.tgz")
pkg_shasum=('2a2cd7c98f13854d2fcddae0d2b20411')

do_build() {
  mkdir -p build
  
  cmake ../${pkg_name}-${pkg_version}/build/cmake \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DCMAKE_BUILD_TYPE=Release \
    -DBUILD_SHARED_LIBS=ON \
    -DCMAKE_INSTALL_LIBDIR=lib
    
  make
}

do_package() {
  make DESTDIR=${pkg_prefix} install
  
  install -D -m644 ../${pkg_name}-${pkg_version}/LICENSE.txt ${pkg_prefix}/usr/share/licenses/${pkg_name}/LICENSE
}
