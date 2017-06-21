pkg_origin=cosmos

pkg_name=directfb
pkg_version=1.7.7
_pkg_version=1.7
pkg_description="Library that provides hardware graphics acceleration, input device handling and abstraction, integrated windowing system on top of the Linux Framebuffer Device"
pkg_upstream_url="https://github.com/Distrotech/DirectFB"
pkg_license=('LGPL')
pkg_deps=('gcc-libs' 'libjpeg-turbo' 'sdl' 'libpng' 'freetype2' 'mesa' 'libtiff' 'libmad' 'libgl')
pkg_source=("http://sources.buildroot.net/DirectFB-${pkg_version}.tar.gz")
pkg_shasum=('152cf1863b1a3a28aa1370e9053440bf')

do_build() {
  
   ./configure --prefix=/usr --sysconfdir=/etc --enable-static --enable-debug \
     --enable-zlib --enable-x11 --enable-sdl --disable-vnc --disable-osx \
     --enable-video4linux2 --enable-voodoo
  make
} 

do_package() {
  
  make DESTDIR=${pkg_prefix} install
}
