pkg_origin=cosmos

pkg_name=unionfs-fuse
pkg_version=2.0
pkg_description="Userland unionfs implementation that is way more flexible than the current in-kernel based unionfs solution."
pkg_upstream_url="https://github.com/rpodgorny/unionfs-fuse"
pkg_license=('BSD')
pkg_deps=('fuse')
pkg_build_deps=('cmake')
pkg_source=("https://github.com/rpodgorny/unionfs-fuse/archive/v${pkg_version}.tar.gz")
pkg_shasum=('40411d156ea7fa0e7cd0a8ec6fe60e70')

do_build() {
  
  make
}

do_package() {
  make DESTDIR=${CACHE_PATH} PREFIX=/usr install
  
  install -Dm644 ${CACHE_PATH}/$pkg_name-$pkg_version/LICENSE ${CACHE_PATH}/usr/share/licenses/${pkg_name}/LICENSE
}
