pkg_origin=cosmos

pkg_name=bluez
pkg_version=5.45
pkg_description="Libraries and tools for the Bluetooth protocol stack"
pkg_upstream_url="http://www.bluez.org/"
pkg_license=('GPL2')
pkg_deps=('libical' 'dbus' 'glib2' 'systemd')
pkg_build_deps=('libusb')
pkg_deps=("cups: CUPS backend")
backup=('etc/dbus-1/system.d/bluetooth.conf'
        'etc/bluetooth/main.conf')
install=bluez.install
pkg_source=("https://www.kernel.org/pub/linux/bluetooth/${pkg_name}-${pkg_version}.tar.xz"
        'bluetooth.modprobe')
pkg_shasum=('20d936917afc7e1ffa091f5213081c55'
         '671c15e99d7154c2df987b71c5851b3d')

do_build() {
  
  autoreconf -vfi
  ./configure --prefix=/usr \
    --mandir=/usr/share/man \
    --sysconfdir=/etc \
    --localstatedir=/var \
    --libexecdir=/usr/lib \
    --enable-sixaxis \
    --enable-library
  make
}

do_package() {
  make DESTDIR=${pkg_prefix} install
  
  install -dm755 ${pkg_prefix}/etc/bluetooth
  install -Dm644 src/main.conf ${pkg_prefix}/etc/bluetooth/main.conf

  install -dm755 ${pkg_prefix}/usr/share/doc/${pkg_name}/dbus-apis
  cp -a doc/*.txt ${pkg_prefix}/usr/share/doc/${pkg_name}/dbus-apis/

  install -dm755 ${pkg_prefix}/usr/lib/modprobe.d
  install -Dm644 ../bluetooth.modprobe ${pkg_prefix}/usr/lib/modprobe.d/bluetooth-usb.conf
}
