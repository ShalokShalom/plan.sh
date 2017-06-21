pkg_origin=

pkg_name=audacity
pkg_version=2.1.3
pkg_description="A program that lets you manipulate digital audio waveforms"
pkg_upstream_url="http://web.audacityteam.org/"
pkg_license=('GPL')
pkg_deps=('libvorbis' 'libmad' 'libid3tag' 'wxgtk' 'lame' 'hicolor-icon-theme' 'ffmpeg'
         'shared-mime-info' 'desktop-file-utils' 'redland' 'jack' 'soundtouch' 'libsoxr'
         'lilv' 'portaudio' 'flac' 'libsndfile' 'libsamplerate')
pkg_build_deps=('cmake' 'zip' 'python2' 'pkgconfig')
pkg_source=("https://github.com/audacity/audacity/archive/Audacity-${pkg_version}.tar.gz")
pkg_shasum=('82e7216ae4b9bb597ed6f291bd44f45b')

do_build() {
  cd ${pkg_name}-Audacity-${pkg_version}
  #patch -p1 -i ${CACHE_PATH}/ffmpeg.patch

  autoreconf -vi
  ./configure --prefix=/usr \
    --enable-unicode \
    --with-ffmpeg=system \
    --with-libsamplerate=system \
    --with-expat=system
  make
}

do_package() {
  cd ${pkg_name}-Audacity-${pkg_version}
  
  make DESTDIR=${pkg_prefix} install
}

