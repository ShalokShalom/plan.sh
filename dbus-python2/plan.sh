pkg_origin=cosmos

pkg_name=dbus-python2
_pkg_name=dbus-python
pkg_version=1.2.4
pkg_description="Python bindings for DBUS"
pkg_license=('GPL' 'LGPL')
pkg_upstream_url="https://www.freedesktop.org/wiki/Software/DBusBindings"
pkg_deps=('dbus-glib' 'python2')
pkg_build_deps=('pkg-config' 'python2-docutils')
pkg_source=("https://dbus.freedesktop.org/releases/dbus-python/${_pkg_name}-${pkg_version}.tar.gz")
pkg_shasum=('7372a588c83a7232b4e08159bfd48fe5')

do_build() {
  
  ./configure --prefix=/usr
  make
}

do_package() {
  
  make DESTDIR=${pkg_prefix} install
}
