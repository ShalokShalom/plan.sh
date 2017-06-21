pkg_origin=cosmos

pkg_name=libaccounts-glib
pkg_version=1.23
#_pkg_version=VERSION_1.21-00254a604a7c7bd38c41794a80ad8930e90f21aa
pkg_description="Glib-based client library for accessing the online accounts database"
pkg_upstream_url="https://gitlab.com/groups/accounts-sso"
pkg_license=('LGPL')
pkg_deps=('dbus-glib' 'libxml2' 'sqlite')
pkg_build_deps=('python2-gobject' 'docbook-xsl' 'gtk-doc')
# check https://groups.google.com/forum/#!forum/accounts-sso-announce
pkg_source=("https://gitlab.com/accounts-sso/libaccounts-glib/repository/archive.tar.bz2?ref=VERSION_${pkg_version}")
pkg_shasum=('f71c0393fb7cd6397b145fe4ad0ebba9')

do_build() {
  
  ./autogen.sh
  ./configure \
    --prefix=/usr \
    --disable-static \
    --enable-gcov=no \
    --disable-gtk-doc
  make
}

do_package() {
  
  make DESTDIR=${pkg_prefix} install
}
