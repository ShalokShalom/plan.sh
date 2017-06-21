pkg_origin=cosmos

pkg_name=aspell-fr
pkg_version=0.50.3
_pkg_version=0.50-3
pkg_description="French dictionary for aspell"
pkg_upstream_url="http://aspell.net/"
pkg_license=('GPL')
pkg_deps=('aspell')
pkg_source=("ftp://ftp.gnu.org/gnu/aspell/dict/fr/${pkg_name}-${_pkg_version}.tar.bz2")
pkg_shasum=('53a2d05c4e8f7fabd3cefe24db977be7')

do_build() {
  ./configure 
  make 
}

do_package() {
  
  make DESTDIR=${pkg_prefix} install 
}
