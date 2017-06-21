pkg_origin=cosmos

pkg_name=nbd
pkg_version=3.15.3
pkg_description="Tools for network block devices, allowing you to use remote block devices over TCP/IP."
pkg_upstream_url="http://nbd.sourceforge.net"
pkg_license=('GPL')
pkg_source=("https://downloads.sourceforge.net/nbd/${pkg_name}-${pkg_version}.tar.xz"
        'config'
        'nbd.service')
pkg_deps=('glib2')
pkg_shasum=('c2d088df6d0d2b487d7aa6f4f138de89'
         '2d05d426b8c2708d5f8a0d028fcbae05'
         '5d1acc143018117174f79eff15afa038')

do_build(){
  
  ./configure --prefix=/usr \
        --sysconfdir=/etc \
        --enable-syslog
  make
}

do_package() {
  make DESTDIR=${pkg_prefix} install

  install -D -m644 ${CACHE_PATH}/config ${pkg_prefix}/etc/nbd-server/config
  install -D -m755 ${CACHE_PATH}/nbd.service ${pkg_prefix}/usr/lib/systemd/system/nbd.service
  install -D -m644 README.md ${pkg_prefix}/usr/share/doc/nbd/README.md
}
