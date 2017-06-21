pkg_origin=cosmos

pkg_name=cegui
pkg_version=0.6.2b
pkg_description="A free library providing windowing and widgets for graphics APIs/engines"
pkg_upstream_url="http://crayzedsgui.sourceforge.net"
pkg_license=("MIT")
pkg_deps=('pcre' 'expat' 'freetype2' 'libxml2' 'devil' 'freeglut' 'lua' 'silly')
[ "$CARCH" = "x86_64" ] && pkg_deps=(${depends[@]} 'silly')
pkg_source=(http://downloads.sourceforge.net/crayzedsgui/CEGUI-$pkg_version.tar.gz)
pkg_shasum=('4fbd95e5a2ac1c7acf2a8f5df3ac6b93')

do_build() {
    
  ./configure --prefix=/usr \
    --sysconfdir=/etc \
    --enable-devil \
    --enable-silly \
    --disable-xerces-c \
    --with-default-image-codec=SILLYImageCodec \
    --enable-lua
  make
}

do_package() {
  make DESTDIR=$pkg_prefix install

  install -D -m644 COPYING $startdir/pkg/usr/share/licenses/$pkg_name/LICENSE
}
