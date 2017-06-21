pkg_origin=cosmos

pkg_name=hunspell-de
pkg_version=20161207
pkg_description="German hunspell dictionaries"
pkg_upstream_url="https://www.j3e.de/ispell/igerman98/"
pkg_license=('GPL')
pkg_deps=('hunspell')
pkg_build_deps=('ispell')
pkg_source=("https://www.j3e.de/ispell/igerman98/dict/igerman98-${pkg_version}.tar.bz2")
pkg_shasum=('eb170f5d8992653b47ac4a15d127b58a')

do_build() {
  make hunspell/de_AT.dic hunspell/de_AT.aff \
       hunspell/de_CH.dic hunspell/de_CH.aff \
       hunspell/de_DE.dic hunspell/de_DE.aff
}

do_package() {
  install -dm755 ${pkg_prefix}/usr/share/hunspell
  cp -p de_??.dic de_??.aff ${pkg_prefix}/usr/share/hunspell

  pushd ${pkg_prefix}/usr/share/hunspell/
  de_DE_aliases="de_BE de_LU"
  for lang in $de_DE_aliases; do
    ln -s de_DE.aff $lang.aff
    ln -s de_DE.dic $lang.dic
  done
  de_CH_aliases="de_LI"
  for lang in $de_CH_aliases; do
    ln -s de_CH.aff $lang.aff
    ln -s de_CH.dic $lang.dic
  done
  popd

  install -dm755 ${pkg_prefix}/usr/share/myspell/dicts
  pushd ${pkg_prefix}/usr/share/myspell/dicts
    for file in ${pkg_prefix}/usr/share/hunspell/*; do
      ln -sv /usr/share/hunspell/$(basename $file) .
    done
  popd

  install -dm755 ${pkg_prefix}/usr/share/doc/${pkg_name}
  cp -p README_de_??.txt ${pkg_prefix}/usr/share/doc/${pkg_name}
}
