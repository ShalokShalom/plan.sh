pkg_origin=cosmos

pkg_name=dri3proto
pkg_version=1.0
pkg_description="Direct Rendering Infrastructure 3 Extension, provides mechanisms to translate between direct
         rendered buffers and X pixmaps"
pkg_upstream_url="http://xorg.freedesktop.org/"
pkg_license=('custom')
pkg_source=("http://xorg.freedesktop.org/releases/individual/proto/${pkg_name}-${pkg_version}.tar.bz2"
        'COPYING')
pkg_shasum=('a3d2cbe60a9ca1bf3aea6c93c817fee3'
         'ac90d1d416be3cb13e1d3c88cd5166bf')

do_build() {
	
    ./configure --prefix=/usr
    make
}

do_package() {
    make DESTDIR="$pkg_prefix/" install
	
    install -m755 -d "${pkg_prefix}/usr/share/licenses/${pkg_name}"
    install -m644 ${CACHE_PATH}/COPYING "${pkg_prefix}/usr/share/licenses/${pkg_name}/"
}
