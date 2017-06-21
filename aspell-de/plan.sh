pkg_origin=cosmos

pkg_name=aspell-de
pkg_version=20161207
pkg_description="German dictionary for aspell"
pkg_upstream_url="http://aspell.net/"
pkg_license=('GPL2')
pkg_deps=('aspell')
pkg_source=("http://j3e.de/ispell/igerman98/dict/igerman98-${pkg_version}.tar.bz2")
pkg_shasum=('eb170f5d8992653b47ac4a15d127b58a')

do_build() {

  LANGS="de_DE de_AT de_CH"
  for l in ${LANGS}; do
    make aspell/${l}.rws
  done
}

do_package() {

  install -d ${pkg_prefix}/usr/lib/aspell-0.60

  LANGS="de_DE de_AT de_CH"
  for l in ${LANGS}; do
    install -m644 ${l}.alias ${l}.dat ${l}_affix.dat ${l}.multi ${l}.rws \
      ${pkg_prefix}/usr/lib/aspell-0.60/
  done

  echo "add de_DE.multi" > ${pkg_prefix}/usr/lib/aspell-0.60/deutsch.alias
  echo "add de_DE.multi" > ${pkg_prefix}/usr/lib/aspell-0.60/german.alias
  echo "add de_CH.multi" > ${pkg_prefix}/usr/lib/aspell-0.60/swiss.alias
}
