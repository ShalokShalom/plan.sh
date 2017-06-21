pkg_origin=cosmos

pkg_name=net-snmp
pkg_version=5.7.3
pkg_description="A suite of applications used to implement SNMP v1, SNMP v2c and SNMP v3 using both IPv4 and IPv6"
pkg_upstream_url="http://www.net-snmp.org/"
pkg_license=('BSD')
pkg_deps=('openssl' 'libnl' 'pciutils')
pkg_build_deps=('python2-setuptools')
pkg_source=("http://downloads.sourceforge.net/sourceforge/net-snmp/${pkg_name}-${pkg_version}.tar.gz"
        'snmpd.service'
        'perl24.patch')
pkg_shasum=('d4a3459e1577d0efa8d96ca70a885e53'
         '7afa48020f37e4de2b3b8cdf4d7b0e42'
         'dfeb6ee150ffa7b192beb38da85bed0b')

do_build() {
  patch -p1 -i $CACHE_PATH/perl24.patch
  
  autoreconf -f -i  

  ./configure --prefix=/usr \
    --sysconfdir=/etc \
    --mandir=/usr/share/man \
    --enable-ucd-snmp-compatibility \
    --enable-ipv6 \
    --with-python-modules \
    --with-default-snmp-version="3" \
    --with-sys-contact="root@localhost" \
    --with-sys-location="Unknown" \
    --with-logfile="/var/log/snmpd.log" \
    --with-mib-modules="host misc/ipfwacc ucd-snmp/diskio tunnel ucd-snmp/dlmod" \
    --with-persistent-directory="/var/net-snmp" \
    --disable-static
  make NETSNMP_DONT_CHECK_VERSION=1
}

do_package() {
  sed -i -e "s|install --basedir=\$\$dir|install --basedir=\$\$dir --root=${pkg_prefix}|" Makefile
  make DESTDIR=${pkg_prefix} INSTALL_PREFIX=${pkg_prefix} INSTALLDIRS=vendor install
  
  install -Dm0644 ${CACHE_PATH}/snmpd.service ${pkg_prefix}/usr/lib/systemd/system/snmpd.service
  install -Dm0644 COPYING ${pkg_prefix}/usr/share/licenses/${pkg_name}/LICENSE
}
