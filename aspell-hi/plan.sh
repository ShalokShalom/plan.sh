pkg_origin=cosmos

pkg_name=aspell-hi
pkg_version=0.02
_pkg_version=0.02-0
pkg_description="Hindi dictionary for aspell"
pkg_upstream_url="http://aspell.net"
pkg_license=('GPL')
pkg_deps=('aspell')
pkg_source=("ftp://ftp.gnu.org/gnu/aspell/dict/hi/aspell6-hi-${_pkg_version}.tar.bz2")
pkg_shasum=('4fd4aedbda587bbc4eecb9d3ea57591d')

do_build() {
  
  ./configure
  make
}

do_package() {

  make DESTDIR=${pkg_prefix} install
}
