pkg_origin=cosmos

pkg_name=aspell-ru
pkg_version=0.99f7
_pkg_version=0.99f7-1
pkg_description="Russian dictionary for aspell"
pkg_upstream_url="http://aspell.net/"
pkg_license=('custom')
pkg_deps=('aspell')
pkg_source=("ftp://ftp.gnu.org/gnu/aspell/dict/ru/aspell6-ru-${_pkg_version}.tar.bz2")
pkg_shasum=('c4c98eaa5e77ad3adccbc5c96cb57cb3')

do_build() {
  
  ./configure
  make
}

do_package() {
  make DESTDIR=${pkg_prefix} install
  
  install -D -m644 Copyright ${pkg_prefix}/usr/share/licenses/${pkg_name}/LICENSE
}
