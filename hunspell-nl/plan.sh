pkg_origin=cosmos
pkg_name=hunspell-nl
pkg_version=2.10g
pkg_description="Dutch hunspell dictionaries"
pkg_upstream_url="http://www.opentaal.org/"
pkg_license=('BSD' 'custom:Creative Commons, Attribution 3.0 Unported')
pkg_deps=('hunspell')
pkg_build_deps=('unzip')
pkg_source=("http://opentaal.org/bestanden/license_result/20-woordenlijst-v-210g-voor-openofficeorg-3?bid=20&agree=1")
#pkg_source=('https://sourceforge.net/projects/kaosx/files/sources/hunspell/OpenTaal-210G-LO.oxt')
pkg_shasum=('3c96686c2555e3ae23b5de06ba08631b')

do_package() {
  install -dm755 "${pkg_prefix}/usr/share/hunspell"
  install -m644 nl_NL.dic "${pkg_prefix}/usr/share/hunspell/nl_NL.dic"
  install -m644 nl_NL.aff "${pkg_prefix}/usr/share/hunspell/nl_NL.aff"

  pushd "${pkg_prefix}/usr/share/hunspell/"
  nl_NL_aliases="nl_AW nl_BE"
  for lang in $nl_NL_aliases; do
      ln -s nl_NL.aff $lang.aff
      ln -s nl_NL.dic $lang.dic
  done
  popd

  # the symlinks
  install -dm755 "${pkg_prefix}/usr/share/myspell/dicts"
  pushd "${pkg_prefix}/usr/share/myspell/dicts"
    for file in ${pkg_prefix}/usr/share/hunspell/*; do
      ln -sv /usr/share/hunspell/$(basename $file) .
    done
  popd

  install -dm755 "${pkg_prefix}/usr/share/doc/${pkg_name}"
  install -m644 README_nl_NL.txt "${pkg_prefix}/usr/share/doc/${pkg_name}"
  install -D -m644 license_en_EN.txt $pkg_prefix/usr/share/licenses/$pkg_name/license_en_EN.txt
}
