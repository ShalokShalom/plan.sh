pkg_origin=cosmos

pkg_name=scrnsaverproto
pkg_version=1.2.2
pkg_description="X11 Screen Saver extension wire protocol"
pkg_license=('custom')
pkg_upstream_url="http://xorg.freedesktop.org/"
pkg_source=("http://xorg.freedesktop.org/releases/individual/proto/${pkg_name}-${pkg_version}.tar.bz2")
pkg_shasum=('edd8a73775e8ece1d69515dd17767bfb')

do_build() {
  
  ./configure --prefix=/usr
  make
}

do_package() {
  make DESTDIR="${CACHE_PATH}" install
  
  install -Dm644 COPYING "${CACHE_PATH}/usr/share/licenses/${pkg_name}/COPYING"
}
