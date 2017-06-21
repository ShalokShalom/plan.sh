pkg_origin=cosmos

pkg_name=webrtc-audio-processing
pkg_version=0.3
pkg_description="AudioProcessing library based on Google's implementation of WebRTC"
pkg_upstream_url="https://freedesktop.org/software/pulseaudio/webrtc-audio-processing"
pkg_license=('custom')
pkg_deps=('gcc-libs')
pkg_source=("https://freedesktop.org/software/pulseaudio/webrtc-audio-processing/${pkg_name}-${pkg_version}.tar.xz")
pkg_shasum=('336ae032f608e65808ac577cde0ab72c')

do_build() {
  
  ./configure --prefix=/usr --disable-static
  make
}

do_package() {
  make DESTDIR=${CACHE_PATH} install

  install -Dm644 COPYING ${CACHE_PATH}/usr/share/licenses/${pkg_name}/COPYING
  #install -Dm644 PATENTS ${CACHE_PATH}/usr/share/licenses/${pkg_name}/PATENT
}
