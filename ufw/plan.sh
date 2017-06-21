pkg_origin=cosmos

pkg_name=ufw
pkg_version=0.35
pkg_description="Uncomplicated and easy to use CLI tool for managing a netfilter firewall"
pkg_upstream_url="https://launchpad.net/ufw"
pkg_license=('GPL3')
pkg_deps=('iptables' 'python3')
backup=('etc/ufw/before.rules'
        'etc/ufw/before6.rules'
        'etc/ufw/after.rules'
        'etc/ufw/after6.rules'
        'etc/ufw/ufw.conf'
        'etc/ufw/user.rules'
        'etc/ufw/sysctl.conf'
        'etc/default/ufw'
        'usr/lib/ufw/user.rules'
        'usr/lib/ufw/user6.rules')
categories=('network')
pkg_source=("http://launchpad.net/ufw/${pkg_version}/${pkg_version}/+download/${pkg_name}-${pkg_version}.tar.gz"
        "${pkg_name}.service")
pkg_shasum=('b7cd2dd4e4e98e46df125fee06edff92'
         '2c85da635f53c6817be8c1941a9a35fb')

do_package() {

  sed -e 's|/lib|/usr/lib|' -i setup.py
  python3 setup.py install --root=${CACHE_PATH}

  install -D -m644 ${CACHE_PATH}/${pkg_name}.service ${CACHE_PATH}/usr/lib/systemd/system/${pkg_name}.service
  install -D -m755 ${CACHE_PATH}/usr/sbin/${pkg_name} ${CACHE_PATH}/usr/bin/${pkg_name}
  rm -rf ${CACHE_PATH}/usr/sbin

  # Fix permissions
  chmod 644 ${CACHE_PATH}/etc/ufw/*.rules # moved to /etc/ufw with 0.35 "${CACHE_PATH}/usr/lib/ufw"/*.rules

  # no absolute paths
  sed -e 's|/bin/echo|echo|g' -i ${CACHE_PATH}/usr/lib/ufw/ufw-init-functions

  # Enable by default
  sed -e 's|ENABLED=no|ENABLED=yes|' -i ${CACHE_PATH}/etc/ufw/ufw.conf
}
