pkg_origin=cosmos

pkg_name=bluez-firmware
pkg_version=1.2
pkg_description="Firmware for Broadcom BCM203x and STLC2300 Bluetooth chips"
pkg_upstream_url="http://www.bluez.org/"
pkg_license=('GPL2')
pkg_source=("http://bluez.sf.net/download/${pkg_name}-${pkg_version}.tar.gz")
pkg_shasum=('1cc3cefad872e937e05de5a0a2b390dd')

do_build() {

  ./configure --prefix=/usr
}

do_package() {
  
  make DESTDIR=${pkg_prefix} install
}
