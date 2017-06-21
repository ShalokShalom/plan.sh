pkg_origin=cosmos

pkg_name=libsoup
pkg_version=2.58.1
_pkg_version=2.58
pkg_description="GNOME HTTP Library - base library"
pkg_upstream_url="https://www.gnome.org"
pkg_license=('LGPL')
pkg_deps=('glib2' 'libxml2' 'gnutls' 'sqlite3' 'glib-networking')
pkg_build_deps=('intltool' 'gobject-introspection' 'vala')
pkg_source=("https://ftp.gnome.org/pub/gnome/sources/libsoup/${_pkg_version}/${pkg_name}-${pkg_version}.tar.xz")
pkg_shasum=('91d7a6bf8785d31f4b154a7612e53e62')

do_build() {
  
  ./configure --prefix=/usr \
      --sysconfdir=/etc \
      --localstatedir=/var \
      --disable-static \
      --disable-tls-check \
      --without-gnome 
  make 
}

do_package() {
  
  make DESTDIR=${pkg_prefix} install 
}
