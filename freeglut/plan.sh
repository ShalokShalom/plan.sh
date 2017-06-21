pkg_origin=cosmos

pkg_name=freeglut
pkg_version=3.0.0
pkg_description="Provides functionality for small OpenGL programs"
pkg_upstream_url="http://freeglut.sourceforge.net/"
pkg_license=('MIT')
pkg_deps=('libxi' 'libxrandr' 'libgl')
pkg_build_deps=('cmake' 'mesa' 'glu' 'libxxf86vm')
pkg_source=("https://downloads.sourceforge.net/freeglut/${pkg_name}-${pkg_version}.tar.gz")
pkg_shasum=('90c3ca4dd9d51cf32276bc5344ec9754')

do_build() {
  mkdir -p build
  
  cmake ../${pkg_name}-${pkg_version} \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DCMAKE_INSTALL_LIBDIR=lib 
  make
}

do_package() {
  make DESTDIR=${pkg_prefix} install
  
  install -Dm644 ../${pkg_name}-${pkg_version}/COPYING ${pkg_prefix}/usr/share/licenses/${pkg_name}/LICENSE
}
