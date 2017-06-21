pkg_origin=cosmos

pkg_name=recordproto
pkg_version=1.14.2
pkg_description="X11 Record extension wire protocol"
pkg_upstream_url="http://xorg.freedesktop.org/"
pkg_license=('custom')
pkg_source=("http://xorg.freedesktop.org/releases/individual/proto/${pkg_name}-${pkg_version}.tar.bz2")
pkg_shasum=('1b4e5dede5ea51906f1530ca1e21d216')

do_build() {
  
  ./configure --prefix=/usr
  make
}

do_package() {
  make DESTDIR=${CACHE_PATH} install
  
  install -D -m644 COPYING ${CACHE_PATH}/usr/share/licenses/${pkg_name}/LICENSE
}
