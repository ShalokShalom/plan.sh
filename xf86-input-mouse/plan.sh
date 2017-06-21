pkg_origin=cosmos

pkg_name=xf86-input-mouse
pkg_version=1.9.2
pkg_description="X.org mouse input driver"
pkg_license=('custom')
pkg_upstream_url="http://xorg.freedesktop.org/"
pkg_deps=('glibc' 'resourceproto' 'scrnsaverproto')
pkg_build_deps=('xorg-server')
groups=('xorg-drivers' 'xorg')
pkg_source=("http://xorg.freedesktop.org/releases/individual/driver/${pkg_name}-${pkg_version}.tar.bz2")
pkg_shasum=('ce2d679283a22c8e0dccdd9248594845')

do_build() {
  
  ./configure --prefix=/usr
  make
}

do_package() {
  make DESTDIR=${CACHE_PATH} install
  
  install -d -m755 ${CACHE_PATH}/usr/share/licenses/${pkg_name}
  install -m644 COPYING ${CACHE_PATH}/usr/share/licenses/${pkg_name}/
}
