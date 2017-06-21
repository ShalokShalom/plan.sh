pkg_origin=cosmos

pkg_name=dbus-glib
pkg_version=0.108
pkg_description="GLib bindings for DBUS"
pkg_license=('GPL')
pkg_upstream_url="http://www.freedesktop.org/wiki/Software/DBusBindings"
pkg_deps=('dbus' 'glib2')
pkg_build_deps=('pkgconfig')
pkg_source=("http://dbus.freedesktop.org/releases/dbus-glib/${pkg_name}-${pkg_version}.tar.gz")
pkg_shasum=('a66a613705870752ca9786e0359aea97')

do_build() {

  ./configure --prefix=/usr \
              --sysconfdir=/etc \
              --localstatedir=/var \
              --enable-static=no \
              --enable-bash-completion=no
  make
}

do_package() {
  
  make DESTDIR=${pkg_prefix} install
}

