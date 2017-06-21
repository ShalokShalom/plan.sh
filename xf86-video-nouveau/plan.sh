pkg_origin=cosmos

pkg_name=xf86-video-nouveau
pkg_version=1.0.15
pkg_description="Open Source 3D acceleration driver for nVidia cards"
pkg_upstream_url="https://nouveau.freedesktop.org/"
pkg_license=('GPL') #and MIT, not yet a license file, see http://nouveau.freedesktop.org/wiki/FAQ#head-09f75d03eb30011c754038a3893119a70745de4e
pkg_deps=('libdrm' 'systemd' 'mesa')
pkg_build_deps=('xorg-server' 'xf86driproto' 'resourceproto' 'scrnsaverproto')
install=${pkg_name}.install
pkg_source=("https://xorg.freedesktop.org/archive/individual/driver/$pkg_name-$pkg_version.tar.bz2"
        '50-nouveau-hwmon.rules')
pkg_shasum=('717203cb87029cddcbccf7398f9ad8c3'
         'bc25444cb8b0cffbafcad45d53d42c17')

do_build() {
  
  ./configure --prefix=/usr
  make
}

do_package() {
  make DESTDIR=${CACHE_PATH} install
  
  install -Dm644 ${CACHE_PATH}/50-nouveau-hwmon.rules ${CACHE_PATH}/etc/udev/rules.d/50-nouveau-hwmon.rules
}
