pkg_origin=cosmos

pkg_name=libsignon-glib
pkg_version=1.14
pkg_description='Single signon authentication library for GLib applications'
pkg_upstream_url='https://gitlab.com/accounts-sso/libsignon-glib'
pkg_license=('LGPL2.1')
pkg_deps=('signonqt')
pkg_build_deps=('python2-gobject' 'gtk-doc')
# check https://groups.google.com/forum/#!forum/accounts-sso-announce
pkg_source=("https://gitlab.com/accounts-sso/libsignon-glib/repository/archive.tar.bz2?ref=VERSION_${pkg_version}")
pkg_shasum=('494936de3c57cd12c3115707be2ca20e')

do_build() {
  
  ./autogen.sh \
    --prefix=/usr \
    --localstatedir=/var \
    --sysconfdir=/etc \
    --disable-static 
  make -j1
}

do_package() {

  make DESTDIR=${pkg_prefix} install
}
