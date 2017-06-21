pkg_origin=cosmos

pkg_name=hunspell-it
pkg_version=2.4
_pkg_version=2_4
_date=2007_09_01
pkg_description="Italian dictionary for Hunspell"
pkg_upstream_url="http://sourceforge.net/projects/linguistico/"
pkg_license=('GPL3')
pkg_deps=('hunspell')
pkg_source=("http://downloads.sourceforge.net/linguistico/italiano_${_pkg_version}_${_date}.zip")
pkg_shasum=('e7fbd9e2dfb25ea3288cdb918e1e1260')

do_build() {

  sed '/^\/$/d' -i it_IT.dic
}

do_package() {
  install -dm755 ${pkg_prefix}/usr/share/hunspell

  install -D -m644 it_IT.dic "${pkg_prefix}/usr/share/hunspell/it_IT.dic"
  install -D -m644 it_IT.aff "${pkg_prefix}/usr/share/hunspell/it_IT.aff"

  pushd $pkg_prefix/usr/share/hunspell/
  it_IT_aliases="it_CH"
  for lang in $it_IT_aliases; do
       ln -s it_IT.aff $lang.aff
       ln -s it_IT.dic $lang.dic
  done
  popd

  # the symlinks
  install -dm755 ${pkg_prefix}/usr/share/myspell/dicts
  pushd $pkg_prefix/usr/share/myspell/dicts
    for file in $pkg_prefix/usr/share/hunspell/*; do
      ln -sv /usr/share/hunspell/$(basename $file) .
    done
  popd
}
