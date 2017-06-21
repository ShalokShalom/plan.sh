pkg_origin=cosmos

pkg_name=xtrans
pkg_version=1.3.5
pkg_description="X transport library"
pkg_license=('custom')
pkg_upstream_url="http://xorg.freedesktop.org/"
pkg_source=("http://xorg.freedesktop.org/releases/individual/lib/${pkg_name}-${pkg_version}.tar.bz2")
pkg_shasum=('c5ba432dd1514d858053ffe9f4737dd8')

do_build() {
  
  ./configure --prefix=/usr
  make
}

do_package() {
  make DESTDIR="${CACHE_PATH}" install
  
  install -Dm644 COPYING "${CACHE_PATH}/usr/share/licenses/${pkg_name}/COPYING"
  install -m755 -d "${CACHE_PATH}/usr/lib"
  mv "${CACHE_PATH}/usr/share/pkgconfig" "${CACHE_PATH}/usr/lib/pkgconfig"
}
