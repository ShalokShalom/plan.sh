pkg_origin=cosmos

pkg_name=pcsclite
pkg_version=1.8.21
_pkg_version=4216
pkg_description="PC/SC Architecture smartcard middleware library"
pkg_upstream_url="https://alioth.debian.org/projects/pcsclite/"
pkg_license=('BSD')
pkg_deps=('python2' 'systemd')
pkg_build_deps=('pkg-config')
pkg_source=("https://alioth.debian.org/frs/download.php/file/${_pkg_version}/pcsc-lite-${pkg_version}.tar.bz2")
pkg_shasum=('49f01c15eeec6ceb9f4edaa0a3f8741d')

do_build() {

  ./configure --prefix=/usr \
              --enable-libudev \
              --sysconfdir=/etc \
              --enable-ipcdir=/run/pcscd \
              --enable-usbdropdir=/usr/lib/pcsc/drivers \
              --with-systemdsystemunitdir=/usr/lib/systemd/system

  make
}

do_package() {

  make DESTDIR=${pkg_prefix} install

  install -D -m644 ${CACHE_PATH}/pcsc-lite-${pkg_version}/COPYING ${pkg_prefix}/usr/share/licenses/${pkg_name}/LICENSE
  install -d ${pkg_prefix}/usr/lib/pcsc/drivers
}
