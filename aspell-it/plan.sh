pkg_origin=cosmos

pkg_name=aspell-it
pkg_version=2.2_20050523
_pkg_version=2.2_20050523-0
pkg_description="Italian dictionary for aspell"
pkg_upstream_url="http://aspell.net/"
pkg_license=('GPL2')
pkg_deps=('aspell')
pkg_source=("ftp://ftp.gnu.org/gnu/aspell/dict/it/aspell6-it-${_pkg_version}.tar.bz2")
pkg_shasum=('b1217299a0b67d1e121494d7ec18a88d')

do_build() {
  
  ./configure
  make
}

do_package() {
  
  make DESTDIR=${pkg_prefix} install
}
