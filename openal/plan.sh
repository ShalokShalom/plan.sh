pkg_origin=cosmos

pkg_name=openal
pkg_version=1.18.0
pkg_description="OpenAL is a cross-platform 3D audio library for use with OpenGL"
pkg_upstream_url="http://www.openal.org/"
pkg_license=('LGPL')
pkg_deps=('glibc')
pkg_build_deps=('alsa-lib' 'sdl2' 'cmake' 'pulseaudio' 'qt5-base')
pkg_source=("http://kcat.strangesoft.net/openal-releases/$pkg_name-soft-${pkg_version}.tar.bz2")
pkg_shasum=('704d41343b52dd04115de2dcdac5de03')

do_build() {
  
  cmake \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_LIBDIR=lib ..
  make
}

do_package() {
  
  make -C build DESTDIR=${pkg_prefix}/ install
}
