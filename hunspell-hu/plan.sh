pkg_origin=cosmos

pkg_name=hunspell-hu
pkg_version=1.6.1
pkg_description="Hungarian hunspell dictionary"
pkg_upstream_url="http://extensions.services.openoffice.org/project/hu_dicts"
pkg_license=('LGPL' 'GPL' 'MPL')
pkg_deps=('hunspell')
pkg_source=("http://sourceforge.net/projects/aoo-extbeta/files/1283/9/dict-hu.oxt")
pkg_shasum=('d320e43e815c2dfd599dbfb7cd0e41fb')


do_package() {
  install -dm755 ${pkg_prefix}/usr/share/hunspell
  install -m644 -t $pkg_prefix/usr/share/hunspell hu_HU.dic hu_HU.aff

  install -dm755 ${pkg_prefix}/usr/share/myspell/dicts
  pushd $pkg_prefix/usr/share/myspell/dicts
    for file in $pkg_prefix/usr/share/hunspell/*; do
      ln -sv /usr/share/hunspell/$(basename $file) .
    done
  popd
  
  install -Dm644 README_hu_HU.txt $pkg_prefix/usr/share/doc/$pkg_name/README_hu_HU.txt
}

