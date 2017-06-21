pkg_origin=cosmos

pkg_name=cloog
pkg_version=0.18.1
pkg_description="Library that generates loops for scanning polyhedra"
pkg_upstream_url="http://www.bastoul.net/cloog/"
pkg_license=('GPL')
pkg_deps=('isl' 'gmp')
pkg_source=("http://www.bastoul.net/cloog/pages/download/${pkg_name}-${pkg_version}.tar.gz"
        'isl-1.3-compat.patch')
pkg_shasum=('e34fca0540d840e5d0f6427e98c92252'
         '976c999b44c6e364455a670d12523242')

do_build() {
  cd "${CACHE_PATH}/${pkg_name}-${pkg_version}"
  patch -p1 -i $CACHE_PATH/isl-1.3-compat.patch
  
  ./configure --prefix=/usr --with-isl=system
  make
}

do_check() {
  cd "${CACHE_PATH}/${pkg_name}-${pkg_version}"
  
  make check
}

do_package() {
  cd "${CACHE_PATH}/${pkg_name}-${pkg_version}"
  
  make DESTDIR="${pkg_prefix}/" install
}
