pkg_origin=cosmos

pkg_name=yasm
pkg_version=1.3.0
pkg_description="A rewrite of NASM to allow for multiple syntax supported (NASM, TASM, GAS, etc.)"
pkg_license=('custom')
pkg_upstream_url="http://www.tortall.net/projects/yasm/"
pkg_deps=('glibc')
pkg_source=("http://www.tortall.net/projects/yasm/releases/${pkg_name}-${pkg_version}.tar.gz")
pkg_shasum=('fc9e586751ff789b34b1f21d572d96af')

do_build() {
  
  ./configure --prefix=/usr
  make
}

do_check() {
  
  make check
}

do_package() {
  make DESTDIR=${CACHE_PATH} install
  
  install -Dm644 COPYING ${CACHE_PATH}/usr/share/licenses/${pkg_name}/LICENSE
}

