pkg_origin=cosmos

pkg_name=aspell-gu
pkg_version=0.03
_pkg_version=0.03-0
pkg_description="Gujarati dictionary for aspell"
pkg_upstream_url="http://aspell.net"
pkg_license=('GPL')
pkg_deps=('aspell')
pkg_source=("ftp://ftp.gnu.org/gnu/aspell/dict/gu/aspell6-gu-${_pkg_version}.tar.bz2")
pkg_shasum=('dd9e466b23ced916d6bb89decc919976')

do_build() {
  
  ./configure
  make
}

do_package() {

  make DESTDIR=${pkg_prefix} install
}
