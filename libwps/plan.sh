pkg_origin=cosmos

pkg_name=libwps
pkg_version=0.4.6
pkg_description="a Microsoft Works file word processor format import filter library"
pkg_upstream_url="http://libwps.sourceforge.net/"
pkg_license=('LGPL')
pkg_deps=('libwpd' 'librevenge')
pkg_build_deps=('boost')
pkg_source=("http://downloads.sourceforge.net/project/libwps/$pkg_name/${pkg_name}-${pkg_version}/${pkg_name}-${pkg_version}.tar.xz")
pkg_shasum=('b04428f208e2eb31adcba5a53dec62c2')

do_build() {

    ./configure  --prefix=/usr --disable-static 
    make
}

do_package() {

    make DESTDIR=${pkg_prefix} install
}

