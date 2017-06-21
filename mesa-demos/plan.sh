pkg_origin=cosmos

pkg_name=mesa-demos
pkg_version=8.3.0
pkg_description="Mesa demos and tools"
pkg_upstream_url="http://mesa3d.sourceforge.net"
pkg_license=('custom')
pkg_deps=('glew' 'freeglut')
pkg_source=("ftp://ftp.freedesktop.org/pub/mesa/demos/${pkg_version}/mesa-demos-${pkg_version}.tar.bz2"
        'LICENSE')
pkg_shasum=('628e75c23c17394f11a316c36f8e4164'
         '5c65a0fe315dd347e09b1f2826a1df5a')

do_build() {
  
  ./configure --prefix=/usr # --disable-egl
  make
}

do_package() {
  make DESTDIR=${pkg_prefix} install
  
  install -m755 -d ${pkg_prefix}/usr/share/licenses/mesa-demos
  install -m755 ${CACHE_PATH}/LICENSE ${pkg_prefix}/usr/share/licenses/mesa-demos/
}
