pkg_origin=cosmos

pkg_name=dhcpcd
pkg_version=6.11.5
pkg_description="RFC2131 compliant DHCP client daemon"
pkg_upstream_url="http://roy.marples.name/projects/dhcpcd/"
pkg_license=('BSD')
pkg_deps=('glibc' 'sh')
pkg_build_deps=('ntp')
backup=('etc/dhcpcd.conf')
pkg_source=("http://roy.marples.name/downloads/dhcpcd/$pkg_name-$pkg_version.tar.xz" 
        'dhcpcd@.service'
        'dhcpcd.service')
pkg_shasum=('2465624b62c1154f0e89dc69c42c849b'
         '3b47ff473ee7f7b03062818b94fd3ed5'
         'c10ec3816b13fd5d59f696f7154f445a')

do_build() {
  cd ${pkg_name}-${pkg_version}
  sed -i -e 's|#include "queue.h"|#include "compat/queue.h"|' eloop.c

  ./configure --libexecdir=/usr/lib/dhcpcd \
       --dbdir=/var/lib/dhcpcd \
       --rundir=/run \
       --without-dev
  make
}

do_package() {
  cd ${pkg_name}-${pkg_version}
  make DESTDIR=${pkg_prefix} install

  # Create Binary Symlink
  install -d ${pkg_prefix}/usr/sbin
  ln -sf /sbin/dhcpcd ${pkg_prefix}/usr/sbin/dhcpcd

  # Install License
  install -d ${pkg_prefix}/usr/share/licenses/$pkg_name
  sed 26q ${CACHE_PATH}/$pkg_name-$pkg_version/control.h \
        >> ${pkg_prefix}/usr/share/licenses/${pkg_name}/LICENSE

  # Set Options in /etc/dhcpcd.conf
  echo noipv4ll >> ${pkg_prefix}/etc/dhcpcd.conf # Disable ip4vall

  # install systemd unit
  install -Dm644 ${CACHE_PATH}/dhcpcd@.service ${pkg_prefix}/usr/lib/systemd/system/dhcpcd@.service
  install -Dm644 ${CACHE_PATH}/dhcpcd.service ${pkg_prefix}/usr/lib/systemd/system/dhcpcd.service
}
