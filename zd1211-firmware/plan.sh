pkg_origin=cosmos

pkg_name=zd1211-firmware
pkg_version=1.5
pkg_description="Firmware for the in-kernel26 zd1211rw wireless driver"
pkg_upstream_url="http://zd1211.wiki.sourceforge.net/"
pkg_license=('GPL')
pkg_source=("http://downloads.sourceforge.net/zd1211/${pkg_name}-${pkg_version}.tar.bz2")
pkg_shasum=('3c182ceb9b2fc1d8442cd81c1280d83f')

do_package() {
  cd ${pkg_name}
  # Install firmware
  for i in zd1211* WS11U*
  do                
    install -D -m 644 $i "${pkg_prefix}/usr/lib/firmware/zd1211/$i"
  done
}
