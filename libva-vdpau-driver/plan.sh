pkg_origin=cosmos

pkg_name=libva-vdpau-driver
pkg_version=0.7.4
pkg_description="VDPAU backend for VA API"
pkg_upstream_url="http://freedesktop.org/wiki/Software/vaapi"
pkg_license=('GPL')
pkg_deps=('libva' 'libvdpau')
pkg_build_deps=('mesa')
pkg_source=("http://www.freedesktop.org/software/vaapi/releases/$pkg_name/$pkg_name-$pkg_version.tar.bz2"
        'utils_glx.diff'
        'libvdpau.patch'
        'vdpau_dump.patch')
pkg_shasum=('5ec6d452d2dd307434ea3d32da49c3e5'
         '9ecb758ac8e758946400cc3bb7e94a2b'
         '1832517ead98e0e27268fc78594e18ce'
         '4783c9fb3b1514d7a0903d137fa55428')

do_build() {
  patch -p1 -i ${CACHE_PATH}/utils_glx.diff
  patch -p1 -i ${CACHE_PATH}/libvdpau.patch
  patch -p1 -i ${CACHE_PATH}/vdpau_dump.patch
  
  ./configure --prefix=/usr 
  make
}

do_package() {
  
  make DESTDIR="${pkg_prefix}" install
}



