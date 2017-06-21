pkg_origin=cosmos

pkg_name=xf86-input-evdev
pkg_version=2.10.5
pkg_description="X.org evdev input driver"
pkg_upstream_url="https://xorg.freedesktop.org/"
pkg_license=('custom')
pkg_deps=('glibc' 'systemd' 'mtdev' 'xf86driproto' 'libevdev')
pkg_build_deps=('xorg-server>=1.19.1' 'resourceproto' 'scrnsaverproto')
groups=('xorg-drivers' 'xorg')
pkg_source=("https://xorg.freedesktop.org/releases/individual/driver/${pkg_name}-${pkg_version}.tar.bz2")
pkg_shasum=('94c2c8354c74ab1cfbbb0a222078b9c6')

do_build() {
  
  ./configure --prefix=/usr
  make
}

do_package() {
  make DESTDIR=${CACHE_PATH} install
  
  install -m755 -d ${CACHE_PATH}/usr/share/licenses/${pkg_name}
  install -m644 COPYING ${CACHE_PATH}/usr/share/licenses/${pkg_name}/
}
