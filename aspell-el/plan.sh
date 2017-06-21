pkg_origin=cosmos

pkg_name=aspell-el
pkg_version=0.50
_pkg_version=0.50-3
pkg_description="Greek dictionary for aspell."
pkg_upstream_url="http://aspell.net/"
pkg_license=('GPL')
pkg_deps=('aspell')
pkg_source=("ftp://ftp.gnu.org/gnu/aspell/dict/el/${pkg_name}-${_pkg_version}.tar.bz2")
pkg_shasum=('0ea2c42ceb9b91f7f5de2c017234ad37')

do_build() {
  
  ./configure
  make
}

do_package() {
  
  make DESTDIR=${pkg_prefix} install
}
