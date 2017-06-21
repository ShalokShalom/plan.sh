pkg_origin=cosmos

pkg_name=aspell-es
pkg_version=1.11
_pkg_version=1.11-2
pkg_description="Spanish dictionary for aspell"
pkg_upstream_url="http://aspell.net/"
pkg_license=('GPL')
pkg_deps=('aspell')
pkg_source=("ftp://ftp.gnu.org/gnu/aspell/dict/es/aspell6-es-${_pkg_version}.tar.bz2")
pkg_shasum=('8406336a89c64e47e96f4153d0af70c4')

do_build() {
  
  ./configure
  make
}

do_package() {
    
  make DESTDIR=${pkg_prefix} install
}
