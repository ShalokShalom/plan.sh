pkg_origin=cosmos

pkg_name=xf86-video-amdgpu
pkg_version=1.3.0
pkg_description="Video driver forked from the xf86-video-ati radeon driver and modified to support the amdgpu kernel driver via libdrm_amdgpu"
pkg_upstream_url="http://xorg.freedesktop.org/"
pkg_license=('custom')
pkg_deps=('libdrm' 'systemd' 'mesa') 
pkg_build_deps=('xorg-server' 'xf86driproto' 'resourceproto' 'scrnsaverproto')
#groups=('xorg-video-drivers')
pkg_source=("http://xorg.freedesktop.org/releases/individual/driver/${pkg_name}-${pkg_version}.tar.bz2")
pkg_shasum=('e2ee9e16ffbd45ebda68a7ff638a04f2')

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
 
    install -m755 -d ${CACHE_PATH}/usr/share/licenses/${pkg_name}
    install -m644 COPYING ${CACHE_PATH}/usr/share/licenses/${pkg_name}/
}
