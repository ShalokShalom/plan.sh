pkg_origin=cosmos

pkg_name=rubberband
pkg_version=1.8.1
pkg_description="Time-stretching and pitch-shifting audio library and utility"
pkg_upstream_url="http://www.breakfastquay.com/rubberband/"
pkg_license=('GPL')
pkg_deps=('libsamplerate' 'fftw' 'vamp-plugin-sdk')
pkg_build_deps=('ladspa')
pkg_source=("http://code.breakfastquay.com/attachments/download/34/${pkg_name}-${pkg_version}.tar.bz2")
pkg_shasum=('6c2b4e18a714bcc297d0db81a10f9348')

do_build() {

  ./configure --prefix=/usr
  make
}

do_package() {
  
  make DESTDIR=${CACHE_PATH}/ install
}

