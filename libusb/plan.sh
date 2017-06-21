pkg_origin=cosmos

pkg_name=libusb
pkg_version=1.0.21
pkg_description="Library that provides generic access to USB device"
pkg_upstream_url="http://libusb.info"
pkg_license=('LGPL')
pkg_deps=('glibc' 'systemd')
pkg_source=("https://github.com/libusb/libusb/releases/download/v${pkg_version}/${pkg_name}-${pkg_version}.tar.bz2")
pkg_shasum=('1da9ea3c27b3858fa85c5f4466003e44')

do_build() {
  cd ${pkg_name}-${pkg_version}
  
  ./configure --prefix=/usr --disable-static
  make -j1
}

do_check() {
  cd ${pkg_name}-${pkg_version}
  
  make check
}

package () {
  cd ${pkg_name}-${pkg_version}
  
  make DESTDIR=${pkg_prefix} install
}
