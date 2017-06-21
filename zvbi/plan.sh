pkg_origin=cosmos

pkg_name=zvbi
pkg_version=0.2.35
pkg_description="VBI capture and decoding library"
pkg_upstream_url="http://zapping.sourceforge.net/cgi-bin/view/ZVBI/WebHome"
pkg_deps=('libpng' 'libx11')
pkg_license=('GPL')
pkg_source=("https://downloads.sourceforge.net/sourceforge/zapping/${pkg_name}-${pkg_version}.tar.bz2")
pkg_shasum=('95e53eb208c65ba6667fd4341455fa27')

do_build() {

  ./configure --prefix=/usr \
    --disable-static \
    --mandir=/usr/share/man

  make
}

do_package() {

  make DESTDIR="${CACHE_PATH}" install
}

