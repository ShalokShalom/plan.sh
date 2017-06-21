pkg_origin=cosmos

pkg_name=telepathy-glib
pkg_version=0.24.1
pkg_description="GLib bindings for the Telepathy D-Bus protocol"
pkg_upstream_url="http://telepathy.freedesktop.org"
groups=('telepathy')
pkg_license=('LGPL2.1')
pkg_deps=('dbus-glib')
pkg_build_deps=('libxslt' 'vala' 'gobject-introspection')
pkg_source=("http://telepathy.freedesktop.org/releases/${pkg_name}/${pkg_name}-${pkg_version}.tar.gz")
pkg_shasum=('cbeb0a24acc26e7f095be281c324da69')

do_build() {

    ./configure --prefix=/usr \
        --libexecdir=/usr/lib/telepathy \
        --enable-static=no
    make
}

do_package() {
    
    make DESTDIR=${CACHE_PATH} install
}
