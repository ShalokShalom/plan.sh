pkg_origin=cosmos

pkg_name=sdl_ttf
pkg_version=2.0.14
pkg_description="Library that allows you to use TrueType fonts in your SDL applications"
pkg_license=('custom')
pkg_upstream_url="http://www.libsdl.org/projects/SDL_ttf/"
pkg_deps=('sdl2' 'freetype2')
pkg_source=("http://www.libsdl.org/projects/SDL_ttf/release/SDL2_ttf-$pkg_version.tar.gz"
        'bug1433.patch')
pkg_shasum=('e53c05e1e7f1382c316afd6c763388b1'
         'ef05c69efe33d10f380181ad41a29b51')

do_build() {
  #patch -i "$CACHE_PATH/bug1433.patch"
 
  ./configure --prefix=/usr --disable-static
  make
}

do_package() {
  make DESTDIR="$CACHE_PATH" install

  install -Dm644 COPYING.txt "$CACHE_PATH/usr/share/licenses/$pkg_name/LICENSE"
}
