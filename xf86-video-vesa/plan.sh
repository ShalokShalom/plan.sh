pkg_origin=cosmos

pkg_name=xf86-video-vesa
pkg_version=2.3.4
pkg_description="X.org vesa video driver"
pkg_license=('custom')
pkg_upstream_url="http://xorg.freedesktop.org/"
pkg_deps=('glibc')
pkg_build_deps=('pkg-config' 'xorg-server>=1.19.1' 'resourceproto' 'scrnsaverproto')
groups=('xorg' 'xorg-video-drivers')
pkg_source=("http://xorg.freedesktop.org/releases/individual/driver/${pkg_name}-${pkg_version}.tar.bz2"
        'revert-kernelcheck.patch')
pkg_shasum=('a893c37c589f7a31cea929a5d896a0e2'
         '9a6a2c5fe01b96536f67495359c4bcf1')

do_build() {
  
  patch -p1 -R -i ${CACHE_PATH}/revert-kernelcheck.patch

  ./configure --prefix=/usr 
  make 
}

do_package() {

  make DESTDIR=${CACHE_PATH} install 
  install -d -m755 ${CACHE_PATH}/usr/share/licenses/${pkg_name}
  install -m644 COPYING ${CACHE_PATH}/usr/share/licenses/${pkg_name}/
}
