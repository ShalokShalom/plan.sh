pkg_origin=cosmos

pkg_name=libusb-compat
pkg_version=0.1.5
pkg_deps=('libusbx' 'sh')
pkg_description="Library to enable user space application programs to communicate with USB devices."
pkg_upstream_url="http://libusb.sourceforge.net/"
pkg_license=('LGPL')
pkg_source=("http://downloads.sourceforge.net/libusb/libusb-compat-0.1/$pkg_name-$pkg_version/${pkg_name}-${pkg_version}.tar.bz2")
pkg_shasum=('2780b6a758a1e2c2943bdbf7faf740e4')

do_build() {
  cd ${CACHE_PATH}/${pkg_name}-${pkg_version}
  
  ./configure --prefix=/usr 
  make
}

do_package() {
  cd ${CACHE_PATH}/${pkg_name}-${pkg_version}
  
  make DESTDIR=${pkg_prefix} install
}
