pkg_origin=cosmos

pkg_name=libsecret
pkg_version=0.18.5
_pkg_version=0.18
pkg_description='Library for storing and retrieving passwords and other secrets.'
pkg_license=('LGPL')
pkg_upstream_url="https://wiki.gnome.org/Projects/Libsecret"
pkg_deps=('glib2' 'libgcrypt')
pkg_build_deps=('intltool' 'docbook-xsl' 'gobject-introspection' 'vala')
pkg_source=("https://download.gnome.org/sources/libsecret/$_pkg_version/$pkg_name-$pkg_version.tar.xz")
pkg_shasum=('2d688825921313da8731313b0a7f394c')

do_build() {
  
  ./configure --prefix=/usr \
      --sysconfdir=/etc \
      --localstatedir=/var \
      --disable-static
  make
}

do_package() {
  
  make DESTDIR="$pkg_prefix" install
}
