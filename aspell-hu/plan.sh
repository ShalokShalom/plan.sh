pkg_origin=cosmos

pkg_name=aspell-hu
pkg_version=0.99.4.2
_pkg_version=0.99.4.2-0
pkg_description="Hungarian spellcheck dictionary for aspell"
pkg_upstream_url="http://aspell.net/"
pkg_license=('GPL')
pkg_deps=('aspell')
pkg_source=("ftp://ftp.gnu.org/gnu/aspell/dict/hu/aspell6-hu-${_pkg_version}.tar.bz2")
pkg_shasum=('4f4e1e98019a89d0ebf43ec59ae68254')

do_build() {

  ./configure
  make
}

do_package() {

  make DESTDIR=${pkg_prefix} install
}
