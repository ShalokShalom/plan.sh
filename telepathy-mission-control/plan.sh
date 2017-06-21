pkg_origin=cosmos

pkg_name=telepathy-mission-control
pkg_version=5.16.4
pkg_description="Telepathy component implementing both the Account Manager and Channel Dispatcher specifications."
pkg_upstream_url="https://telepathy.freedesktop.org/wiki/Components/Mission_Control/"
pkg_license=('LGPL2.1')
pkg_deps=('telepathy-glib' 'networkmanager')
pkg_build_deps=('libxslt' 'python2')
groups=('telepathy')
pkg_source=("http://telepathy.freedesktop.org/releases/telepathy-mission-control/${pkg_name}-${pkg_version}.tar.gz")
pkg_shasum=('eab6c941038702edeece1168f395300c')

do_build() {
    
    ./configure --prefix=/usr \
        --libexecdir=/usr/lib/telepathy \
        --disable-schemas-compile \
        --with-connectivity=nm
    make
}

do_package() {
    
    make DESTDIR=${CACHE_PATH} install
}
