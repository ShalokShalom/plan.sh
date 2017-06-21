pkg_origin=cosmos

pkg_name=modemmanager
_pkg_name=ModemManager
pkg_version=1.6.8
pkg_description="Mobile broadband modem management service"
pkg_upstream_url="https://www.freedesktop.org/wiki/Software/ModemManager/"
pkg_license=('GPL2' 'LGPL2.1')
pkg_deps=('dbus-glib' 'systemd' 'libgudev' 'ppp' 'polkit' 'hicolor-icon-theme' 'libqmi' 'libmbim')
pkg_build_deps=('intltool' 'python3')
pkg_deps=('usb_modeswitch: install if your modem shows up as a storage drive')
install=modemmanager.install
pkg_source=("https://www.freedesktop.org/software/ModemManager/${_pkg_name}-${pkg_version}.tar.xz")
pkg_shasum=('ac08d539ec3dc35db8d6b7c8d6c660ff')

do_build() {
  
   ./configure --prefix=/usr \
   	--sysconfdir=/etc \
	--localstatedir=/var \
	--with-udev-base-dir=/usr/lib/udev \
	--disable-static \
	--disable-gtk-doc \
	--with-polkit=strict \
	--with-suspend-resume=systemd
  make
}

do_package() {
  
  make DESTDIR=${pkg_prefix} install
}
