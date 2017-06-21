pkg_origin=cosmos

pkg_name=xineramaproto
pkg_version=1.2.1
pkg_description="X11 Xinerama extension wire protocol"
pkg_upstream_url="http://xorg.freedesktop.org/"
pkg_license=('custom')
pkg_source=("http://xorg.freedesktop.org/releases/individual/proto/${pkg_name}-${pkg_version}.tar.bz2")
pkg_shasum=('9959fe0bfb22a0e7260433b8d199590a')

do_build() {
  
  ./configure --prefix=/usr
  make
}

do_package() {
  make DESTDIR="${CACHE_PATH}" install
  
  install -Dm644 COPYING "${CACHE_PATH}/usr/share/licenses/${pkg_name}/COPYING"
}
