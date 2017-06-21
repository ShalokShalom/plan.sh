pkg_origin=cosmos

pkg_name=xorg-font-util
pkg_version=1.3.1
pkg_description='X.Org font utilities'
pkg_upstream_url='https://xorg.freedesktop.org/'
pkg_license=('custom')
pkg_build_deps=('xorg-util-macros')
groups=('xorg-fonts' 'xorg')
pkg_source=("https://xorg.freedesktop.org/releases/individual/font/font-util-${pkg_version}.tar.bz2")
pkg_shasum=('23756dab809f9ec5011bb27fb2c3c7d6')

do_build() {

    ./configure \
        --prefix=/usr \
        --mandir=/usr/share/man \
        --with-mapdir=/usr/share/fonts/util \
        --with-fontrootdir=/usr/share/fonts \

    make
}

do_package() {
    make DESTDIR=${CACHE_PATH} install
    
    install -Dm644 COPYING ${CACHE_PATH}/usr/share/licenses/${pkg_name}/COPYING
}
