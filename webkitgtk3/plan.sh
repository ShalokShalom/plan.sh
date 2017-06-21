pkg_origin=cosmos

pkg_name=webkitgtk3
_pkg_name=webkitgtk
pkg_version=2.4.11
pkg_description="GNOME platform port of the WebKit rendering engine, offering WebKit’s full functionality"
pkg_upstream_url="http://webkitgtk.org/"
pkg_license=('custom')
pkg_deps=('sqlite' 'libsoup' 'libsecret' 'libgl' 'gst-plugins-base' 'gst-plugins-good' # 'enchant' 
         'gtk3' 'libwebp' 'libxslt' 'libxt' 'harfbuzz')
pkg_build_deps=('gperf' 'gobject-introspection' 'python3' 'mesa' 'ruby' 'gtk2')
pkg_source=("http://webkitgtk.org/releases/${_pkg_name}-${pkg_version}.tar.xz")
pkg_shasum=('24a25ccc30a7914ae50922aedf24b7bc')

do_build() {
  
   ./configure --prefix=/usr \
       --libexecdir=/usr/lib/webkit \
       --enable-introspection \
       --disable-geolocation \
       --disable-gtk-doc
   
   sed -i 's/ -shared / -Wl,-O1,--as-needed\0/g' libtool
   make all stamp-po
}

do_package() {
   make -j1 DESTDIR=${CACHE_PATH} install

   install -Dm644 Source/WebKit/LICENSE ${CACHE_PATH}/usr/share/licenses/webkitgtk/LICENSE
   
   rm -r ${CACHE_PATH}/usr/share/gtk-doc
}
