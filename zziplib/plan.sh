pkg_origin=cosmos

pkg_name=zziplib
pkg_version=0.13.66
pkg_description="Library that provides read access on ZIP-archives and unpacked data."
pkg_upstream_url="https://github.com/gdraheim/zziplib"
pkg_license=('LGPL' 'MPL')
pkg_deps=('zlib')
pkg_build_deps=('python2')
pkg_source=("https://github.com/gdraheim/zziplib/archive/v${pkg_version}.tar.gz")
pkg_shasum=('0990b8e409834b62475b4de901fe3f6a')

do_build() {

    ./configure --prefix=/usr \
        --enable-maintainer-mode
    make
}

do_package() {
    make DESTDIR=${CACHE_PATH} install

    #fix permission
    #chmod -s ${CACHE_PATH}/usr/share/man/man3
    #chmod 644 ${CACHE_PATH}/usr/share/man/man3/*
    #chown -R root:root ${CACHE_PATH}/usr/share/man/man3
}
