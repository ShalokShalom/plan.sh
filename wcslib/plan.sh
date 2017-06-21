pkg_origin=cosmos

pkg_name=wcslib
pkg_version=5.16
pkg_description="FITS World Coordinate System (WCS) standard defines keywords and usage that provide for the description of astronomical coordinate systems."
pkg_upstream_url="http://www.atnf.csiro.au/people/mcalabre/WCS/wcslib/"
pkg_license=('GPL3')
pkg_deps=('cfitsio')
pkg_build_deps=('gcc')
pkg_source=("ftp://ftp.atnf.csiro.au/pub/software/wcslib/${pkg_name}-${pkg_version}.tar.bz2")
pkg_shasum=('8608b3e7f36a7d82a670c3569ad21817')

do_build() {

  ./configure --prefix=/usr --without-pgplot
  make
}

do_package() {
  make DESTDIR=${CACHE_PATH}/ install
  
  chmod g=rx,-s ${CACHE_PATH}/usr/{bin/,/lib/{,pkgconfig},share/man/man1/}
  chmod -s ${CACHE_PATH}/usr/{include/wcslib-${pkg_version}/,share/doc/wcslib-${pkg_version}/{,html/}}
}

