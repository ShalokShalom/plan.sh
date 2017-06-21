pkg_origin=cosmos

pkg_name=xbitmaps
pkg_version=1.1.1
pkg_description="X.org Bitmap files"
pkg_upstream_url="http://xorg.freedesktop.org/"
pkg_license=('custom')
pkg_build_deps=('xorg-util-macros')
pkg_source=("http://xorg.freedesktop.org/releases/individual/data/${pkg_name}-${pkg_version}.tar.bz2")
pkg_shasum=('7444bbbd999b53bec6a60608a5301f4c')

do_build() {
  
  ./configure --prefix=/usr
  make
}

do_package() {
  make DESTDIR="${CACHE_PATH}" install
  
  install -Dm644 COPYING "${CACHE_PATH}/usr/share/licenses/${pkg_name}/COPYING"
}
