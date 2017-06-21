pkg_origin=cosmos

pkg_name=telepathy-salut
pkg_version=0.8.1
pkg_description="A link-local XMPP connection manager."
pkg_upstream_url="http://telepathy.freedesktop.org/"
pkg_license=('GPL')
pkg_deps=('telepathy-glib' 'avahi' 'libsoup' 'sqlite3')
pkg_build_deps=('libxslt' 'python2' 'xmldiff')
install=telepathy-salut.install
pkg_source=("http://telepathy.freedesktop.org/releases/$pkg_name/$pkg_name-$pkg_version.tar.gz")
pkg_shasum=('7516e6f6fa56a61054413a03642b938d')

do_build() {
    
    ./configure --prefix=/usr \
    	--libexecdir=/usr/lib/telepathy \
        --disable-plugins --disable-Werror \
        --with-tls=openssl \
        --enable-avahi-tests=no \
        --enable-static=no

    make
}

do_package() {
    
    make DESTDIR="${CACHE_PATH}" install
}

