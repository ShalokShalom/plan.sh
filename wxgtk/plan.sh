pkg_origin=cosmos

pkg_name=wxgtk
pkg_version=3.0.3.1
pkg_description="GTK+ implementation of wxWidgets API for GUI"
pkg_upstream_url="http://wxwidgets.org"
pkg_license=('custom:wxWindows')
pkg_deps=('gtk2' 'glu' 'gst-plugins-base')
pkg_build_deps=('gconf')
pkg_source=("https://github.com/wxWidgets/wxWidgets/releases/download/v${pkg_version}/wxWidgets-${pkg_version}.tar.bz2")
pkg_shasum=('694ed5f5ea1597e06a9adc6f347d8929')

do_prepare() {
  #patch -p1 -i ../wxGTK-2.9.5-collision.patch
}

do_build() {
  
  ./configure --prefix=/usr \
    --libdir=/usr/lib \
    --with-gtk=2 \
    --with-opengl \
    --enable-unicode \
    --enable-graphics_ctx \
    --enable-mediactrl \
    --disable-webview \
    --with-regex=builtin \
    --with-libpng=sys \
    --with-libxpm=sys \
    --with-libjpeg=sys \
    --with-libtiff=sys \
    --disable-precomp-headers 
  make
  make -C locale allmo
}

do_package() {
  make DESTDIR=${CACHE_PATH} install
  
  install -D -m644 docs/licence.txt ${CACHE_PATH}/usr/share/licenses/${pkg_name}/LICENSE
}
