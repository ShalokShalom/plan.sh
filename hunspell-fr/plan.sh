pkg_origin=cosmos

pkg_name=hunspell-fr
pkg_version=6.1
pkg_description="French (modern) hunspell dictionaries"
pkg_upstream_url="http://www.dicollecte.org/"
pkg_license=('GPL' 'MPL' 'LGPL')
pkg_deps=('hunspell:	the spell checking libraries and apps')
pkg_source=("http://www.dicollecte.org/download/fr/hunspell-french-dictionaries-v${pkg_version}.zip")
pkg_shasum=('52b46315196f56112715f765f550fee6')

do_package() {
  install -dm755 ${pkg_prefix}/usr/share/hunspell
  install -m644 fr-moderne.dic ${pkg_prefix}/usr/share/hunspell/fr_FR.dic
  install -m644 fr-moderne.aff ${pkg_prefix}/usr/share/hunspell/fr_FR.aff

  pushd ${pkg_prefix}/usr/share/hunspell/
  fr_FR_aliases="fr_BE fr_CA fr_CH fr_LU"
  for lang in ${fr_FR_aliases}; do
	ln -s fr_FR.aff ${lang}.aff
	ln -s fr_FR.dic ${lang}.dic
  done

  popd

  install -dm755 ${pkg_prefix}/usr/share/myspell/dicts
  pushd ${pkg_prefix}/usr/share/myspell/dicts
    for file in ${pkg_prefix}/usr/share/hunspell/*; do
      ln -sv /usr/share/hunspell/$(basename ${file}) .
    done
  popd
  
  install -Dm644 README_dict_fr.txt $pkg_prefix/usr/share/doc/${pkg_name}/README_fr.txt
}
