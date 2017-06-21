pkg_origin=cosmos

pkg_name=networkmanager
_pkg_name=NetworkManager
pkg_version=1.8.0
_pkg_version=1.8
pkg_description="Network Management daemon"
pkg_license=('GPL')
pkg_upstream_url="https://wiki.gnome.org/Projects/NetworkManager"
pkg_deps=('dbus-glib' 'iproute2' 'libnl' 'nss' 'polkit' 'systemd' 'wpa_supplicant' 'ppp' 'dhcpcd'
         'modemmanager' 'libndp' 'libteam' 'libsoup') # 'libgudev' no longer needed for 1.8)
pkg_build_deps=('intltool' 'dhclient' 'iptables' 'gobject-introspection' 'netctl' 'python2-gobject3')
pkg_deps=('dhclient: alternative DHCP/DHCPv6 client'
            'iptables: Connection sharing'
            'dnsmasq: Connection sharing'
            'bluez: Bluetooth support'
            'openresolv: openresolv support')
backup=('etc/NetworkManager/NetworkManager.conf')
install=networkmanager.install
pkg_source=("https://download.gnome.org/sources/NetworkManager/${_pkg_version}/${_pkg_name}-${pkg_version}.tar.xz"
        'NetworkManager.conf'
        'nm_exported.patch')
pkg_shasum=('de0e70933a17ee6a682e8440015c9b1e'
         'e6549aab4cb721a87becd4585efd5148'
         '206971e92d6b592d80adcd19bf96f165')

do_build() {

  # https://forum.kaosx.us/d/1593-new-networkmanager-1-4-0-1-and-plasma-nm-icon
  #patch -p1 -i ${CACHE_PATH}/nm_exported.patch

  ./configure \
    --prefix=/usr \
    --sysconfdir=/etc \
    --localstatedir=/var \
    --libexecdir=/usr/lib/networkmanager \
    --with-crypto=nss \
    --with-dhclient=/usr/sbin/dhclient \
    --with-dhcpcd=/usr/sbin/dhcpcd \
    --with-pppd=/usr/sbin/pppd \
    --with-iptables=/usr/sbin/iptables \
    --with-dnsmasq=/usr/bin/dnsmasq \
    --with-systemdsystemunitdir=/usr/lib/systemd/system \
    --with-kernel-firmware-dir=/lib/firmware \
    --with-udev-dir=/usr/lib/udev \
    --with-resolvconf=/usr/sbin/resolvconf \
    --with-session-tracking=systemd \
    --with-modem-manager-1 \
    --disable-static \
    --enable-more-warnings=no \
    --enable-modify-system \
    --with-pppd-plugin-dir=/usr/lib/pppd/2.4.7

  make
}

do_package() {
  make DESTDIR=${pkg_prefix} install

  install -m644 ../NetworkManager.conf ${pkg_prefix}/etc/NetworkManager/
  install -m755 -d ${pkg_prefix}/etc/NetworkManager/dnsmasq.d

  #rm -r ${pkg_prefix}/var/run
}
