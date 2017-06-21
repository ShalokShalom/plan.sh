pkg_origin=cosmos

pkg_name=libmythes
pkg_version=1.2.4
pkg_description="a simple thesaurus"
pkg_upstream_url="http://hunspell.sourceforge.net/ "
pkg_license=('custom')
pkg_deps=('glibc' 'perl')
pkg_build_deps=('hunspell')
pkg_source=("http://downloads.sourceforge.net/hunspell/${pkg_name/lib/}-${pkg_version}.tar.gz")
pkg_shasum=('a8c2c5b8f09e7ede322d5c602ff6a4b6')

do_build() {
  ./configure --prefix=/usr --disable-static
  make

  ./example th_en_US_new.idx th_en_US_new.dat checkme.lst
  ./example morph.idx morph.dat morph.lst morph.aff morph.dic
}

do_package() {
  make DESTDIR=$pkg_prefix install

  install -Dm644 ${CACHE_PATH}/${pkg_name/lib/}-$pkg_version/COPYING $pkg_prefix/usr/share/licenses/$pkg_name/COPYING
}
