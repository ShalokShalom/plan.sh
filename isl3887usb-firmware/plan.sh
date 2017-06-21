pkg_origin=cosmos

pkg_name=isl3887usb-firmware
pkg_version=2.13.25.0
pkg_description="Firmware for wireless cards using isl3887usb"
pkg_upstream_url="http://wireless.kernel.org/en/users/Drivers/p54/devices"
pkg_license=('GPL')
# ca-cert no longer available, get source with
# wget https://daemonizer.de/prism54/prism54-fw/fw-usb/2.13.25.0.lm87.arm --no-check-certificate
pkg_source=("http://daemonizer.de/prism54/prism54-fw/fw-usb/$pkg_version.lm87.arm")
pkg_shasum=('39be687c87544b892e7a8ffe7ffd9371')

do_package() {
  mkdir -p $pkg_prefix/usr/lib/firmware
  
  install -m644 * $pkg_prefix/usr/lib/firmware/isl3887usb
}
