pkg_origin=cosmos

pkg_name=webkitgtk2
_pkg_name=webkitgtk
pkg_version=2.4.11
pkg_upstream_url="http://webkitgtk.org/"
pkg_description="GTK+ Web content engine library for GTK+ 2.0"
pkg_license=('custom')
pkg_deps=('libxt' 'libxslt' 'sqlite' 'libsoup' 'libgl' 'gtk2'
         'gst-plugins-base' 'icu' 'libwebp' 'libsecret')
pkg_build_deps=('gperf' 'gobject-introspection' 'python2' 'mesa' 'ruby')
pkg_source=("http://webkitgtk.org/releases/${_pkg_name}-${pkg_version}.tar.xz")
pkg_shasum=('24a25ccc30a7914ae50922aedf24b7bc')

do_build() {
 
  ./configure --prefix=/usr \
    --enable-introspection \
    --libexecdir=/usr/lib/webkitgtk2 \
    --with-gtk=2.0 \
    --enable-geolocation=no \
    --disable-webkit2 \
    --disable-gtk-doc
    
  sed -i 's/ -shared / -Wl,-O1,--as-needed\0/g' libtool
  make 
}

do_package() {
  make -j1 DESTDIR=${CACHE_PATH} install

  install -Dm644 Source/WebKit/LICENSE ${CACHE_PATH}/usr/share/licenses/${pkg_name}/LICENSE
}
