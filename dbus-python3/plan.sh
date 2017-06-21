pkg_origin=cosmos

pkg_name=dbus-python3
_pkg_name=dbus-python
pkg_version=1.2.4
pkg_description="Python3 bindings for DBUS"
pkg_license=('GPL' 'LGPL')
pkg_upstream_url="http://www.freedesktop.org/wiki/Software/DBusBindings"
pkg_deps=('dbus-glib' 'python3' 'dbus-python2')
pkg_build_deps=('pkg-config' 'python2-docutils')
pkg_source=("https://dbus.freedesktop.org/releases/${_pkg_name}/${_pkg_name}-${pkg_version}.tar.gz")
pkg_shasum=('7372a588c83a7232b4e08159bfd48fe5')

do_build() {
  #autoreconf -fi
  
  PYTHON=python3 ./configure --prefix=/usr
  make
}

do_package() {
  make DESTDIR=${pkg_prefix} install

  rm -rf ${pkg_prefix}/usr/share
  rm -rf ${pkg_prefix}/usr/include
  rm -rf ${pkg_prefix}/usr/lib/pkgconfig
}
