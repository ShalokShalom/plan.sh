pkg_origin=cosmos

pkg_name=isl3890-firmware
pkg_version=2.13.25.0
pkg_description="Firmware for wireless card 3Com 3CRWE154G72"
pkg_upstream_url="http://wireless.kernel.org/en/users/Drivers/p54/devices"
pkg_license=('GPL')
pkg_source=("http://daemonizer.de/prism54/prism54-fw/fw-softmac/$pkg_version.arm")
pkg_shasum=('35a3974a67986be313b2d1640cde458e')

do_package() {
  mkdir -p $pkg_prefix/usr/lib/firmware/isl3890/
  
  install -m644 * $pkg_prefix/usr/lib/firmware/isl3890/isl3890
}
