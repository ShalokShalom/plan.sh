pkg_origin=cosmos

pkg_name=t1lib
pkg_version=5.1.2
pkg_description="Library for generating character- and string-glyphs from Adobe Type 1 fonts"
pkg_upstream_url="http://www.ibiblio.org/pub/Linux/libs/graphics/!INDEX.html"
pkg_license=("GPL")
pkg_deps=('libxaw')
pkg_source=("http://www.ibiblio.org/pub/Linux/libs/graphics/${pkg_name}-${pkg_version}.tar.gz")
pkg_shasum=('a5629b56b93134377718009df1435f3c')

do_build() {
  
  ./configure --prefix=/usr
  make without_doc 
}

do_package() {
  
  make DESTDIR=${CACHE_PATH} install
}
