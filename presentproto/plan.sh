pkg_origin=cosmos

pkg_name=presentproto
pkg_version=1.1
pkg_description="X11 Present protocol specification"
pkg_upstream_url="http://xorg.freedesktop.org/"
pkg_license=('custom')
pkg_source=("http://xorg.freedesktop.org/releases/individual/proto/${pkg_name}-${pkg_version}.tar.bz2"
        'COPYING')
pkg_shasum=('92f9dda9c870d78a1d93f366bcb0e6cd'
         'ac90d1d416be3cb13e1d3c88cd5166bf')

do_build() {
	
    ./configure --prefix=/usr
    make
}

do_package() {
    make DESTDIR=${pkg_prefix}/ install
	
    install -m755 -d ${pkg_prefix}/usr/share/licenses/${pkg_name}
    install -m644 ../COPYING ${pkg_prefix}/usr/share/licenses/${pkg_name}/
}
