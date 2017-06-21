pkg_origin=cosmos

pkg_name=libfreexl
pkg_version=1.0.2
pkg_description="Library to extract valid data from within an Excel (.xls) spreadsheet"
pkg_upstream_url="https://www.gaia-gis.it/fossil/freexl/index"
pkg_license=('MPL')
pkg_deps=('glibc')
pkg_source=("https://www.gaia-gis.it/gaia-sins/freexl-sources/freexl-${pkg_version}.tar.gz")
pkg_shasum=('9954640e5fed76a5d9deb9b02b0169a0')

do_build() {
  
  LIBS=-lm ./configure --prefix=/usr
  make
}

do_package() {
  
  make DESTDIR=${pkg_prefix}/ install
}
