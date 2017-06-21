pkg_origin=cosmos

pkg_name=python3-gobject3 
pkgbase=pygobject
pkg_version=3.24.1
_pkg_version=3.24
pkg_description="Python3 bindings for GObject"
pkg_upstream_url="https://live.gnome.org/PyGObject"
pkg_license=('LGPL')
pkg_deps=('python3' 'python3-cairo' 'gobject-introspection' 'python2-gobject3')
pkg_source=("http://ftp.gnome.org/pub/gnome/sources/pygobject/${_pkg_version}/${pkgbase}-${pkg_version}.tar.xz")
pkg_shasum=('69a843311d0f0385dff376e11a2d83d2')

do_build() {
    sed -i '/Werror=format/d' configure 

    ./configure --prefix=/usr --with-python=/usr/bin/python3
    make
}

do_package() {
  make DESTDIR=${CACHE_PATH} install
  
  rm -r ${CACHE_PATH}/usr/{include,lib/pkgconfig}
}

