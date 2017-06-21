pkg_origin=cosmos

pkg_name=sbc
pkg_version=1.3
pkg_description="Bluetooth Subband Codec (SBC) library"
pkg_upstream_url="http://www.bluez.org/"
pkg_license=('GPL' 'LGPL')
pkg_deps=('glibc')
pkg_source=("http://www.kernel.org/pub/linux/bluetooth/${pkg_name}-${pkg_version}.tar.xz")
pkg_shasum=('2d8b7841f2c11ab287718d562f2b981c')

do_build() {

  ./configure --prefix=/usr \
       --disable-static \
       --disable-tester
  make
}

do_package() {

  make DESTDIR=${CACHE_PATH} install
}
