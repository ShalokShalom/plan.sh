pkg_origin=cosmos

pkg_name=libusbmuxd
pkg_version=1.0.10
pkg_description="USB Multiplex Daemon, libraries"
pkg_upstream_url="http://marcansoft.com/blog/iphonelinux/usbmuxd/"
pkg_license=('LGPL2.1' 'GPL2')
pkg_deps=('libusb' 'libplist')
pkg_source=("http://www.libimobiledevice.org/downloads/${pkg_name}-$pkg_version.tar.bz2")
pkg_shasum=('e5351ff6f6eedcb50701e02d91cc480c')

do_build() {

  ./configure --prefix=/usr
  make
}

do_package() {

  make DESTDIR=${pkg_prefix} install
}

