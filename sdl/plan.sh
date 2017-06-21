pkg_origin=cosmos

pkg_name=sdl
pkg_version=1.2.15
pkg_description="A library for portable low-level access to a video framebuffer, audio output, mouse, and keyboard"
pkg_upstream_url="http://www.libsdl.org"
pkg_license=('LGPL')
pkg_deps=('glibc' 'libxext' 'libxrender' 'libx11' 'alsa-lib' 'pulseaudio' 'glu')
pkg_build_deps=('mesa')
pkg_source=("http://www.libsdl.org/release/SDL-${pkg_version}.tar.gz"
        'sdl-1.2.14-fix-mouse-clicking.patch'
        'sdl-1.2.14-disable-mmx.patch'
        'resizing.patch'
        'libx11.patch')
pkg_shasum=('9d96df8417572a2afb781a7c4c811a85'
         'd79137e6bdadf21ff2f716590e9709ac'
         'a19dabb85729fab36f2662e9e273a4d9'
         '3dd50347d8856160a9cbd7f80383a1f8'
         '148b285bccee9d21bb96db807363b962')

do_build() {
  patch -p1 -i $CACHE_PATH/sdl-1.2.14-fix-mouse-clicking.patch
  patch -p1 -i $CACHE_PATH/sdl-1.2.14-disable-mmx.patch
  patch -p1 -i $CACHE_PATH/resizing.patch
  patch -p0 -i $CACHE_PATH/libx11.patch
  
  ./configure --prefix=/usr \
        --disable-nasm \
        --enable-alsa \
        --with-x \
        --disable-rpath \
        --disable-static
  make
}

do_package() {
  
  make DESTDIR=${CACHE_PATH} install
}
