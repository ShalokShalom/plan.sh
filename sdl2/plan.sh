pkg_origin=cosmos

pkg_name=sdl2
pkg_version=2.0.5
pkg_description="Library for portable low-level access to a video framebuffer, audio output, mouse, and keyboard (Version 2)"
pkg_upstream_url="http://www.libsdl.org"
pkg_license=('MIT')
pkg_deps=('glibc' 'libxcursor' 'libxext' 'libxrender' 'libx11' 'libgl' 'pulseaudio' 'alsa-lib')
pkg_build_deps=('mesa' 'libxrandr' 'libxinerama' 'libxkbcommon')
pkg_source=("http://www.libsdl.org/release/SDL2-${pkg_version}.tar.gz")
pkg_shasum=('d4055424d556b4a908aa76fad63abd3c')

do_prepare() {
  mkdir build
}

do_build() {
  
  ../SDL2-$pkg_version/configure --prefix=/usr \
    --enable-sdl-dlopen \
    --disable-arts \
    --disable-esd \
    --disable-nas \
    --enable-alsa \
    --enable-pulseaudio-shared \
    --enable-video-wayland \
    --disable-rpath
  make
}

do_package() {
  make DESTDIR="$CACHE_PATH" install
  
  install -Dm644 ../SDL2-$pkg_version/COPYING.txt "$CACHE_PATH/usr/share/licenses/$pkg_name/LICENSE"
}
