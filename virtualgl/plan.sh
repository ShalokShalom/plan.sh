pkg_origin=cosmos

pkg_name=virtualgl
pkg_version=2.5.2
pkg_description="Redirects 3D commands from an OpenGL application onto a server-side 3D graphics card."
pkg_upstream_url="http://virtualgl.org"
pkg_license=('LGPL')
pkg_deps=('mesa' 'libxv' 'libjpeg-turbo' 'glu')
pkg_build_deps=('cmake')
pkg_source=("http://sourceforge.net/projects/virtualgl/files/${pkg_version}/VirtualGL-${pkg_version}.tar.gz")
pkg_shasum=('1a9f404f4a35afa9f56381cb33ed210c')

do_build() {
  mkdir -p build

  cmake ../VirtualGL-${pkg_version} \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DCMAKE_INSTALL_LIBDIR=/usr/lib \
    -DCMAKE_INSTALL_BINDIR=/usr/bin \
    -DTJPEG_INCLUDE_DIR=/usr/include \
    -DTJPEG_LIBRARY=/usr/lib/libturbojpeg.so 
  make
}

do_package() {
  make install DESTDIR=${CACHE_PATH}
  
  # conflicts with mesa-demos
  mv ${CACHE_PATH}/usr/bin/glxinfo ${CACHE_PATH}/usr/bin/vglxinfo
}

