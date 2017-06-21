pkg_origin=cosmos

pkg_name=telepathy-farstream
pkg_version=0.6.2
pkg_description="C library that uses Telepathy GLib, Farstream and GStreamer to handle the media streaming part of channels of type Call"
pkg_upstream_url="https://telepathy.freedesktop.org"
pkg_license=('LGPL2.1')
pkg_deps=('telepathy-glib' 'farstream')
pkg_build_deps=('gobject-introspection' 'dbus-glib')
groups=('telepathy')
pkg_source=("http://telepathy.freedesktop.org/releases/${pkg_name}/${pkg_name}-${pkg_version}.tar.gz")
pkg_shasum=('20bdc61ea3f3a01df41068006b62641b')

do_build() {

  ./configure --prefix=/usr \
    --sysconfdir=/etc \
    --libexecdir=/usr/lib/telepathy \
    --disable-static
  make
}

do_package() {
  
  make DESTDIR=${CACHE_PATH} install
}

