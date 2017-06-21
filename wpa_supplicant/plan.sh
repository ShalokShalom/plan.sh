pkg_origin=cosmos

pkg_name=wpa_supplicant
pkg_version=2.6
pkg_description="A utility providing key negotiation for WPA wireless networks"
pkg_deps=('openssl' 'dbus' 'readline' 'libnl')
pkg_license=('GPL')
backup=('etc/wpa_supplicant.conf')
pkg_upstream_url="http://hostap.epitest.fi/wpa_supplicant"
pkg_source=("http://hostap.epitest.fi/releases/wpa_supplicant-${pkg_version}.tar.gz"
        'config')
pkg_shasum=('091569eb4440b7d7f2b4276dbfc03c3c'
         '78bc0d6b6db02d4d58982d870e0a0c26')

do_build() {
  cd ${pkg_name}-${pkg_version}/
  #patch -p1 -i "${CACHE_PATH}"/openssl.patch
  
  cd ${pkg_name}/
  cp ${CACHE_PATH}/config ./.config
  sed -i 's@/usr/local@$(PREFIX)@g' Makefile
  
  make PREFIX=/usr
}

do_package() {
  cd ${pkg_name}-${pkg_version}/${pkg_name}
  make PREFIX=/usr DESTDIR=${pkg_prefix} install
  
  install -m755 -d ${pkg_prefix}/etc
  install -m644 wpa_supplicant.conf ${pkg_prefix}/etc/wpa_supplicant.conf
  install -d -m755 ${pkg_prefix}/usr/share/man/man{5,8}
  install -m644 doc/docbook/*.5 ${pkg_prefix}/usr/share/man/man5/
  install -m644 doc/docbook/*.8 ${pkg_prefix}/usr/share/man/man8/
  rm -f ${pkg_prefix}/usr/share/man/man8/wpa_{priv,gui}.8

  install -m755 -d ${pkg_prefix}/usr/share/dbus-1/system-services
  install -m644 dbus/{fi.epitest.hostap.WPASupplicant.service,fi.w1.wpa_supplicant1.service} ${pkg_prefix}/usr/share/dbus-1/system-services/

  install -m755 -d ${pkg_prefix}/etc/dbus-1/system.d
  install -m644 dbus/dbus-wpa_supplicant.conf ${pkg_prefix}/etc/dbus-1/system.d/wpa_supplicant.conf

  install -d -m755 ${pkg_prefix}/usr/lib/systemd/system
  install -m644 systemd/*.service ${pkg_prefix}/usr/lib/systemd/system/
}
