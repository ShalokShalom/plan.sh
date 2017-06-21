pkg_origin=cosmos

pkg_name=python2-gobject
_pkg_name=pygobject
pkg_version=2.28.6
pkg_description="Python bindings for GObject"
pkg_upstream_url="http://www.pygtk.org/"
pkg_license=('LGPL')
pkg_deps=('python2' 'glib2' 'python2-cairo' 'gobject-introspection')
pkg_source=("https://ftp.gnome.org/pub/gnome/sources/pygobject/2.28/${_pkg_name}-${pkg_version}.tar.bz2"
        'python2-fix-type.patch')
pkg_shasum=('a43d783228dd32899e6908352b8308f3'
         'b33aa47c5361af04fb8a26b9e5a15f6f')

do_build() {
  patch -p1 -i ${CACHE_PATH}/python2-fix-type.patch
  
  export PYTHON=/usr/bin/python2
  ./configure --disable-introspection --prefix=/usr 
  make
}

do_package() {
  
  make DESTDIR=${CACHE_PATH} install
}
