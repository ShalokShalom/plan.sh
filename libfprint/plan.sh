pkg_origin=cosmos

pkg_name=libfprint
pkg_version=0.6.0
pkg_description="Library for fingerprint readers"
pkg_upstream_url="http://www.freedesktop.org/wiki/Software/fprint/libfprint"
pkg_license=('LGPL')
pkg_deps=('libusb' 'nss' 'pixman')
pkg_source=("http://people.freedesktop.org/~hadess/${pkg_name}-${pkg_version}.tar.xz")
pkg_shasum=('1e66f6e786348b46075368cc682450a8')

do_build() {
  
  ./configure --prefix=/usr --sysconfdir=/etc --disable-static
  make
}

do_package() {
  
  make DESTDIR=${pkg_prefix} install
}
