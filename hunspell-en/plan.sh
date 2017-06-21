pkg_origin=cosmos

pkg_name=hunspell-en
pkg_version=2017.01.22
pkg_description="English hunspell dictionaries"
pkg_upstream_url="http://wordlist.aspell.net/"
pkg_license=('LGPL' 'custom:scowl')
pkg_deps=('hunspell:	the spell checking libraries and apps')
pkg_source=("http://downloads.sourceforge.net/wordlist/hunspell-en_US-${pkg_version}.zip"
        "http://downloads.sourceforge.net/wordlist/hunspell-en_CA-${pkg_version}.zip"
        "http://downloads.sourceforge.net/wordlist/hunspell-en_GB-large-${pkg_version}.zip")
pkg_shasum=('9af4f5e765f02bce36c9ee91fcce02b5'
         '10e7b9ae290217a127056897496d26ea'
         'e511d126a9b02413e81f501c28ff7f8c')

do_build() {
 /bin/true
}

do_package() {
  install -dm755 ${pkg_prefix}/usr/share/hunspell
  install -m644 en_*.dic en_*.aff ${pkg_prefix}/usr/share/hunspell

  pushd ${pkg_prefix}/usr/share/hunspell/
  en_GB_aliases="en_AG en_AU en_BS en_BW en_BZ en_DK en_GH en_HK en_IE en_IN en_JM en_NA en_NG en_NZ en_SG en_TT en_ZA en_ZW"
  for lang in $en_GB_aliases; do
	ln -s en_GB-large.aff $lang.aff
	ln -s en_GB-large.dic $lang.dic
  done
  en_US_aliases="en_PH"
  for lang in $en_US_aliases; do
	ln -s en_US.aff $lang.aff
	ln -s en_US.dic $lang.dic
  done
  popd

  # the symlinks
  install -dm755 ${pkg_prefix}/usr/share/myspell/dicts
  pushd ${pkg_prefix}/usr/share/myspell/dicts
    for file in ${pkg_prefix}/usr/share/hunspell/*; do
      ln -sv /usr/share/hunspell/$(basename $file) .
    done
  popd
  
  # docs
  install -dm755 ${pkg_prefix}/usr/share/doc/${pkg_name}
  install -m644 README_en_??.txt ${pkg_prefix}/usr/share/doc/${pkg_name}

  # licenses
  install -D -m644 README_en_US.txt ${pkg_prefix}/usr/share/licenses/${pkg_name}/Copyright_en_US
  install -D -m644 README_en_CA.txt ${pkg_prefix}/usr/share/licenses/${pkg_name}/Copyright_en_CA
  install -D -m644 README_en_GB-large.txt ${pkg_prefix}/usr/share/licenses/${pkg_name}/Copyright_en_GB
}
