pkg_origin=cosmos

pkg_name=python2-gobject3 
pkgbase=pygobject
pkg_version=3.24.1
_pkg_version=3.24
pkg_description="Python2 bindings for GObject, including all introspection files"
pkg_upstream_url="https://live.gnome.org/PyGObject"
pkg_license=('LGPL')
pkg_deps=('python2' 'python2-cairo' 'gobject-introspection')
pkg_source=("https://ftp.gnome.org/pub/gnome/sources/${pkgbase}/${_pkg_version}/pygobject-${pkg_version}.tar.xz")
pkg_shasum=('69a843311d0f0385dff376e11a2d83d2')

do_build() {
    sed -i '/Werror=format/d' configure

    ./configure --prefix=/usr --with-python=/usr/bin/python2
    make
}

do_package() {

  make DESTDIR=${CACHE_PATH} install
}

