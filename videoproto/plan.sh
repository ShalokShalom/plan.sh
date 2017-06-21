pkg_origin=cosmos

pkg_name=videoproto
pkg_version=2.3.3
pkg_description="X11 Video extension wire protocol"
pkg_upstream_url="http://xorg.freedesktop.org/"
pkg_license=('custom')
pkg_source=("http://xorg.freedesktop.org/releases/individual/proto/${pkg_name}-${pkg_version}.tar.bz2")
pkg_shasum=('fe86de8ea3eb53b5a8f52956c5cd3174')

do_build() {
  
  ./configure --prefix=/usr 
  make 
}

do_package() {
  make DESTDIR="${CACHE_PATH}" install
  
  install -Dm644 COPYING "${CACHE_PATH}/usr/share/licenses/${pkg_name}/COPYING"
}
