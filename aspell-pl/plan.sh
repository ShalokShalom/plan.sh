pkg_origin=cosmos

pkg_name=aspell-pl
pkg_version=20160809
pkg_description="Polish dictionary for aspell"
pkg_upstream_url="http://www.sjp.pl/slownik/en/"
pkg_license=('GPL' 'LGPL' 'MPL')
pkg_deps=('aspell')
pkg_source=("http://sjp.pl/slownik/ort/sjp-aspell6-pl-6.0_${pkg_version}-0.tar.bz2")
pkg_shasum=('16fa56c2ae72cdb165a596bcabfe0ba4')
 
do_build() {
 
  ./configure
  make
}

do_package() {
  
  make DESTDIR=${pkg_prefix} install
}
