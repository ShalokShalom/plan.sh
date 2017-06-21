pkg_origin=cosmos

pkg_name=unrar
pkg_version=5.5.5
pkg_description="The RAR uncompression program"
pkg_upstream_url="http://www.rarlab.com/rar_add.htm"
pkg_license=('custom')
pkg_deps=('gcc-libs')
pkg_source=("http://www.rarlab.com/rar/unrarsrc-${pkg_version}.tar.gz")
pkg_shasum=('d741dfe5f09bc24679ac5d0158c88f20')

do_build() {

  make -f makefile
}

do_package() {

  install -Dm755 unrar ${CACHE_PATH}/usr/bin/unrar 
  # install license
  install -Dm644 license.txt ${CACHE_PATH}/usr/share/licenses/${pkg_name}/LICENSE 
}
