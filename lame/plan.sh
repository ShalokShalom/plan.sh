pkg_origin=cosmos

pkg_name=lame
pkg_version=3.99.5
pkg_description="A high quality MPEG Audio Layer III (MP3) encoder"
pkg_upstream_url="http://lame.sourceforge.net/"
pkg_deps=('ncurses')
pkg_build_deps=('nasm')
pkg_license=('LGPL')
pkg_source=("https://downloads.sourceforge.net/lame/${pkg_name}-${pkg_version}.tar.gz")
pkg_shasum=('84835b313d4a8b68f5349816d33e07ce')

do_build() {

  ./configure --prefix=/usr \
    --enable-nasm \
    --enable-shared
  make
}

do_package() {

  make DESTDIR=${pkg_prefix} install
}

