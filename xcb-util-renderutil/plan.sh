pkg_origin=cosmos

pkg_name=xcb-util-renderutil
pkg_version=0.3.9
pkg_description="Utility libraries for XC Binding"
pkg_upstream_url="http://xcb.freedesktop.org"
pkg_license=('custom')
pkg_deps=('libxcb' 'xcb-util')
pkg_build_deps=('gperf')
pkg_source=("http://xcb.freedesktop.org/dist/${pkg_name}-${pkg_version}.tar.bz2"
        'LICENSE')
pkg_shasum=('468b119c94da910e1291f3ffab91019a'
         '2672c2e72dedb40f773e989dd622f298')

do_build() {
  
  ./configure --prefix=/usr --disable-static
  make
}

do_package() { 
  make DESTDIR="${CACHE_PATH}" install

  install -D -m644 "${CACHE_PATH}/LICENSE" \
    "${CACHE_PATH}/usr/share/licenses/${pkg_name}/LICENSE"
}
