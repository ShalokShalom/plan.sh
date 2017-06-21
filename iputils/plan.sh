pkg_origin=cosmos

pkg_name=iputils
pkg_version=20161105
pkg_description="IP Configuration Utilities (and Ping)."
pkg_license=('GPL')
pkg_upstream_url="http://www.linuxfoundation.org/en/Net:Iputils"
pkg_deps=('glibc' 'openssl' 'sysfsutils' 'libcap')
pkg_build_deps=('libxslt' 'opensp')
backup=(etc/xinetd.d/tftp)
install=${pkg_name}.install
pkg_source=("https://github.com/iputils/iputils/archive/s${pkg_version}.tar.gz"
        'tftp.xinetd')
pkg_shasum=('06f0be2dabe10dc80fdb328073230e69'
         'b5f1b81ea53983c402a46e85501858b3')

do_build() {
  cd ${pkg_name}-s${pkg_version}

  make USE_GNUTLS=no CCOPTOPT="$CFLAGS"
}

do_package() {
  cd ${pkg_name}-s${pkg_version}

  install -dm755 ${pkg_prefix}/usr/{bin,sbin} ${pkg_prefix}/bin

  install -m755 arping clockdiff rarpd rdisc tftpd tracepath traceroute6 \
    ${pkg_prefix}/usr/sbin/

  install -m755 ping ${pkg_prefix}/usr/bin/
   ln -sf /usr/bin/ping  ${pkg_prefix}/bin/

  install -dm755 ${pkg_prefix}/etc/xinetd.d/
  install -m644 ${CACHE_PATH}/tftp.xinetd ${pkg_prefix}/etc/xinetd.d/tftp
}

