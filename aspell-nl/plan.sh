pkg_origin=cosmos

pkg_name=aspell-nl
pkg_version=0.50.2
pkg_description="Dutch dictionary for aspell"
pkg_upstream_url="http://aspell.net/"
pkg_license=('custom')
pkg_deps=('aspell')
pkg_source=("ftp://ftp.gnu.org/gnu/aspell/dict/nl/${pkg_name}-0.50-2.tar.bz2")
pkg_shasum=('c3ef9fd7dc4c47d816eee9ef5149c76a')

do_build() {
  
  ./configure
  make
}
do_package() {
  make DESTDIR=${pkg_prefix} install
  
  install -D -m644 Copyright $pkg_prefix/usr/share/licenses/${pkg_name}/LICENSE
}
