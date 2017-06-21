pkg_origin=cosmos

pkg_name=xcmiscproto
pkg_version=1.2.2
pkg_description="X11 XC-Miscellaneous extension wire protocol"
pkg_upstream_url="http://xorg.freedesktop.org/"
pkg_license=('custom')
pkg_build_deps=('xorg-util-macros')
pkg_source=("http://xorg.freedesktop.org/releases/individual/proto/${pkg_name}-${pkg_version}.tar.bz2")
pkg_shasum=('5f4847c78e41b801982c8a5e06365b24')

do_build() {
  
  ./configure --prefix=/usr 
  make
}

do_package() {
  make DESTDIR="${CACHE_PATH}" install
  
  install -Dm644 COPYING "${CACHE_PATH}/usr/share/licenses/${pkg_name}/COPYING"
}
