pkg_origin=cosmos

pkg_name=botan
pkg_version=1.10.3
pkg_description="BSD-licensed crypto library written in C++"
pkg_license=('BSD')
pkg_upstream_url="http://botan.randombit.net/"
pkg_deps=('gcc-libs' 'sh')
pkg_build_deps=('python')
pkg_source=("http://files.randombit.net/botan/Botan-${pkg_version}.tgz")
pkg_shasum=('1b5fcbc5795f615219277efc5059c886')

do_build() {
  
  ./configure.py --prefix=/usr
  make 
}

do_package() {
  
  make DESTDIR=${pkg_prefix}/usr install
}
