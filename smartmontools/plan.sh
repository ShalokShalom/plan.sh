pkg_origin=cosmos

pkg_name=smartmontools
pkg_version=6.5
pkg_description="Control and monitor S.M.A.R.T. enabled ATA and SCSI Hard Drives"
pkg_upstream_url="http://smartmontools.sourceforge.net"
pkg_license=('GPL')
pkg_deps=('gcc-libs' 'libcap' 'bash')
backup=('etc/smartd.conf'
        'etc/conf.d/smartd')
pkg_source=("http://downloads.sourceforge.net/sourceforge/${pkg_name}/${pkg_name}-${pkg_version}.tar.gz"
        'smartd.conf')
pkg_shasum=('093aeec3f8f39fa9a37593c4012d3156'
         '28c1b80c41dac52d433961dcfb4f70e0')

do_build() {

  ./configure --prefix=/usr \
              --sysconfdir=/etc \
              --with-drivedbdir \
              --with-systemdsystemunitdir=/usr/lib/systemd/system
  make
}

do_package() {

  sed -i -e "s|sysconfig/smartmontools|conf.d/smartd|g" smartd.service
  sed -i -e "s|smartd_opts|SMARTD_ARGS|g" smartd.service

  make DESTDIR=${CACHE_PATH} install

  rm -rf ${CACHE_PATH}/etc/rc.d
  install -Dm644 ../smartd.conf ${CACHE_PATH}/etc/conf.d/smartd
}
