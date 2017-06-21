pkg_origin=cosmos

pkg_name=libgnome-keyring
pkg_version=3.12.0
_pkg_version=3.12
pkg_description="GNOME keyring client library"
pkg_license=('GPL' 'LGPL')
pkg_deps=('dbus' 'libgcrypt' 'glib2')
pkg_build_deps=('intltool' 'gobject-introspection' 'python2')
pkg_upstream_url="http://www.gnome.org"
pkg_source=("https://ftp.gnome.org/pub/gnome/sources/${pkg_name}/${_pkg_version}/${pkg_name}-${pkg_version}.tar.xz")
pkg_shasum=('6696e4f2e9aed4625cdc3af30bd8c238')

do_build() {
  
  ./configure --prefix=/usr \
    --sysconfdir=/etc \
    --localstatedir=/var \
    --disable-static \
    --libexecdir=/usr/lib/gnome-keyring
  make
}

do_package() {
  
  make DESTDIR=${pkg_prefix} install
}
