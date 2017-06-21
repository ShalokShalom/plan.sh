pkg_origin=cosmos

pkg_name=libmtp
pkg_version=1.1.13
pkg_description="Library implementation of the Media Transfer Protocol"
pkg_upstream_url="http://libmtp.sourceforge.net"
pkg_license=('LGPL')
pkg_deps=('libusb' 'libgcrypt')
pkg_source=("https://downloads.sourceforge.net/libmtp/${pkg_name}-${pkg_version}.tar.gz")
pkg_shasum=('6d557bf2671cf9db496b3b90a5f9622b')

do_build() {
  
  ./configure --prefix=/usr --with-udev=/usr/lib/udev
  make
}

do_package() {
  
  make DESTDIR=${pkg_prefix} install
  # systemd errors, clean line in udev rules
  sed -i "/^Unable to open/d" ${pkg_prefix}/usr/lib/udev/rules.d/69-libmtp.rules
}

