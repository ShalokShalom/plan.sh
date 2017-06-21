pkg_origin=

pkg_name=desmume
pkg_version=0.9.10
pkg_description="Nintendo DS emulator"
pkg_upstream_url="http://desmume.org/"
pkg_license=('GPL')
pkg_deps=('desktop-file-utils' 'libpcap' 'soundtouch' 'alsa-lib' 'glu' 'sdl' 'gtk2' 'zziplib')
pkg_build_deps=('intltool' 'mesa')
install=desmume.install
pkg_source=("http://downloads.sourceforge.net/$pkg_name/$pkg_name-$pkg_version.tar.tar"
        "glx_3Demu.patch")
pkg_shasum=('a6aedfe5d6437d481aa9ac5fb5aebbea'
         '352ea0ffa109f68da2fb79f30d2c85e2')
         
do_build() {
  cd "$CACHE_PATH/$pkg_name-$pkg_version"

  # http://sourceforge.net/p/desmume/code/4907/
  patch -p2 -i "$CACHE_PATH"/glx_3Demu.patch
  # https://sourceforge.net/tracker/?func=detail&aid=3612768&group_id=164579&atid=832291
  sed -i 's/@GETTEXT_PACKAGE@/desmume/' po/Makefile.in.in

  ./configure --prefix=/usr --enable-wifi
  make
}

do_package() {
  cd "$CACHE_PATH/$pkg_name-$pkg_version"

  make DESTDIR="$pkg_prefix/" install
}


