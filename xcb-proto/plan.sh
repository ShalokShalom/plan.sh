pkg_origin=cosmos

pkg_name=xcb-proto
pkg_version=1.12
pkg_description="XML-XCB protocol descriptions"
pkg_upstream_url="https://xcb.freedesktop.org/"
pkg_license=('custom')
pkg_build_deps=('python3' 'libxml2')
pkg_source=("https://xcb.freedesktop.org/dist/${pkg_name}-${pkg_version}.tar.bz2")
pkg_shasum=('14e60919f859560f28426a685a555962')

do_build() {
  
  ./configure --prefix=/usr
  make
}

do_package() {
  make DESTDIR=${CACHE_PATH} install
  
  install -m755 -d ${CACHE_PATH}/usr/share/licenses/${pkg_name}
  install -m644 COPYING ${CACHE_PATH}/usr/share/licenses/${pkg_name}/
}
