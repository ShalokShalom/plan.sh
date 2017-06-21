pkg_origin=cosmos

# rebuild mpv on any update
pkg_name=ffmpeg
pkg_version=3.3.2
pkg_description="Complete and free Internet live audio and video broadcasting solution for Linux/Unix"
pkg_upstream_url="http://ffmpeg.org/"
pkg_license=('GPL')
pkg_deps=('bzip2' 'lame' 'sdl2' 'libvorbis' 'xvidcore' 'zlib' 'x264' 'libtheora' 'celt' 'fribidi'
         'opencore-amr' 'alsa-lib' 'libvdpau' 'libxfixes' 'schroedinger' 'libvpx>=1.1.0' 'libwebp'
         'libva' 'openjpeg' 'rtmpdump' 'speex' 'gsm' 'pulseaudio' 'v4l-utils' 'gnutls' 'x265'
         'libass' 'dcadec' 'opus')
pkg_build_deps=('yasm')
pkg_source=("http://ffmpeg.org/releases/${pkg_name}-${pkg_version}.tar.xz")
pkg_shasum=('d6c09c84e3d0d9ca8a51f481da660603')

do_build() {

  ./configure --prefix=/usr \
              --enable-avisynth \
              --enable-avresample \
              --enable-libmp3lame \
              --enable-libvorbis \
              --enable-libxvid \
              --enable-libx264 \
              --enable-libx265 \
              --enable-libvpx \
              --enable-libtheora \
              --enable-libgsm \
              --enable-postproc \
              --enable-shared \
              --enable-libopencore_amrnb \
              --enable-libopencore_amrwb \
              --enable-libopus \
              --enable-libschroedinger \
              --enable-libopenjpeg \
              --enable-librtmp \
              --enable-libpulse \
              --enable-gpl \
              --enable-gnutls \
              --enable-vdpau \
              --enable-version3 \
              --enable-runtime-cpudetect \
              --enable-swresample \
              --enable-libspeex \
              --enable-libv4l2 \
              --enable-libcelt \
              --enable-libfribidi \
              --enable-libass \
              --disable-debug \
              --disable-static

  make
  make tools/qt-faststart
  make doc/ff{mpeg,play,server}.1
}

do_package() {
  make DESTDIR=${pkg_prefix} install install-man
  install -D -m755 tools/qt-faststart ${pkg_prefix}/usr/bin/qt-faststart
}
