pkg_origin=cosmos

pkg_name=librevenge
pkg_version=0.0.4
pkg_description="Base library for writing document import filters. It has interfaces for text documents, 
         vector graphics, spreadsheets and presentations."
pkg_upstream_url="http://sf.net/p/libwpd/librevenge/"
pkg_license=('MPL 2.0')
pkg_deps=('boost-libs' 'zlib')
pkg_build_deps=('boost' 'cppunit')
pkg_source=("https://sourceforge.net/projects/libwpd/files/librevenge/librevenge-${pkg_version}/${pkg_name}-${pkg_version}.tar.xz")
pkg_shasum=('2677cf97716c699146f999575ac0147d')

do_build() {
    #export CPPFLAGS=-DBOOST_ERROR_CODE_HEADER_ONLY

    ./configure --prefix=/usr
    make
}

do_package() {

    make DESTDIR=${pkg_prefix}/ install
}
