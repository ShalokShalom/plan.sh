pkg_origin=cosmos

pkg_name=gobject-introspection
pkg_version=1.52.1
_pkg_version=1.52
pkg_description="Introspection system for GObject-based libraries"
pkg_upstream_url="https://live.gnome.org/GObjectInstrospection"
pkg_license=('LGPL' 'GPL')
pkg_deps=('libffi' 'glib2' 'python3')
pkg_build_deps=('cairo')
pkg_source=("https://ftp.gnome.org/pub/gnome/sources/${pkg_name}/${_pkg_version}/${pkg_name}-${pkg_version}.tar.xz")
pkg_shasum=('34157073991f9eeb0ed953351b65eb61')


do_build() {
  cd ${pkg_name}-${pkg_version}
  
  PYTHON=/usr/bin/python3 ./configure --prefix=/usr --disable-static
  make
}

do_package() {
  cd ${pkg_name}-${pkg_version}
  
  make DESTDIR=${pkg_prefix} install
  
    sed -i '1s|#!/usr/bin/env python$|&3|' ${pkg_prefix}/usr/lib/gobject-introspection/giscanner/*.py
}

