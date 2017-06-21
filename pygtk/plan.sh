pkg_origin=cosmos

pkg_name=pygtk
pkg_version=2.24.0
pkg_description="Python bindings for the GTK widget set"
pkg_license=('LGPL')
pkg_deps=('libglade' 'python2-cairo' 'python2-gobject' 'python2-numpy')
pkg_upstream_url="http://www.pygtk.org/"
pkg_source=("http://ftp.gnome.org/pub/gnome/sources/pygtk/2.24/${pkg_name}-${pkg_version}.tar.bz2"
        'python27.patch')
pkg_shasum=('a1051d5794fd7696d3c1af6422d17a49'
         '12acfacd26f19c504a0a2d0edeb66121')

do_build() {
  patch -p1 -i ${CACHE_PATH}/python27.patch
  
  ./configure --prefix=/usr
  make
}

do_package() {
  make DESTDIR=${CACHE_PATH} install
  
  install -m644 gtk/gtk-extrafuncs.defs ${CACHE_PATH}/usr/share/pygtk/2.0/defs/
}
