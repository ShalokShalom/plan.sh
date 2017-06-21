pkg_origin=cosmos

pkg_name=xproto
pkg_version=7.0.31
pkg_description="X11 core wire protocol and auxiliary headers"
pkg_license=('custom')
pkg_upstream_url="http://xorg.freedesktop.org/"
pkg_source=("http://xorg.freedesktop.org/releases/individual/proto/${pkg_name}-${pkg_version}.tar.bz2")
pkg_shasum=('16791f7ca8c51a20608af11702e51083')

do_build() {
  
  ./configure --prefix=/usr
  make
}

do_package() {
  make DESTDIR=${CACHE_PATH} install
  
  install -m755 -d ${CACHE_PATH}/usr/share/licenses/${pkg_name}
  install -m644 COPYING ${CACHE_PATH}/usr/share/licenses/${pkg_name}/
}
