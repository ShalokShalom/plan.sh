pkg_origin=cosmos

pkg_name=aspell-cs
pkg_version=20040614
pkg_description="Czech dictionary for aspell"
pkg_upstream_url="http://aspell.net/"
pkg_license=('GPL')
pkg_deps=('aspell')
pkg_source=("ftp://ftp.gnu.org/gnu/aspell/dict/cs/aspell6-cs-${pkg_version}-1.tar.bz2")
pkg_shasum=('50f0c2b7b6fcfe47bb647ad8993d2fe8')

do_build() {

  ./configure
  make
}

do_package() {

  make DESTDIR=${pkg_prefix} install
}
