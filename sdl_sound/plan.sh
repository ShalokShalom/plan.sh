pkg_origin=cosmos

pkg_name=sdl_sound
pkg_version=1.0.3
pkg_description="A library to decode several popular sound file formats, such as .WAV and .MP3"
pkg_upstream_url="http://icculus.org/SDL_sound/"
pkg_license=('LGPL')
pkg_deps=('libmodplug' 'sdl' 'libmikmod' 'libvorbis' 'flac' 'speex' 'smpeg')
pkg_source=("http://icculus.org/SDL_sound/downloads/SDL_sound-$pkg_version.tar.gz" 
        'flac.patch')
pkg_shasum=('aa09cd52df85d29bee87a664424c94b5'
         '302aa9dc94cc71dd3339ca3177d36e1c')

do_build() {

  CFLAGS="$CFLAGS -I/usr/include/smpeg" \
  CXXFLAGS="$CXXFLAGS -I/usr/include/smpeg" \
  ./configure --prefix=/usr

  make 
}

do_package() {
  
  make DESTDIR=${CACHE_PATH} install
}

