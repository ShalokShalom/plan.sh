pkg_origin=cosmos

pkg_name=dnsmasq
pkg_version=2.77
pkg_description="Network infrastructure for small networks: DNS, DHCP, router advertisement, network boot, tethering on smartphones and portable hotspots"
pkg_upstream_url="http://www.thekelleys.org.uk/dnsmasq/doc.html"
pkg_license=('GPL')
pkg_deps=('glibc' 'dbus' 'gmp' 'nettle')
install=dnsmasq.install
backup=('etc/dnsmasq.conf')
pkg_source=("http://www.thekelleys.org.uk/dnsmasq/${pkg_name}-${pkg_version}.tar.xz"
        'dnsmasq.service')
pkg_shasum=('5b973fea8e66e76a0e6bb44adefc6f9b'
         '596c88fc2492f99edf71e398b85a69f4')

do_build() {

  make \
    CFLAGS="$CPPFLAGS $CFLAGS" \
    LDFLAGS="$LDFLAGS" \
    COPTS="-DHAVE_DNSSEC -DHAVE_DBUS"
}

do_package() {

  make \
    COPTS="-DHAVE_DNSSEC -DHAVE_DBUS" \
    BINDIR=/usr/bin PREFIX=/usr DESTDIR=${pkg_prefix} install

  install -Dm644 dbus/dnsmasq.conf ${pkg_prefix}/etc/dbus-1/system.d/dnsmasq.conf
  install -Dm644 dnsmasq.conf.example ${pkg_prefix}/etc/dnsmasq.conf
  install -Dm644 ${CACHE_PATH}/dnsmasq.service ${pkg_prefix}/usr/lib/systemd/system/dnsmasq.service

  sed -i 's|%%PREFIX%%|/usr|' $pkg_prefix/etc/dnsmasq.conf
  install -Dm644 trust-anchors.conf $pkg_prefix/usr/share/dnsmasq/trust-anchors.conf
}

