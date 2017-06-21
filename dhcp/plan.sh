pkg_origin=cosmos

pkgbase=dhcp
pkg_name=('dhcp' 'dhclient')
pkg_version=4.3.5
_pkg_version=4.3.4
pkg_license=('custom:isc-dhcp')
pkg_upstream_url="https://www.isc.org/software/dhcp"
pkg_build_deps=('bash' 'iproute2')
pkg_source=("ftp://ftp.isc.org/isc/dhcp/${pkg_version}/${pkgbase}-${pkg_version}.tar.gz"
        'dhcpd4.service'
        'dhcpd6.service'
        "http://www.linuxfromscratch.org/patches/blfs/svn/dhcp-${_pkg_version}-client_script-1.patch"
        "http://www.linuxfromscratch.org/patches/blfs/svn/dhcp-${_pkg_version}-missing_ipv6-1.patch")
pkg_shasum=('2b5e5b2fa31c2e27e487039d86f83d3f'
         '7045e63a5d294c761ce306084eec2c67'
         'a2ebf4460c049cbee3e49cb26a475f68'
         'c02bddb6c6c33c5885e3dd072ee2ee40'
         'da655f02f1cf4d95b4708e84e69edbc8')

do_build() {

  # Define _GNU_SOURCE to fix IPV6.
  sed '/^CFLAGS="$CFLAGS/ s/INGS"/INGS -D_GNU_SOURCE"/' -i configure
  # use patches from LFS http://www.linuxfromscratch.org/blfs/view/cvs/basicnet/dhcp.html
  patch -p1 -i ${CACHE_PATH}/dhcp-${_pkg_version}-missing_ipv6-1.patch
  patch -p1 -i ${CACHE_PATH}/dhcp-${_pkg_version}-client_script-1.patch

  ./configure --prefix=/usr \
              --sysconfdir=/etc \
              --with-srv-lease-file=/var/state/dhcp/dhcpd.leases \
              --with-srv6-lease-file=/var/state/dhcp/dhcpd6.leases \
              --with-cli-lease-file=/var/state/dhclient/dhclient.leases \
              --with-cli6-lease-file=/var/state/dhclient/dhclient6.leases

  make -j1
}

package_dhcp() {
  pkg_description="A DHCP server, client, and relay agent"
  backup=('etc/dhcpd.conf')
  install=dhcp.install
  
  make DESTDIR=${pkg_prefix} install

  mkdir -p ${pkg_prefix}/var/state/dhcp

  # Install systemd service files
  install -D -m0644 ${CACHE_PATH}/dhcpd4.service ${pkg_prefix}/usr/lib/systemd/system/dhcpd4.service
  install -D -m0644 ${CACHE_PATH}/dhcpd6.service ${pkg_prefix}/usr/lib/systemd/system/dhcpd6.service
  ln -s dhcpd4.service ${pkg_prefix}/usr/lib/systemd/system/dhcp4.service
  ln -s dhcpd6.service ${pkg_prefix}/usr/lib/systemd/system/dhcp6.service
  
  # move back to config. This file is in backup array, so pacman will not overwrite a changed config.
  mv ${pkg_prefix}/etc/dhcpd.conf.example ${pkg_prefix}/etc/dhcpd.conf
  
  # Remove dhclient
  make -C client DESTDIR=${pkg_prefix} uninstall 

  install -Dm0644 LICENSE ${pkg_prefix}/usr/share/licenses/dhcp/LICENSE
}

package_dhclient() {
  _pkg_name=dhcp
  pkg_description="dhclient is standalone client from the dhcp package"
  pkg_deps=('bash' 'iproute2')
  
  make -C client DESTDIR=${pkg_prefix} install 

  install -m755 -d ${pkg_prefix}/usr/share/dhclient
  mv ${pkg_prefix}/etc/dhclient.conf.example ${pkg_prefix}/usr/share/dhclient/

  install -d ${pkg_prefix}/var/state/dhclient

  install -Dm0755 client/scripts/linux ${pkg_prefix}/sbin/dhclient-script
  install -Dm0644 LICENSE ${pkg_prefix}/usr/share/licenses/dhclient/LICENSE
}
