pkg_origin=cosmos

pkg_name=aspell-pt
_pkg_versionPT=20170615
_pkg_versionBR=20090702
pkg_version=$_pkg_versionPT
pkg_description="Portuguese and Brazilian Portuguese dictionary for aspell"
pkg_upstream_url="http://aspell.net/"
pkg_license=('LGPL' 'GPL')
pkg_deps=('aspell')
pkg_source=("ftp://ftp.gnu.org/gnu/aspell/dict/pt_BR/aspell6-pt_BR-${_pkg_versionBR}-0.tar.bz2"
       "http://natura.di.uminho.pt/download/sources/Dictionaries/aspell6/aspell6.pt-${_pkg_versionPT}.tar.bz2"
       "http://natura.di.uminho.pt/download/sources/Dictionaries/aspell6/aspell6.pt-preao-${_pkg_versionPT}.tar.bz2")
pkg_shasum=('e082a8956882eb94a67c12e1b8c4a324'
         'e1169de3145bd0384362ef0206c01498'
         'fb8e753ca63e3dc830ca43830355da56')

do_build() {
  ./configure
  make

  ./configure
  make

  ./configure
  make
}

do_package() {
  make DESTDIR=${pkg_prefix} install

  make DESTDIR=${pkg_prefix} install

  make DESTDIR=${pkg_prefix} install

  echo "add pt_BR.multi" > ${pkg_prefix}/usr/lib/aspell-0.60/brasileiro.alias
}
