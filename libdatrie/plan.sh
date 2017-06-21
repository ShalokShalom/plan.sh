pkg_origin=cosmos

pkg_name=libdatrie
pkg_version=0.2.10
pkg_description="Implementation of double-array structure for representing trie, as proposed by Junichi Aoe."
pkg_upstream_url="https://linux.thai.net/projects/datrie"
pkg_license=('LGPL')
pkg_deps=('glibc')
pkg_source=("https://linux.thai.net/pub/thailinux/software/libthai/${pkg_name}-${pkg_version}.tar.xz")
pkg_shasum=('22d4fca2a09c58584a461b115d3d57f1')

do_build() {
  
  ./configure --prefix=/usr --disable-static
  make
}

do_package() {
  
  make DESTDIR=${pkg_prefix} install
}

