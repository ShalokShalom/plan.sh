pkg_origin=

pkg_name=libopenshot-audio
pkg_version=0.1.4
_pkg_version=0.1.5
pkg_description="Program that allows the high-quality editing and playback of audio, and is based on the amazing JUCE library."
pkg_upstream_url="http://www.openshot.org/"
pkg_license=('LGPL3')
pkg_deps=('alsa-lib' 'freetype2' 'libx11' 'libxcursor' 'libxinerama' 'libxrandr')
pkg_build_deps=('cmake')
# http://bazaar.launchpad.net/~openshot.code/libopenshot/libopenshot-audio/files
pkg_source=("https://launchpad.net/libopenshot/0.1/${_pkg_version}/+download/libopenshot-audio-${pkg_version}.tar.gz")
pkg_shasum=('1cccecc63030294afb9e9d81b56217f6')

do_build() {
  mkdir -p build
  cd build
  
  cmake .. \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=/usr 
  make
}

do_package() {
  cd build
  
  make DESTDIR=${pkg_prefix} install
}
