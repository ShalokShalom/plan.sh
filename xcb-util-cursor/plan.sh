pkg_origin=cosmos

pkg_name=xcb-util-cursor
pkg_version=0.1.3
pkg_description='XCB cursor port of libxcursor'
pkg_upstream_url='http://cgit.freedesktop.org/xcb/util-cursor'
pkg_license=('custom:MIT')
pkg_deps=('libxcb' 'xcb-util-image' 'xcb-util-renderutil')
pkg_source=("http://xcb.freedesktop.org/dist/xcb-util-cursor-${pkg_version}.tar.bz2")
pkg_shasum=('6ac3b17cba51aaaa36ba035a53527214')

do_build() {

  ./configure --prefix=/usr
  make
}

do_package() {
  make DESTDIR=${CACHE_PATH} install

  install -Dm644 COPYING ${CACHE_PATH}/usr/share/licenses/${pkg_name}/LICENSE
}
