pkg_origin=cosmos

pkg_name=hunspell-pl
pkg_version=20160404
pkg_description='Polish dictionary for Hunspell/Myspell'
pkg_upstream_url='http://www.sjp.pl/slownik/ort/'
pkg_license=('GPL')
pkg_deps=('hunspell')
pkg_source=("http://sjp.pl/slownik/ort/sjp-myspell-pl-$pkg_version.zip")
pkg_shasum=('8e3df50074f399ae8b6462f17edb7aec')

prepare() {
  bsdtar -xf pl_PL.zip
}

do_package() {
  install -dm755 "$pkg_prefix"/usr/share/hunspell
  install -m644 pl_PL.aff "$pkg_prefix"/usr/share/hunspell
  install -m644 pl_PL.dic "$pkg_prefix"/usr/share/hunspell

  install -dm755 ${pkg_prefix}/usr/share/myspell/dicts
  pushd "$pkg_prefix"/usr/share/myspell/dicts
  for file in "$pkg_prefix"/usr/share/hunspell/*; do
    ln -sv /usr/share/hunspell/$(basename $file) .
  done
  popd

  install -dm755 "$pkg_prefix"/usr/share/doc/$pkg_name
  install -m644 README_pl_PL.txt "$pkg_prefix"/usr/share/doc/$pkg_name
}
