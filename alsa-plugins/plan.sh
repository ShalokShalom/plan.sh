pkg_origin=cosmos

pkg_name=alsa-plugins
pkg_version=1.1.4
pkg_description="Extra alsa plugins"
pkg_upstream_url="https://www.alsa-project.org"
pkg_license=('GPL')
pkg_deps=('alsa-lib')
pkg_build_deps=('pulseaudio' 'jack' 'ffmpeg')
pkg_deps=('jack: Jack plugin'
            'ffmpeg: libavcodec resampling plugin'
            'libsamplerate: libsamplerate resampling plugin'
            'speex: libspeexdsp resampling plugin')
pkg_source=("ftp://ftp.alsa-project.org/pub/plugins/${pkg_name}-${pkg_version}.tar.bz2")
pkg_shasum=('de51130a7444b79b2dd3c25e28420754')

do_build() {
  #sed -i 's/ && LIBAVCODEC_VERSION_MINOR >= 34//' a52/pcm_a52.c
  # workaround for split speex caused unknown type name uint16_t & uint32_t error
  #CFLAGS+=' -DHAVE_STDINT_H'
    
  ./configure --prefix=/usr
  make
}

do_package() {
  make DESTDIR=${pkg_prefix} install

  install -d ${pkg_prefix}/usr/share/doc/${pkg_name}
  install -m644 doc/README* doc/*.txt ${pkg_prefix}/usr/share/doc/${pkg_name}/
}
