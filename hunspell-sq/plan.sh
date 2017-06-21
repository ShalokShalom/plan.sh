pkg_origin=cosmos

pkg_name=hunspell-sq
pkg_version=1.6.4
pkg_description="Albanian hunspell dictionaries"
pkg_upstream_url="http://www.shkenca.org/k6i/albanian_dictionary_for_myspell_en.html"
pkg_license=('GPLv2+')
pkg_deps=('hunspell')
pkg_source=("http://www.shkenca.org/shkarkime/myspell-sq_AL-${pkg_version}.zip")
pkg_shasum=('bb5af887e76373251ef070f299e5bb09')


do_package() {
  install -dm755 ${pkg_prefix}/usr/share/hunspell
  install -D -m644 sq_AL.dic "${pkg_prefix}/usr/share/hunspell/sq_AL.dic"
  install -D -m644 sq_AL.aff "${pkg_prefix}/usr/share/hunspell/sq_AL.aff"

  install -dm755 ${pkg_prefix}/usr/share/myspell/dicts
  pushd $pkg_prefix/usr/share/myspell/dicts
    for file in $pkg_prefix/usr/share/hunspell/*; do
      ln -sv /usr/share/hunspell/$(basename $file) .
    done
  popd
  
  install -Dm644 README.txt $pkg_prefix/usr/share/doc/$pkg_name/README.txt
  install -Dm644 Copyright $pkg_prefix/usr/share/doc/$pkg_name/Copyright
}

