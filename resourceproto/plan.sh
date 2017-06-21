pkg_origin=cosmos

pkg_name=resourceproto
pkg_version=1.2.0
pkg_description="X11 Resource extension wire protocol"
pkg_upstream_url="http://xorg.freedesktop.org/"
pkg_license=('custom')
pkg_source=("http://xorg.freedesktop.org/releases/individual/proto/${pkg_name}-${pkg_version}.tar.bz2")
pkg_shasum=('cfdb57dae221b71b2703f8e2980eaaf4')

do_build() {
  
  ./configure --prefix=/usr
  make
}

do_package() {
  make DESTDIR="${CACHE_PATH}" install 

  install -m755 -d "${CACHE_PATH}/usr/share/licenses/${pkg_name}"
  install -m644 COPYING "${CACHE_PATH}/usr/share/licenses/${pkg_name}/"
}
