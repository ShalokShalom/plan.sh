pkg_origin=cosmos

pkg_name=xf86-input-keyboard
pkg_version=1.9.0
pkg_description="X.Org keyboard input driver"
pkg_license=('custom')
pkg_upstream_url="http://xorg.freedesktop.org/"
pkg_deps=('glibc')
pkg_build_deps=('xorg-server' 'resourceproto' 'scrnsaverproto')
groups=('xorg-input-drivers')
pkg_source=("http://xorg.freedesktop.org/releases/individual/driver/${pkg_name}-${pkg_version}.tar.bz2")
pkg_shasum=('a3a3f0dd32361dcdbd406e894dafe090')

do_build() {
  
  ./configure --prefix=/usr
  make
}

do_package() {
  make DESTDIR=${CACHE_PATH} install
  
  install -m755 -d ${CACHE_PATH}/usr/share/licenses/${pkg_name}
  install -m644 COPYING ${CACHE_PATH}/usr/share/licenses/${pkg_name}/
}
