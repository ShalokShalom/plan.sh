pkg_origin=cosmos

pkg_name=soundtouch
pkg_version=1.9.2
pkg_description="SoundTouch is an open-source audio processing library for changing the Tempo, Pitch and Playback Rates of audio streams or audio files."
pkg_upstream_url="http://www.surina.net/soundtouch/"
pkg_license=('LGPL')
pkg_deps=('gcc-libs')
pkg_source=("http://www.surina.net/soundtouch/${pkg_name}-${pkg_version}.tar.gz")
pkg_shasum=('2d1ab4abb54640e8e308e36e309c94a6')

do_build() {

  if [ ! -x ./configure ]; then
    ./bootstrap
  fi

  ./configure --prefix=/usr --enable-shared --with-pic 

  make
}

do_package() {

  make DESTDIR="${CACHE_PATH}" pkgdocdir=/usr/share/doc/soundtouch install
}

