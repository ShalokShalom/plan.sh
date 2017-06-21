pkg_origin=cosmos

pkg_name=gdk-pixbuf2
pkg_version=2.36.6
_pkg_version=2.36
pkg_description="An image loading library"
pkg_upstream_url="http://www.gtk.org/"
pkg_license=('LGPL2.1')
pkg_deps=('glib2' 'libpng' 'libtiff' 'libjpeg-turbo' 'libx11')
pkg_build_deps=('gobject-introspection')
install=gdk-pixbuf2.install
pkg_source=("https://download.gnome.org/sources/gdk-pixbuf/${_pkg_version}/gdk-pixbuf-${pkg_version}.tar.xz"
        'gdk-pixbuf-query-loaders.hook')
pkg_shasum=('5dd53760750670d27c194ff6ace7eb51'
         '6f0b295e93b2c599622e9af078583e01')

do_build() {

  ./configure --prefix=/usr \
    --without-libjasper \
    --with-x11 \
    --with-included-loaders=png
  make
}

do_package() {
  make DESTDIR=${pkg_prefix} install
  
  install -Dm644 ../gdk-pixbuf-query-loaders.hook ${pkg_prefix}/usr/share/libalpm/hooks/gdk-pixbuf-query-loaders.hook
}
