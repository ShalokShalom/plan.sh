pkg_origin=cosmos

pkg_name=xf86driproto
pkg_version=2.1.1
pkg_description="X11 DRI extension wire protocol"
pkg_build_deps=('xorg-util-macros')
pkg_upstream_url="http://xorg.freedesktop.org/"
pkg_license=('custom')
pkg_source=("http://xorg.freedesktop.org/releases/individual/proto/${pkg_name}-${pkg_version}.tar.bz2")
pkg_shasum=('1d716d0dac3b664e5ee20c69d34bc10e')

do_build() {
  
  ./configure --prefix=/usr
  make
}

do_package() {
  make DESTDIR="${CACHE_PATH}" install

  install -Dm644 COPYING "${CACHE_PATH}/usr/share/licenses/${pkg_name}/COPYING"
}
