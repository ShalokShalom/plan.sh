pkg_origin=cosmos

pkg_name=sdl_mixer
pkg_version=1.2.12
pkg_description="A simple multi-channel audio mixer"
pkg_upstream_url="http://www.libsdl.org/projects/SDL_mixer/"
pkg_license=('custom')
pkg_deps=('sdl' 'libvorbis' 'libmikmod' 'smpeg')
pkg_build_deps=('fluidsynth')
optpkg_deps=('fluidsynth: MIDI software synth, replaces built-in timidity')
pkg_source=("http://www.libsdl.org/projects/SDL_mixer/release/SDL_mixer-$pkg_version.tar.gz")
pkg_shasum=('e03ff73d77a55e3572ad0217131dc4a1')

do_build() {

  sed -e "/CONFIG_FILE_ETC/s|/etc/timidity.cfg|/etc/timidity++/timidity.cfg|" \
      -e "/DEFAULT_PATH/s|/etc/timidity|/etc/timidity++|" \
      -e "/DEFAULT_PATH2/s|/usr/local/lib/timidity|/usr/lib/timidity|" \
      -i timidity/config.h

  ./configure --prefix=/usr --disable-static
  make
}

do_package() {
  make DESTDIR="$CACHE_PATH" install

  install -Dm644 COPYING "$CACHE_PATH/usr/share/licenses/$pkg_name/LICENSE"
}
