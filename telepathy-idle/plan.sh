pkg_origin=cosmos

pkg_name=telepathy-idle
pkg_version=0.2.0
pkg_description="IRC connection manager for Telepathy"
pkg_upstream_url="https://telepathy.freedesktop.org"
groups=('telepathy')
pkg_license=('LGPL')
pkg_deps=('telepathy-glib' 'openssl')
pkg_build_deps=('libxslt' 'python2')
install=telepathy-idle.install
pkg_source=("https://telepathy.freedesktop.org/releases/telepathy-idle/${pkg_name}-${pkg_version}.tar.gz")
pkg_shasum=('92a2de5198284cbd3c430b0d1a971a86')

do_build() {
    
    ./configure --prefix=/usr \
        --libexecdir=/usr/lib/telepathy
    make
}

do_package() {
    
    make DESTDIR=${CACHE_PATH} install
}
