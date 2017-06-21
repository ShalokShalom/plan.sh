pkg_origin=cosmos

pkg_name=ccid
pkg_version=1.4.27
_pkg_version=4218
pkg_description="Generic USB Chip/Smart Card Interface Devices driver"
pkg_upstream_url="https://pcsclite.alioth.debian.org/ccid.html"
pkg_license=('LGPL' 'GPL')
pkg_deps=('pcsclite' 'libusbx' 'flex')
pkg_build_deps=('pkg-config')
backup=(etc/reader.conf.d/libccidtwin)
pkg_source=("https://alioth.debian.org/frs/download.php/file/${_pkg_version}/${pkg_name}-${pkg_version}.tar.bz2")
pkg_shasum=('09f5a468902fcb6ea3bfb066fd097d84')

do_build() {

  ./configure --prefix=/usr \
    --sysconfdir=/etc \
    --enable-twinserial \
    --enable-serialconfdir=/etc/reader.conf.d
  make
}

do_package() {

  make DESTDIR=${pkg_prefix} install
  # move the configuration file in /etc and create a symbolic link
  mv ${pkg_prefix}/usr/lib/pcsc/drivers/ifd-ccid.bundle/Contents/Info.plist ${pkg_prefix}/etc/libccid_Info.plist
  ln -s /etc/libccid_Info.plist ${pkg_prefix}/usr/lib/pcsc/drivers/ifd-ccid.bundle/Contents/Info.plist
  
  install -D src/92_pcscd_ccid.rules ${pkg_prefix}/etc/udev/rules.d/92_pcscd_ccid.rules
}
