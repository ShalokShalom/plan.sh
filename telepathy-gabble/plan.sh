pkg_origin=cosmos

pkg_name=telepathy-gabble
pkg_version=0.18.4
pkg_description="A Jabber/XMPP connection manager that handles single- and multi-user chats and voice/video calls."
pkg_upstream_url="http://telepathy.freedesktop.org/"
pkg_license=('GPL')
pkg_deps=('telepathy-glib' 'libsoup' 'libnice' 'util-linux' 'sqlite')
pkg_build_deps=('libxslt' 'python2')
groups=('telepathy')
install=telepathy-gabble.install
pkg_source=("http://telepathy.freedesktop.org/releases/${pkg_name}/${pkg_name}-${pkg_version}.tar.gz")
pkg_shasum=('64334f42b1822dbc22b823f22f9e968f')

do_build() {
  
  ./configure --prefix=/usr \
    --libexecdir=/usr/lib/telepathy \
    --with-tls=openssl
  make
}

do_package() {
  
  make DESTDIR=${CACHE_PATH} install
}

