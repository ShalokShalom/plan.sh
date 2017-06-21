pkg_origin=cosmos

pkg_name=isl
pkg_version=0.13
pkg_description="Library for manipulating sets and relations of integer points bounded by linear constraints"
pkg_upstream_url="https://www.ohloh.net/p/isl"
pkg_deps=('gmp')
pkg_license=('MIT')
pkg_source=("http://isl.gforge.inria.fr/$pkg_name-$pkg_version.tar.bz2")
pkg_shasum=('e4cf20c4c10d5d613457558b1f46b5e2')

do_build() {
  cd "${CACHE_PATH}/${pkg_name}-${pkg_version}"
  
  ./configure --prefix=/usr
  make
}

do_check() {
  cd "${CACHE_PATH}/${pkg_name}-${pkg_version}"
  
  make check
}

do_package() {
  cd "${CACHE_PATH}/${pkg_name}-${pkg_version}"
  make DESTDIR="${pkg_prefix}/" install
  
  install -dm755 $pkg_prefix/usr/share/gdb/auto-load/usr/lib/
  mv $pkg_prefix/usr/lib/libisl.so.*-gdb.py $pkg_prefix/usr/share/gdb/auto-load/usr/lib/
  
  install -Dm644 LICENSE $pkg_prefix/usr/share/licenses/isl/LICENSE
}

