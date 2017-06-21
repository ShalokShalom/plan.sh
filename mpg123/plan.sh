pkg_origin=cosmos

pkg_name=mpg123
pkg_version=1.25.0
pkg_description="A console based real time MPEG Audio Player for Layer 1, 2 and 3"
pkg_upstream_url="http://www.mpg123.org/"
pkg_license=('GPL2' 'LGPL2.1')
pkg_deps=('glibc' 'libtool' 'alsa-lib')
pkg_build_deps=('sdl' 'jack' 'pulseaudio')
pkg_deps=('sdl: for sdl audio support'
            'jack: for jack audio support')
groups=('multimedia')
pkg_source=("https://downloads.sourceforge.net/sourceforge/mpg123/${pkg_name}-${pkg_version}.tar.bz2")
pkg_shasum=('2ffbe29c99130215b0ee7d1b11c0ea4b')

do_build() {
  
  ./configure --prefix=/usr \
              --enable-int-quality \
              --with-audio="alsa oss sdl jack pulse" \
              --with-module-suffix=.so
  make
}

do_package() {
  
  make DESTDIR=${pkg_prefix} install
}
