pkg_origin=cosmos

pkg_name=xf86-video-ati
pkg_version=7.9.0
pkg_description="X.org ati video driver"
pkg_upstream_url="http://xorg.freedesktop.org/"
pkg_license=('custom')
pkg_deps=('libpciaccess' 'libdrm' 'systemd' 'pixman' 'mesa')
pkg_build_deps=('xorg-server' 'xf86driproto' 'resourceproto' 'scrnsaverproto')
groups=('xorg-video-drivers')
pkg_source=("http://xorg.freedesktop.org/releases/individual/driver/${pkg_name}-${pkg_version}.tar.bz2")
pkg_shasum=('bf3dfdae23879bdc0c8a7b955572ad90')

do_build() { 
    
    ./configure \
            --prefix=/usr \
            --enable-maintainer-mode \
            --enable-dependency-tracking \
            --enable-glamor
    make
}

do_package() {
    make DESTDIR=${CACHE_PATH} install 
 
    msg "Copying license..."
    install -m755 -d "${CACHE_PATH}/usr/share/licenses/${pkg_name}"
    install -m644 COPYING "${CACHE_PATH}/usr/share/licenses/${pkg_name}/"
}
